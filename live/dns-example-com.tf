# example.com DNS — imported from live 2026-07-26 (6 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "router_example_com_aaaa_0c3317" {
  content = "2001:db8:50:a::1"
  name    = "router.example.com"
  proxied = false
  ttl     = 3600
  type    = "AAAA"
  zone_id = "0000000000000000000000000000002c"
}

resource "cloudflare_dns_record" "dns_aws_example_com_a_6244ff" {
  content = "192.0.2.10"
  name    = "dns.aws.example.com"
  proxied = false
  ttl     = 3600
  type    = "A"
  zone_id = "0000000000000000000000000000002c"
}

resource "cloudflare_dns_record" "aws_example_com_a_4bba40" {
  content = "192.0.2.10"
  name    = "aws.example.com"
  proxied = false
  ttl     = 3600
  type    = "A"
  zone_id = "0000000000000000000000000000002c"
}

resource "cloudflare_dns_record" "router_local_example_com_a_2ff8c9" {
  content = "192.0.2.254"
  name    = "router-local.example.com"
  proxied = false
  ttl     = 3600
  type    = "A"
  zone_id = "0000000000000000000000000000002c"
}

resource "cloudflare_dns_record" "aws_example_com_aaaa_b62d11" {
  content = "2001:db8:100:10::7"
  name    = "aws.example.com"
  proxied = false
  ttl     = 3600
  type    = "AAAA"
  zone_id = "0000000000000000000000000000002c"
}

resource "cloudflare_dns_record" "router_example_com_a_b4d162" {
  content = "192.0.2.10"
  name    = "router.example.com"
  proxied = false
  ttl     = 3600
  type    = "A"
  zone_id = "0000000000000000000000000000002c"
}
