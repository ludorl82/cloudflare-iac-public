# Import ids are zone_id/record_id; record ids only exist via the API
# (scripts/gen-dns-imports.sh regenerates this shape).

import {
  to = cloudflare_dns_record.aws_a
  id = "00000000000000000000000000000059/00000000000000000000000000000004"
}

import {
  to = cloudflare_dns_record.aws_aaaa
  id = "00000000000000000000000000000059/0000000000000000000000000000005a"
}

import {
  to = cloudflare_dns_record.tunnel["cronicle"]
  id = "00000000000000000000000000000059/0000000000000000000000000000000a"
}

import {
  to = cloudflare_dns_record.tunnel["frigate"]
  id = "00000000000000000000000000000059/0000000000000000000000000000007d"
}

import {
  to = cloudflare_dns_record.tunnel["grafana"]
  id = "00000000000000000000000000000059/0000000000000000000000000000001d"
}

import {
  to = cloudflare_dns_record.tunnel["kuma"]
  id = "00000000000000000000000000000059/00000000000000000000000000000016"
}

import {
  to = cloudflare_dns_record.tunnel["n8n"]
  id = "00000000000000000000000000000059/00000000000000000000000000000072"
}

import {
  to = cloudflare_dns_record.tunnel["ntfy"]
  id = "00000000000000000000000000000059/00000000000000000000000000000024"
}

import {
  to = cloudflare_dns_record.tunnel["router"]
  id = "00000000000000000000000000000059/0000000000000000000000000000003d"
}

import {
  to = cloudflare_dns_record.tunnel["plex"]
  id = "00000000000000000000000000000059/00000000000000000000000000000046"
}

import {
  to = cloudflare_dns_record.tunnel["unifi"]
  id = "00000000000000000000000000000059/00000000000000000000000000000057"
}

