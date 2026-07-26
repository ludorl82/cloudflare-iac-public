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
      id         = "00000000-0000-0000-0000-000000000017"
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
      id         = "00000000-0000-0000-0000-000000000006"
      precedence = 2
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
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
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000008"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "traefik_dashboard" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "traefik.pub.example.com"
    },
  ]
  domain                     = "traefik.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Traefik dashboard"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000003"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

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
      id         = "00000000-0000-0000-0000-00000000000c"
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
      id         = "00000000-0000-0000-0000-000000000014"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "netbox" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "netbox.pub.example.com"
    },
  ]
  domain                     = "netbox.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "NetBox"
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

resource "cloudflare_zero_trust_access_application" "netalertx" {
  account_id                = "00000000000000000000000000000002"
  app_launcher_visible      = true
  auto_redirect_to_identity = false
  destinations = [
    {
      type = "public"
      uri  = "netalertx.pub.example.com"
    },
  ]
  domain                     = "netalertx.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "NetAlertX"
  options_preflight_bypass   = false
  policies = [
    {
      id         = "00000000-0000-0000-0000-000000000002"
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}
