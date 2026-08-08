# labodeludo.dev DNS — imported from live 2026-07-26 (6 records).
# Drafted with -generate-config-out and cleaned (null attrs, default settings
# blocks and empty tags stripped); resource names carry the record-id prefix
# the import blocks reference.

resource "cloudflare_dns_record" "labodeludo_dev_txt_03d5f1" {
  content = "\"google-site-verification=EXAMPLEVERIFY\""
  name    = "labodeludo.dev"
  proxied = false
  ttl     = 3600
  type    = "TXT"
  zone_id = "00000000000000000000000000000066"
}

# Staging. Pointed at the `k3s` tunnel until 2026-08-07, when the site moved
# from an nginx pod to Cloudflare Pages — same hostname, same Access app, no
# origin. Must stay proxied: an unproxied CNAME to pages.dev would bypass
# Access entirely.
resource "cloudflare_dns_record" "dev_labodeludo_dev_cname_4e896a" {
  content = "labodeludo-dev.pages.dev"
  name    = "dev.labodeludo.dev"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000066"
}

resource "cloudflare_dns_record" "labodeludo_dev_cname_f1c126" {
  content = "labodeludo.dev.s3-website.ca-central-1.amazonaws.com"
  name    = "labodeludo.dev"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000066"
}

resource "cloudflare_dns_record" "_d138036e50bc4aad1ec635c6ddb9905c_www_labodeludo_dev_cname_b59ee5" {
  content = "_00000000000000000000000000000000.example.acm-validations.aws"
  name    = "_d138036e50bc4aad1ec635c6ddb9905c.www.labodeludo.dev"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000066"
}

resource "cloudflare_dns_record" "_df3cbfc03d5e972b9c2f3fd2af48c0d0_labodeludo_dev_cname_4ec531" {
  content = "dcv.comodoca.example"
  name    = "_df3cbfc03d5e972b9c2f3fd2af48c0d0.labodeludo.dev"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000066"
}

resource "cloudflare_dns_record" "_f6071f623efff973a4739aca1bb3019d_labodeludo_dev_cname_b231f1" {
  content = "_00000000000000000000000000000000.example.acm-validations.aws"
  name    = "_f6071f623efff973a4739aca1bb3019d.labodeludo.dev"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = "00000000000000000000000000000066"
}
