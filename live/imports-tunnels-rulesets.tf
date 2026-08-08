# Phase 3: the two remotely-managed tunnels + their ingress configurations.
# Phase 4: the four custom (kind=zone) rulesets. Managed WAF rulesets are
# Cloudflare's own and are not imported.

import {
  to = cloudflare_zero_trust_tunnel_cloudflared.k3s
  id = "00000000000000000000000000000002/00000000-0000-0000-0000-000000000011"
}

import {
  to = cloudflare_zero_trust_tunnel_cloudflared_config.k3s
  id = "00000000000000000000000000000002/00000000-0000-0000-0000-000000000011"
}

import {
  to = cloudflare_ruleset.labodeludo_dev_firewall
  id = "zones/00000000000000000000000000000066/00000000000000000000000000000007"
}

import {
  to = cloudflare_ruleset.family_example_firewall
  id = "zones/0000000000000000000000000000004c/00000000000000000000000000000063"
}

import {
  to = cloudflare_ruleset.family_example_ratelimit
  id = "zones/0000000000000000000000000000004c/00000000000000000000000000000053"
}

import {
  to = cloudflare_ruleset.pub_example_com_firewall
  id = "zones/00000000000000000000000000000059/00000000000000000000000000000077"
}
