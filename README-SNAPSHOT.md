# Sanitized snapshot

This is a **sanitized, read-only snapshot** of the private OpenTofu repository
that manages my Cloudflare account, published as a companion to the
infrastructure-as-code writing on [labodeludo.dev](https://labodeludo.dev/).

It is one of three: [nixos-iac-public](https://github.com/ludorl82/nixos-iac-public)
holds the machines, [k3s-iac-public](https://github.com/ludorl82/k3s-iac-public)
holds the workloads, [aws-iac-public](https://github.com/ludorl82/aws-iac-public)
holds the AWS account, and this one holds the edge in front of all of it.

## What is fictional

Every zone id, account id, tunnel id, Access policy id and ruleset ref;
every DKIM key, DMARC reporting address and site-verification token; every
IP address (RFC 5737 / RFC 3849); and every domain name except
`labodeludo.dev` and `labodeludo.com`, which are the site this is published
from and are public in DNS anyway. The personal and family zones are
renumbered to `personal-0N.example` — the OpenTofu is the interesting part,
not the surnames.

Because a whitelist gate refuses to publish any DNS record value the
sanitizer did not deliberately produce, a missed rule fails the build rather
than leaking quietly.

## What is real

Every comment. The v5-provider limitation on legacy app-scoped Access
policies, the note about why the tunnels are remotely managed, the WebDAV
rate-limit rules that exist because of a real lockout incident — those are
the parts worth reading.

Published to be read, not deployed, and not kept in sync with the private
original.
