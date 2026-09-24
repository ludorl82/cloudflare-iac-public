# ollama.pub.example.com — the local fallback brain for labodeludo.dev's chat widget.
#
# The gate lands BEFORE the DNS record and tunnel ingress rule, deliberately and
# in a separate apply. Creating the hostname first would leave a window with an
# unauthenticated Ollama on the public internet, and Ollama's API is not
# read-only: it carries /api/pull, /api/create and /api/delete.
#
# Two applications, mirroring the kuma dashboard/push pair:
#
#   1. the whole host, on the human OTP policy — so every path that is not
#      explicitly opened below is closed;
#   2. /api/chat and /api/embed only, on a service-token policy — the two
#      machine-to-machine holes, both used by the gpu-01-chat Worker. /api/embed
#      was opened on 2026-09-11 for semantic search: the Worker embeds each
#      visitor question with bge-m3 so it can rank the corpus chunks the site
#      publishes. It is a second inference path, nothing more — it reads no
#      model and writes nothing.
#
# The ordering is what makes this safe, and it is the opposite of the obvious
# mistake: scoping ONLY the narrow path and leaving the host ungated would open
# the admin API to the world while looking locked down.

# Reusable, and tofu-managed rather than a hand-created UUID like the legacy
# twelve — v5 can create reusable policies, as ludo_otp_login_reusable proves.
# The token itself is NOT declared here: creating it in tofu would write its
# client_secret into terraform.tfstate in S3. It was minted out of band and is
# referenced by id, which is not a secret.
resource "cloudflare_zero_trust_access_policy" "ollama_service_token" {
  account_id = var.account_id
  decision   = "non_identity"
  name       = "gpu-01-chat service token (ollama)"

  include = [
    {
      service_token = {
        token_id = "00000000-0000-0000-0000-00000000000b"
      }
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "ollama_host" {
  account_id                 = var.account_id
  app_launcher_visible       = false
  auto_redirect_to_identity  = false
  domain                     = "ollama.pub.example.com"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Ollama (gpu-01) — everything but /api/chat"
  options_preflight_bypass   = false
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.ludo_otp_login_reusable.id
      precedence = 1
    },
  ]
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_application" "ollama_chat" {
  account_id                 = var.account_id
  app_launcher_visible       = false
  auto_redirect_to_identity  = false
  domain                     = "ollama.pub.example.com/api/chat"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Ollama chat (service token)"
  options_preflight_bypass   = false
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.ollama_service_token.id
      precedence = 1
    },
  ]
  # Service tokens carry no session; every request re-authenticates.
  session_duration = "0s"
  type             = "self_hosted"
}

# The second machine-to-machine hole. Separate application rather than a
# widened domain on the one above, because Access matches a path prefix: a
# single app on "ollama.pub.example.com/api/" would have covered /api/pull and
# /api/delete too, which is exactly what the WAF rule exists to prevent. Two
# narrow apps say what is open; one broad one would only look like it did.
resource "cloudflare_zero_trust_access_application" "ollama_embed" {
  account_id                 = var.account_id
  app_launcher_visible       = false
  auto_redirect_to_identity  = false
  domain                     = "ollama.pub.example.com/api/embed"
  enable_binding_cookie      = false
  http_only_cookie_attribute = true
  name                       = "Ollama embed (service token)"
  options_preflight_bypass   = false
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.ollama_service_token.id
      precedence = 1
    },
  ]
  # Service tokens carry no session; every request re-authenticates.
  session_duration = "0s"
  type             = "self_hosted"
}
