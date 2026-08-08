# Access applications import as accounts/<account_id>/<app_id>.
# App-scoped policies come along inside the application resource (v5).

import {
  to = cloudflare_zero_trust_access_application.cronicle
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000013"
}

import {
  to = cloudflare_zero_trust_access_application.n8n
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000003"
}

import {
  to = cloudflare_zero_trust_access_application.pfsense_passerelle
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000014"
}

import {
  to = cloudflare_zero_trust_access_application.unifi_network_application
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000005"
}

import {
  to = cloudflare_zero_trust_access_application.kuma_dashboard
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000007"
}

import {
  to = cloudflare_zero_trust_access_application.frigate_nvr
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000002"
}

import {
  to = cloudflare_zero_trust_access_application.grafana
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000008"
}

import {
  to = cloudflare_zero_trust_access_application.labodeludo_dev_staging
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-00000000000c"
}


# Created by API 2026-08-07 during the staging-to-Pages move, then imported —
# the pages.dev mirror was live and ungated, so it was closed first and
# declared second.
#
# Mind the two ID formats: applications take `accounts/<account_id>/<app_id>`,
# reusable policies take a bare `<account_id>/<policy_id>` with no `accounts/`
# prefix. Using the application form for the policy fails the plan with a bare
# `Error: invalid ID` that names neither the resource nor the expected shape —
# the same unhelpful message the file header records from probing the legacy
# app-scoped policies, which is a misleading coincidence: there it meant "not
# importable at all", here it only meant "wrong format".
import {
  to = cloudflare_zero_trust_access_application.labodeludo_dev_staging_pages
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000009"
}

import {
  to = cloudflare_zero_trust_access_policy.ludo_otp_login_reusable
  id = "00000000000000000000000000000002/00000000-0000-0000-0000-00000000000b"
}
