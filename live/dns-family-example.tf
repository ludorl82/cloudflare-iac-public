# family.example DNS — imported from live 2026-07-26 (14 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "family_example_txt_597032" {
  content = "\"v=spf1 include:spf.forwardemail.net -all\""
  name    = "family.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "kp_family_example_cname_a03fbc" {
  comment = "KeePass WebDAV via Cloudflare Tunnel"
  content = "00000000-0000-0000-0000-00000000000a.cfargotunnel.com"
  name    = "kp.family.example"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "family_example_mx_bea27d" {
  content  = "mx1.forwardemail.net"
  name     = "family.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "autoconfig_family_example_cname_5a108a" {
  content = "autoconfig.forwardemail.net"
  name    = "autoconfig.family.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "_dmarc_family_example_txt_09e145" {
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@example.com;\""
  name    = "_dmarc.family.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "fe_bounces_family_example_cname_319c86" {
  content = "forwardemail.net"
  name    = "fe-bounces.family.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "ha-01_local_family_example_a_2f0a21" {
  content = "192.0.2.34"
  name    = "ha-01-local.family.example"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "family_example_mx_54875f" {
  content  = "mx2.forwardemail.net"
  name     = "family.example"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "maison_family_example_a_a37e83" {
  content = "192.0.2.10"
  name    = "maison.family.example"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "family_example_txt_97e2b2" {
  content = "\"forward-email-site-verification=EXAMPLEVERIFY\""
  name    = "family.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "ha-01_family_example_cname_c1e295" {
  content = "00000000-0000-0000-0000-00000000000a.cfargotunnel.com"
  name    = "ha-01.family.example"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "autodiscover_family_example_cname_eb0a0f" {
  content = "autodiscover.forwardemail.net"
  name    = "autodiscover.family.example"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "fe_df20a909ef__domainkey_family_example_txt_0f1046" {
  content = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLEwIDAQAB;\""
  name    = "fe-df20a909ef._domainkey.family.example"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = "0000000000000000000000000000004d"
}

resource "cloudflare_dns_record" "maison_family_example_aaaa_cc81a9" {
  content = "2001:db8:50:a::1"
  name    = "maison.family.example"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  zone_id = "0000000000000000000000000000004d"
}
