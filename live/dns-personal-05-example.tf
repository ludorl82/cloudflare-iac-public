# personal-05.example DNS — imported from live 2026-07-26 (10 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "personal_05_example_mx_b61f26" {
  content  = "mx1.forwardemail.net"
  name     = "personal-05.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "personal_05_example_a_02776d" {
  content = "192.0.2.10"
  name    = "personal-05.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "personal_05_example_mx_d62f0b" {
  content  = "mx2.forwardemail.net"
  name     = "personal-05.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "fe_6b2d8c7a51__domainkey_personal_05_example_txt_faf0d8" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-6b2d8c7a51._domainkey.personal-05.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "fe_bounces_personal_05_example_cname_a080ee" {
  content = "forwardemail.net"
  name    = "fe-bounces.personal-05.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "_dmarc_personal_05_example_txt_7f65d1" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.personal-05.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "autoconfig_personal_05_example_cname_fe3a7e" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.personal-05.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "personal_05_example_txt_b28cc6" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "personal-05.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "personal_05_example_txt_824c13" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "personal-05.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000013"
}

resource "cloudflare_dns_record" "autodiscover_personal_05_example_cname_a5aefb" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.personal-05.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000013"
}
