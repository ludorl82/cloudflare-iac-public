# cloudflare-iac

OpenTofu configuration for the Cloudflare account behind `example.com` and
friends.

**Status: ALL PHASES applied and converged** — 105 records across all 12
non-empty zones (2026-07-26). Six parked zones and lab.example have zero records
(lab.example deliberately: private zone, pfSense-only). Access apps (11), tunnels
(2) and rulesets are readable with the general token — phases 2-4 await.

## Why this is separate from `aws-iac`

Different credentials, different blast radius, different change cadence. A bad
apply here takes down every hostname — including the tunnel the cluster depends
on — so it gets its own state, its own lock and its own apply boundary.

State lives in the **same S3 bucket** as `aws-iac` (`tfstate-example-com`)
under a different key. That means this root needs AWS credentials for state
access only; it manages nothing in AWS.

## Getting started

```sh
nix develop
export CLOUDFLARE_API_TOKEN=$(kp-get "Cloudflare General Token")

cd live
tofu init
```

The token is read from the environment. There is no `api_token` argument in
`providers.tf` on purpose — that is how tokens end up in git.

## Adopting a zone

```sh
export CLOUDFLARE_API_TOKEN=...
./scripts/gen-dns-imports.sh lab.example > live/imports-dns-lab-example.tf
cd live
tofu plan -generate-config-out=generated.tf
```

Review `generated.tf`, fold it into a real file, delete the generated one (it is
gitignored so it cannot be committed raw), and confirm `tofu plan` is empty
before moving on.

## Pre-commit hook

`hooks/pre-commit` runs on every commit once `core.hooksPath` points at
`hooks/` — `nix develop` sets that for you, or `git config core.hooksPath hooks`.

Checks staged content for files that must never be committed (`*.tfstate`,
`*.tfvars`, `.terraform/`, keys), credential shapes (including a literal
`api_token` in a provider block — the thing `providers.tf` deliberately avoids),
`tofu fmt`/`validate`, and shell/JSON/YAML syntax.

Bypass with `git commit --no-verify` when you genuinely need to.

Identical to the copy in `aws-iac`. If it grows much further it should move to a
shared flake input rather than being maintained twice.

## CI: plan on PR, apply on merge

`.github/workflows/` closes the loop the drift check only observes:

- **`plan.yml`** (pull requests): read-only plan, posted as a sticky PR
  comment. AWS state access via OIDC role `gha-cloudflare-iac-plan`
  (defined in `aws-iac/live/iam-github-oidc.tf`); Cloudflare via the repo
  secret `CLOUDFLARE_API_TOKEN` (dedicated `cloudflare-iac-ci` token).
- **`apply.yml`** (push to cp-1): re-plans fresh, then applies — unless the
  plan contains **any destroy**, in which case the job fails and waits for a
  human. Destructive changes are applied deliberately from the console shell;
  the workflow never does them. Role: `gha-cloudflare-iac-apply`, assumable
  only from pushes to this repo's cp-1.

The nightly drift check (Kuma 43) stays: it is now the verification half of
the loop rather than the whole loop.

## Phases

| # | Scope | Status |
|---|---|---|
| 1 | DNS records, all zones | **applied** |
| 2 | Access applications (11; policy rules dashboard-managed, see access-apps.tf) | **applied** |
| 3 | Both tunnels + remote ingress configs | **applied** |
| 4 | Custom rulesets (4: WebDAV protections, challenges) | **applied** |

Start with the **smallest zone**, not the most important one, to shake out the
workflow before touching anything load-bearing.

## Warnings worth reading before phase 1

- **DNS here is authoritative for a homelab that needs DNS to boot.** Phase 1
  touches every record in a zone. A botched apply is a full outage with no
  console to fall back on. Import in small batches; never let a plan you do not
  fully understand reach `apply`.
- **`lab.example` and `pub.example.com` are parallel zones** — same hostnames, private
  IPs in one and public in the other. They will look confusingly similar in
  diffs. Keep them in separate files and separate PRs.
- **Provider v5 is a rewrite.** Schemas changed a lot from v4 and most examples
  online are still v4. Registry docs only.
- **Rulesets are the hard part.** The July 2026 WebDAV lockout ended with
  ruleset edits being made through the dashboard because the API path was
  painful. Leaving a ruleset dashboard-managed with a comment saying so is a
  legitimate outcome — better than a half-adopted ruleset that fights every
  plan. Do these last, if at all.
- **Zone-scoped tokens report zero accounts** on `/accounts`. That is a false
  negative, not a broken token or a wrong account id.

## Not managed here

- `shrt.example` DNS — that zone is in **Route53**, not Cloudflare. It belongs to
  `aws-iac` phase 5, along with its CloudFront distribution.
