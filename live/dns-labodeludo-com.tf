# labodeludo.com DNS — imported from live 2026-07-26 (1 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "labodeludo_com_a_abda45" {
  content = "192.0.2.10"
  name    = "labodeludo.com"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000057"
}
