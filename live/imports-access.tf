# Access applications import as accounts/<account_id>/<app_id>.
# App-scoped policies come along inside the application resource (v5).

import {
  to = cloudflare_zero_trust_access_application.cronicle
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000018"
}

import {
  to = cloudflare_zero_trust_access_application.n8n
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000005"
}

import {
  to = cloudflare_zero_trust_access_application.pfsense_passerelle
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000019"
}

import {
  to = cloudflare_zero_trust_access_application.traefik_dashboard
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000016"
}

import {
  to = cloudflare_zero_trust_access_application.unifi_network_application
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000007"
}

import {
  to = cloudflare_zero_trust_access_application.kuma_dashboard
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000009"
}

import {
  to = cloudflare_zero_trust_access_application.frigate_nvr
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000004"
}

import {
  to = cloudflare_zero_trust_access_application.grafana
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-00000000000b"
}

import {
  to = cloudflare_zero_trust_access_application.netalertx
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000012"
}

import {
  to = cloudflare_zero_trust_access_application.netbox
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-000000000011"
}

import {
  to = cloudflare_zero_trust_access_application.labodeludo_dev_staging
  id = "accounts/00000000000000000000000000000002/00000000-0000-0000-0000-00000000000d"
}

