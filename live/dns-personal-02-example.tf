# personal-02.example DNS — imported from live 2026-07-26 (11 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "personal_02_example_mx_dde117" {
  content  = "mx2.forwardemail.net"
  name     = "personal-02.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "fe_8dead8abac__domainkey_personal_02_example_txt_05c3e3" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-8dead8abac._domainkey.personal-02.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "autodiscover_personal_02_example_cname_78648c" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.personal-02.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "personal_02_example_mx_59a224" {
  content  = "mx1.forwardemail.net"
  name     = "personal-02.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "personal_02_example_txt_2344e0" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "personal-02.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "personal_02_example_txt_2fcc99" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "personal-02.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "_dmarc_personal_02_example_txt_df4618" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.personal-02.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "autoconfig_personal_02_example_cname_c4aaae" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.personal-02.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "fe_bounces_personal_02_example_cname_e642de" {
  content = "forwardemail.net"
  name    = "fe-bounces.personal-02.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "personal_02_example_a_0671df" {
  content = "192.0.2.10"
  name    = "personal-02.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000040"
}

resource "cloudflare_dns_record" "www_personal_02_example_a_8e8b6e" {
  content = "192.0.2.10"
  name    = "www.personal-02.example"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = "00000000000000000000000000000040"
}
