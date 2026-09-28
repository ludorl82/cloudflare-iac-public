# Access applications (phase 2) — imported 2026-07-26. 11 self-hosted apps,
# all OTP-gated per the pub.example.com Access doctrine (audited hourly by the
# access-audit CronJob).
#
# LIMITATION, deliberate: policies are wired by ID + precedence only. All 12
# policies are legacy app-scoped objects, which provider v5 cannot import or
# manage (cloudflare_zero_trust_access_policy is reusable-policies-only —
# probe returned "invalid ID"). The RULES inside them (who may log in) remain
# dashboard-managed until the policies are recreated as reusable ones; do that
# migration deliberately, not as an import side effect.

resource "cloudflare_zero_trust_access_application" "unifi_network_application" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "unifi.pub.example.com"
    },
  ]
  domain                     = "unifi.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "UniFi Network Application"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000013"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "kuma_dashboard" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "kuma.pub.example.com"
    },
  ]
  domain                     = "kuma.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Kuma dashboard"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000001"
      precedence = 1
    },
    {
      id         = "00000000-0000-0000-0000-000000000004"
      precedence = 2
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

# Kuma push endpoint — the one machine-to-machine hole in the Access wall.
#
# The drift checks run on GitHub-hosted runners (2026-08-07) and report by
# pushing to Kuma. LAN callers reach kuma.lab.example over private DNS and never
# touch Cloudflare; a runner has no such path, and its source address can never
# be on an IP-list bypass. So this app is scoped to the /api/push PATH only and
# gated by a service token — the runner sends CF-Access-Client-Id/Secret.
#
# Path scoping is load-bearing: this app is more specific than "Kuma dashboard"
# (whole host, OTP) and therefore wins for /api/push, while the dashboard stays
# human-only. Widening this app's path would hand the dashboard to a token.
#
# Unlike the legacy app-scoped policies noted at the top of this file, the
# policy here IS a reusable one (f760a154…, decision non_identity, include =
# service token kuma-push-gha, expires 2034-12-31), created via the API because
# provider v5 cannot create app-scoped rules. It is referenced by ID like all
# the others.
resource "cloudflare_zero_trust_access_application" "kuma_push" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = false
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "kuma.pub.example.com/api/push"
    },
  ]
  domain                     = "kuma.pub.example.com/api/push"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Kuma push (service token)"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000016"
      precedence = 1
    },
  ]
  session_duration = "0s" # service tokens carry no session; re-auth per request
  type             = "self_hosted"
}

