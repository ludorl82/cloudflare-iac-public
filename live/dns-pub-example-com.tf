# pub.example.com DNS — the public zone (see dns-domain-split: lab.example is private,
# pfSense-only). Imported 2026-07-26 from live; 14 records.
#
# Every web service is a proxied CNAME into a Cloudflare Tunnel. Two tunnels
# exist: "k3s" (adc38d86, in-cluster cloudflared — where new services go) and
# the legacy aws tunnel (2fef02a3 — router, plex, traefik still ride it).
# Adding a service = one entry in local.tunnel_hosts.

locals {
  pub_example_com_zone_id = "0000000000000000000000000000005a"

  tunnel_k3s    = "00000000-0000-0000-0000-000000000015.cfargotunnel.com"
  tunnel_legacy = "00000000-0000-0000-0000-00000000000a.cfargotunnel.com"

  tunnel_hosts = {
    cronicle  = local.tunnel_k3s
    frigate   = local.tunnel_k3s
    grafana   = local.tunnel_k3s
    kuma      = local.tunnel_k3s
    n8n       = local.tunnel_k3s
    netalertx = local.tunnel_k3s
    netbox    = local.tunnel_k3s
    ntfy      = local.tunnel_k3s
    router    = local.tunnel_legacy
    plex      = local.tunnel_legacy
    traefik   = local.tunnel_legacy
    unifi     = local.tunnel_k3s
  }
}

resource "cloudflare_dns_record" "tunnel" {
  for_each = local.tunnel_hosts

  zone_id = local.pub_example_com_zone_id
  name    = "${each.key}.pub.example.com"
  type    = "CNAME"
  content = each.value
  proxied = true
  ttl     = 1
}

# The bare aws node, unproxied — WireGuard endpoint and direct SSH; hex-of-
# last-octet IPv6 (::7 for .7). This IP is aws_eip.aws_node in aws-iac.
resource "cloudflare_dns_record" "aws_a" {
  zone_id = local.pub_example_com_zone_id
  name    = "aws.pub.example.com"
  type    = "A"
  content = "192.0.2.10"
  proxied = false
  ttl     = 3600
}

resource "cloudflare_dns_record" "aws_aaaa" {
  zone_id = local.pub_example_com_zone_id
  name    = "aws.pub.example.com"
  type    = "AAAA"
  content = "2001:db8:100:10::7"
  proxied = false
  ttl     = 3600
}
