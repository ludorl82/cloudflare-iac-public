# personal-06.example DNS — imported from live 2026-07-26 (9 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "personal_06_example_txt_5c4c1e" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "personal-06.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "personal_06_example_txt_fbf2ed" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "personal-06.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "personal_06_example_mx_2f5cdf" {
  content  = "mx2.forwardemail.net"
  name     = "personal-06.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "autoconfig_personal_06_example_cname_35685a" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.personal-06.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "personal_06_example_mx_483ab9" {
  content  = "mx1.forwardemail.net"
  name     = "personal-06.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "autodiscover_personal_06_example_cname_4b5793" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.personal-06.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "_dmarc_personal_06_example_txt_d711f2" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.personal-06.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "fe_bounces_personal_06_example_cname_32433b" {
  content = "forwardemail.net"
  name    = "fe-bounces.personal-06.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000006c"
}

resource "cloudflare_dns_record" "fe_bc085454b0__domainkey_personal_06_example_txt_0c2433" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-bc085454b0._domainkey.personal-06.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000006c"
}