# Skips the OTP screen for requests coming from the house, so staging is one
# click from any machine here (and from Claude-in-Chrome, which was the actual
# complaint). Everywhere else still meets the login.
#
# bypass = NO authentication for those addresses, which includes anyone on the
# house wifi. Staging is a copy of a public blog, so that is an accepted trade
# rather than an oversight — do not copy this policy onto an app that guards
# anything real.
#
# WHY LITERAL CIDRs AND NOT ip_list, learned the expensive way 2026-09-09:
# this first pointed at the account IP list "whitelist"
# (00000000000000000000000000000078) that the WAF reads as $whitelist. It
# applied clean, sat at precedence 1, and matched NOTHING — Cloudflare reported
# the caller as exactly the address the list held and still served the login
# page. That list lives in the RULES namespace (/accounts/../rules/lists);
# Access documents only "IP ranges", i.e. literal CIDRs, and accepted the list
# id without ever resolving it. A silent no-op, so assume nothing here is
# working until a request has actually gone through unauthenticated.
#
# WHO OWNS include: tofu, for now. The plan was to hand it to
# wan-ip-sync.timer on pi-02 (it already chases this address for the WAF
# list) behind `lifecycle { ignore_changes = [include] }`. Two things stopped
# that, both worth knowing before trying again:
#
#   1. The token the timer uses, "Cloudflare Kuma Access IP Sync", can list
#      Access policies but cannot read or write an individual one — the PUT
#      comes back 1010 auth.forbidden. It needs Access: Apps and Policies
#      (read + edit) before the script can own this field.
#   2. ignore_changes with a bad value already in state is a trap: the first
#      apply wrote the ip_list form into state, and ignore_changes then made
#      every later apply resend that same invalid include, which the API now
#      rejects outright ("invalid ip_list rule"). It turned a wrong value into
#      a stuck one and took CI red with it.
#
# So the literal addresses live here and an ISP renumber is a visible apply,
# caught by the drift check, rather than a silent lockout. Re-add
# ignore_changes only once the token can write and state holds a VALID value.
#
# Both families are listed on purpose: drop the v6 half and a browser that
# prefers IPv6 quietly gets the login screen back.
resource "cloudflare_zero_trust_access_policy" "home_ip_bypass" {
  account_id = "00000000000000000000000000000002"
  decision   = "bypass"
  name       = "Home IP bypass (staging)"
  include = [
    {
      ip = {
        ip = "192.0.2.10/32"
      }
    },
    {
      ip = {
        ip = "2001:db8:50:a::1/56"
      }
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "labodeludo_dev_staging" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "dev.labodeludo.dev"
    },
  ]
  domain                     = "dev.labodeludo.dev"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "labodeludo.dev staging"
  options_preflight_bypass   = false
  # Order is the whole mechanism: the bypass must be evaluated BEFORE the OTP
  # policy, or the login screen wins and nothing changes. The OTP policy keeps
  # its dashboard-managed rules — only its precedence moves.
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.home_ip_bypass.id
      precedence = 1
    },
    {
      id         = "00000000-0000-0000-0000-000000000006"
      precedence = 2
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

# The "Traefik dashboard" app (traefik.pub.example.com) was removed 2026-08-06 along
# with aws's Docker Traefik — the dashboard it fronted no longer exists, and the
# in-cluster Traefik deliberately does not expose one.

resource "cloudflare_zero_trust_access_application" "grafana" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "grafana.pub.example.com"
    },
  ]
  domain                     = "grafana.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Grafana"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000010"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "cronicle" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "cronicle.pub.example.com"
    },
  ]
  domain                     = "cronicle.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Cronicle"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-00000000000f"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "frigate_nvr" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "frigate.pub.example.com"
    },
  ]
  domain                     = "frigate.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Frigate NVR"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-00000000000e"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "n8n" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "n8n.pub.example.com"
    },
  ]
  domain                     = "n8n.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "n8n"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-00000000000a"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "pfsense_passerelle" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "router.pub.example.com"
    },
  ]
  domain                     = "router.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "pfSense (router)"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000011"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

# netbox + netalertx Access apps destroyed 2026-07-27 — both services
# decommissioned (their app-scoped policies were deleted with the apps).

# The staging site's public mirror. Cloudflare Pages serves every project at
# <project>.pages.dev whether you want it or not, so labodeludo-dev.pages.dev
# is a second, ungated copy of everything behind dev.labodeludo.dev. Pages' own
# "enable access policy" toggle does NOT cover it — that one protects preview
# deployments only, which is documented and easy to misread. This app is what
# actually closes it.
#
# The deploy pins --branch=staging (the project's production branch) so preview
# deployments are never created at all; if that ever changes, previews land on
# their own <hash>.pages.dev URLs and this app will not cover those either.
#
# Note the policy: this is the account's FIRST reusable one. The twelve legacy
# app-scoped policies cannot be shared or managed by provider v5 (see the header
# of this file), so the existing "Ludo OTP login" could not be attached to a
# second app — hence a reusable twin with the same single include rule, wired to
# the same identity. Recreating the legacy twelve this way is the migration the
# header describes; this is not that migration, just the first object that had
# no other option.
resource "cloudflare_zero_trust_access_policy" "ludo_otp_login_reusable" {
  account_id = "00000000000000000000000000000002"
  decision   = "allow"
  name       = "Ludo OTP login (reusable)"
  # Spelled out to match the application above. The API left this unset when the
  # policy was created, and the provider plans it as "24h" regardless — so the
  # first apply writes it either way. Declaring it makes that an intended value
  # rather than a default silently materializing into a live auth object.
  session_duration = "24h"
  include = [
    {
      email = {
        email = "c31a61b@personal-05.example"
      }
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "labodeludo_dev_staging_pages" {
  account_id                 = "00000000000000000000000000000002"
  app_launcher_visible       = false
  auto_redirect_to_identity  = false
  domain                     = "labodeludo-dev.pages.dev"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "labodeludo.dev staging (pages.dev)"
  options_preflight_bypass   = false
  # Same bypass as the custom domain above, for the same reason: leaving it off
  # here means the *.pages.dev twin still shows the login screen, and the two
  # names serve identical content — a barrier on one of them protects nothing
  # while being an inconsistency someone has to rediscover later.
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.home_ip_bypass.id
      precedence = 1
    },
    {
      id         = cloudflare_zero_trust_access_policy.ludo_otp_login_reusable.id
      precedence = 2
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}
