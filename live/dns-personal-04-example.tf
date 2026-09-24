# personal-04.example DNS — imported from live 2026-07-26 (4 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "client_personal_04_example_a_32a1d6" {
  content = "192.0.2.10"
  name    = "client.personal-04.example"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0000000000000000000000000000006a"
}

resource "cloudflare_dns_record" "_db0689e9520050ec2eb069db536a8dea_personal_04_example_cname_258dc8" {
  content = "dcv.sectigo.example"
  name    = "_db0689e9520050ec2eb069db536a8dea.personal-04.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000006a"
}

resource "cloudflare_dns_record" "personal_04_example_a_3aeb54" {
  content = "192.0.2.10"
  name    = "personal-04.example"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0000000000000000000000000000006a"
}

resource "cloudflare_dns_record" "www_personal_04_example_a_edf7eb" {
  content = "192.0.2.10"
  name    = "www.personal-04.example"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0000000000000000000000000000006a"
}
