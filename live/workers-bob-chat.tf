# gpu-01-chat — the chat endpoint behind "Parler à gpu-01" on labodeludo.dev.
#
# The account's first Worker and first rate-limit binding. Everything here is
# tofu-owned except the Cloudflare Access service-token pair, set out of band so
# it lands in neither git nor state.
#
# The KV namespace and the AWS credentials went with Bedrock on 2026-09-07: the
# namespace held one key, a per-day spend counter, and there is no spend to
# count now that gpu-01 runs on the lab's own GPU.
#
# The Worker source is plain single-file ESM with no build step, because
# content_sha256 has to be computable at PLAN time from a bare checkout. See the
# header comment in workers/gpu-01-chat/index.js.

# Counting what visitors ask, so the suggested questions on the author page can
# be real ones instead of four guesses written in July.
#
# A KV namespace was removed from this file on 2026-09-07 (the Bedrock spend
# counter) and this is not it coming back: different data, different lifetime,
# different reason. What lands here is a per-day tally of question text with a
# 35-day TTL and no identifier of any kind — the Worker's ingest filter drops
# anything address-shaped before it is ever written.
resource "cloudflare_workers_kv_namespace" "gpu-01_questions" {
  account_id = var.account_id
  title      = "gpu-01-questions"
}

resource "cloudflare_workers_script" "gpu-01_chat" {
  account_id  = var.account_id
  script_name = "gpu-01-chat"

  content_file   = "${path.module}/workers/gpu-01-chat/index.js"
  content_sha256 = filesha256("${path.module}/workers/gpu-01-chat/index.js")
  main_module    = "index.js"

  compatibility_date = "2026-09-01"

  # A Workers upload replaces the ENTIRE binding set, so anything absent from
  # this list is dropped. CF_ACCESS_CLIENT_ID, CF_ACCESS_CLIENT_SECRET and
  # POPULAR_TOKEN are set out of band and would be wiped by the next apply
  # without this — see
  # provider issues #5892 and #2393. Never give secret_text a real value here:
  # that writes the credential into terraform.tfstate in S3.
  keep_bindings = ["secret_text"]

  bindings = [
    {
      name         = "BOB_QUESTIONS"
      type         = "kv_namespace"
      namespace_id = cloudflare_workers_kv_namespace.gpu-01_questions.id
    },
    {
      # Deters casual hammering and nothing more: this counts per Cloudflare
      # location and the docs say outright it is not an accurate accounting
      # system. `period` accepts only 10 or 60.
      name         = "BOB_RL"
      type         = "ratelimit"
      namespace_id = "1101"
      simple = {
        limit  = 6
        period = 60
      }
    },
  ]
}

# Two patterns, one zone. Routes override the origin, so the same Worker serves
# the S3-backed prod site and the Pages-backed staging site — which is why this
# is a Worker route rather than a Pages Function (those are staging-only).
#
# Changing a `pattern` later is ForceNew: the apply workflow's destroy gate will
# refuse it, deliberately, because a route change is a traffic change.
resource "cloudflare_workers_route" "gpu-01_dev" {
  zone_id = local.labodeludo_dev_zone_id
  pattern = "dev.labodeludo.dev/api/gpu-01/*"
  script  = cloudflare_workers_script.gpu-01_chat.script_name
}

# Added 2026-09-06, once the widget was proven on staging: real Bedrock answers,
# prompt caching confirmed through the live path, and validated slug links. This
# lands together with SHOW_BOB_CHAT in the site's prod deploy job — the route
# without the widget serves nothing, and the widget without the route is a box
# that posts to a 404.
resource "cloudflare_workers_route" "gpu-01_prod" {
  zone_id = local.labodeludo_dev_zone_id
  pattern = "labodeludo.dev/api/gpu-01/*"
  script  = cloudflare_workers_script.gpu-01_chat.script_name
}

locals {
  labodeludo_dev_zone_id = "00000000000000000000000000000066"
}
