# personal-01.example DNS — imported from live 2026-07-26 (11 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "autodiscover_personal_01_example_cname_fd4791" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.personal-01.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "autoconfig_personal_01_example_cname_575bbc" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.personal-01.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "personal_01_example_a_781341" {
  content = "192.0.2.10"
  name    = "personal-01.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "www_personal_01_example_a_15bf6a" {
  content = "192.0.2.10"
  name    = "www.personal-01.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "_dmarc_personal_01_example_txt_d11032" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.personal-01.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "personal_01_example_mx_400827" {
  content  = "mx1.forwardemail.net"
  name     = "personal-01.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "fe_d2f97c3824__domainkey_personal_01_example_txt_92059f" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-d2f97c3824._domainkey.personal-01.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "personal_01_example_txt_71b69d" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "personal-01.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "personal_01_example_txt_0bb51e" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "personal-01.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "fe_bounces_personal_01_example_cname_0c5e30" {
  content = "forwardemail.net"
  name    = "fe-bounces.personal-01.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000025"
}

resource "cloudflare_dns_record" "personal_01_example_mx_9fee99" {
  content  = "mx2.forwardemail.net"
  name     = "personal-01.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000025"
}
