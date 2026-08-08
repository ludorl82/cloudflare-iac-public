# Phase 4: the four custom (kind=zone) rulesets, adopted as-is — including
# the family.example WebDAV protections built after the 2026-07-09 lockout
# incident (rate limit + geo restriction + the kill-switch rule, preserved in
# whatever enabled/disabled state it was imported in). Cloudflare-managed WAF
# rulesets are not imported. Historically these were edited via dashboard
# because API edits were painful; now that the exact live rules are code,
# prefer editing here — the 0-change import proves the representation is
# faithful.

resource "cloudflare_ruleset" "family_example_ratelimit" {
  description = ""
  kind        = "zone"
  name        = "default"
  phase       = "http_ratelimit"
  rules = [
    {
      action = "block"
      action_parameters = {
      }
      description = "kp-webdav-ratelimit"
      enabled     = true
      expression  = "(http.host eq \"vault.family.example\")"
      ratelimit = {
        characteristics     = ["ip.src", "cf.colo.id"]
        mitigation_timeout  = 10
        period              = 10
        requests_per_period = 20
        requests_to_origin  = false
      }
      ref = "00000000000000000000000000000027"
    },
  ]
  zone_id = "0000000000000000000000000000004c"
}

resource "cloudflare_ruleset" "labodeludo_dev_firewall" {
  description = ""
  kind        = "zone"
  name        = "default"
  phase       = "http_request_firewall_custom"
  rules = [
    {
      action = "block"
      action_parameters = {
      }
      description = "block spammers and threats"
      enabled     = true
      expression  = "(cf.threat_score ge 10)"
      ref         = "0000000000000000000000000000003e"
    },
    {
      action = "managed_challenge"
      action_parameters = {
      }
      description = "Auto challenge whitelist ips"
      enabled     = true
      expression  = "(ip.src in $whitelist and http.request.uri.path in {\"/wp-admin\" \"/wp-login.php\" \"/api\"})"
      ref         = "0000000000000000000000000000004a"
    },
    {
      action = "js_challenge"
      action_parameters = {
      }
      description = "Interactive challenge otherwise"
      enabled     = true
      expression  = "(http.request.uri.path in {\"/wp-admin\" \"/api\" \"/wp-login.php\"})"
      ref         = "00000000000000000000000000000065"
    },
  ]
  zone_id = "00000000000000000000000000000066"
}

resource "cloudflare_ruleset" "pub_example_com_firewall" {
  description = ""
  kind        = "zone"
  name        = "default"
  phase       = "http_request_firewall_custom"
  rules = [
    {
      action = "block"
      action_parameters = {
      }
      description = "Geo-restrict plex.pub.example.com and ntfy.pub.example.com to Canada only"
      enabled     = true
      expression  = "(http.host eq \"plex.pub.example.com\" or http.host eq \"ntfy.pub.example.com\") and ip.src.country ne \"CA\""
      ref         = "0000000000000000000000000000007f"
    },
  ]
  zone_id = "00000000000000000000000000000059"
}

resource "cloudflare_ruleset" "family_example_firewall" {
  description = ""
  kind        = "zone"
  name        = "default"
  phase       = "http_request_firewall_custom"
  rules = [
    {
      action = "block"
      action_parameters = {
      }
      description = "block spammers and threats"
      enabled     = true
      expression  = "(cf.threat_score ge 10)"
      ref         = "00000000000000000000000000000047"
    },
    {
      action = "block"
      action_parameters = {
      }
      description = "Zone lockdown [Template]"
      enabled     = true
      expression  = "(not ip.src in $whitelist and http.request.uri.path in {\"/api\" \"/auth\"})"
      ref         = "0000000000000000000000000000004f"
    },
    {
      action = "block"
      action_parameters = {
      }
      description = "geo-block vault.family.example to Canada only"
      enabled     = true
      expression  = "(http.host eq \"vault.family.example\" and ip.src.country ne \"CA\")"
      ref         = "0000000000000000000000000000003a"
    },
  ]
  zone_id = "0000000000000000000000000000004c"
}
