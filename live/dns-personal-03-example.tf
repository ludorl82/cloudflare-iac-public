# personal-03.example DNS — imported from live 2026-07-26 (10 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "personal_03_example_a_58eabe" {
  content = "192.0.2.10"
  name    = "personal-03.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "google__domainkey_personal_03_example_txt_3d0525" {
  content = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;"
  name    = "google._domainkey.personal-03.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_mx_b3f944" {
  content  = "aspmx.l.google.com"
  name     = "personal-03.example"
  priority = 1
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_mx_615eea" {
  content  = "alt1.aspmx.l.google.com"
  name     = "personal-03.example"
  priority = 5
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_mx_afbde8" {
  content  = "alt4.aspmx.l.google.com"
  name     = "personal-03.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_txt_f2537b" {
  content = "\"v=spf1 include:_spf.google.com ~all\""
  name    = "personal-03.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "www_personal_03_example_a_0c313e" {
  content = "192.0.2.10"
  name    = "www.personal-03.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "_dmarc_personal_03_example_txt_7e1e65" {
  content = "v=DMARC1; p=reject; rua=mailto:dmarc@example.com; ruf=mailto:dmarc@example.com; fo=1; pct=100"
  name    = "_dmarc.personal-03.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_mx_5fcbbc" {
  content  = "alt2.aspmx.l.google.com"
  name     = "personal-03.example"
  priority = 5
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000069"
}

resource "cloudflare_dns_record" "personal_03_example_mx_c117c3" {
  content  = "alt3.aspmx.l.google.com"
  name     = "personal-03.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000069"
}
