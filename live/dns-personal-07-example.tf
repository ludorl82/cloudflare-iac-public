# personal-07.example DNS — imported from live 2026-07-26 (9 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "personal_07_example_mx_4325d4" {
  content  = "mx1.forwardemail.net"
  name     = "personal-07.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "autodiscover_personal_07_example_cname_30de57" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.personal-07.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "_dmarc_personal_07_example_txt_ebd892" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.personal-07.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "personal_07_example_txt_0d5b6a" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "personal-07.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "fe_bounces_personal_07_example_cname_e91a0a" {
  content = "forwardemail.net"
  name    = "fe-bounces.personal-07.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "autoconfig_personal_07_example_cname_59eb5d" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.personal-07.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "fe_f1f782566a__domainkey_personal_07_example_txt_2f7b31" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-f1f782566a._domainkey.personal-07.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "personal_07_example_mx_4bd72c" {
  content  = "mx2.forwardemail.net"
  name     = "personal-07.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000049"
}

resource "cloudflare_dns_record" "personal_07_example_txt_319998" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "personal-07.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000049"
}
