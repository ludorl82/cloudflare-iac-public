# Import ids are zone_id/record_id; record ids only exist via the API
# (scripts/gen-dns-imports.sh regenerates this shape).

import {
  to = cloudflare_dns_record.aws_a
  id = "0000000000000000000000000000005a/00000000000000000000000000000004"
}

import {
  to = cloudflare_dns_record.aws_aaaa
  id = "0000000000000000000000000000005a/0000000000000000000000000000005b"
}

import {
  to = cloudflare_dns_record.tunnel["cronicle"]
  id = "0000000000000000000000000000005a/0000000000000000000000000000000a"
}

import {
  to = cloudflare_dns_record.tunnel["frigate"]
  id = "0000000000000000000000000000005a/0000000000000000000000000000007f"
}

import {
  to = cloudflare_dns_record.tunnel["grafana"]
  id = "0000000000000000000000000000005a/0000000000000000000000000000001d"
}

import {
  to = cloudflare_dns_record.tunnel["kuma"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000016"
}

import {
  to = cloudflare_dns_record.tunnel["n8n"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000073"
}

import {
  to = cloudflare_dns_record.tunnel["netalertx"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000039"
}

import {
  to = cloudflare_dns_record.tunnel["netbox"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000075"
}

import {
  to = cloudflare_dns_record.tunnel["ntfy"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000024"
}

import {
  to = cloudflare_dns_record.tunnel["router"]
  id = "0000000000000000000000000000005a/0000000000000000000000000000003e"
}

import {
  to = cloudflare_dns_record.tunnel["plex"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000047"
}

import {
  to = cloudflare_dns_record.tunnel["traefik"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000081"
}

import {
  to = cloudflare_dns_record.tunnel["unifi"]
  id = "0000000000000000000000000000005a/00000000000000000000000000000058"
}

