# Phase 3: both tunnels are REMOTELY managed (remote_config=true) — their
# ingress rules live in Cloudflare, not in any connector-side config file, so
# this file is the source of truth for hostname -> origin routing.
#   k3s            — in-cluster connectors; all pub.example.com services
#   keepass-webdav — the legacy aws-docker tunnel; kp/ha-01.family.example
#                    plus router/plex/traefik.pub.example.com still ride it
# The tunnel secrets are not managed (write-only attribute, never read back).

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "keepass_webdav" {
  account_id = "00000000000000000000000000000002"
  config = {
    ingress = [
      {
        hostname = "kp.family.example"
        origin_request = {
          origin_server_name = "kp.family.example"
        }
        service = "https://traefik:443"
      },
      {
        hostname = "ha-01.family.example"
        origin_request = {
          origin_server_name = "ha-01.family.example"
        }
        service = "https://traefik:443"
      },
      {
        hostname = "plex.pub.example.com"
        origin_request = {
          origin_server_name = "plex.pub.example.com"
        }
        service = "https://traefik:443"
      },
      {
        hostname = "traefik.pub.example.com"
        origin_request = {
          origin_server_name = "traefik.pub.example.com"
        }
        service = "https://traefik:443"
      },
      {
        hostname = "router.pub.example.com"
        origin_request = {
          origin_server_name = "router.pub.example.com"
        }
        service = "https://traefik:443"
      },
      {
        service = "http_status:404"
      },
    ]
  }
  source    = "cloudflare"
  tunnel_id = "00000000-0000-0000-0000-00000000000a"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "keepass_webdav" {
  account_id    = "00000000000000000000000000000002"
  config_src    = "cloudflare"
  name          = "keepass-webdav"
  tunnel_secret = null # sensitive
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "k3s" {
  account_id = "00000000000000000000000000000002"
  config = {
    ingress = [
      {
        hostname = "cronicle.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "cronicle.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "frigate.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "frigate.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "grafana.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "grafana.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "n8n.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "n8n.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "netalertx.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "netalertx.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "netbox.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "netbox.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      {
        hostname = "unifi.pub.example.com"
        origin_request = {
          no_tls_verify = true
        }
        service = "https://unifi.unifi.svc.cluster.local:8443"
      },
      {
        hostname = "dev.labodeludo.dev"
        service  = "http://traefik.kube-system.svc.cluster.local:80"
      },
      {
        hostname = "ntfy.pub.example.com"
        service  = "http://ntfy.ntfy.svc.cluster.local:80"
      },
      {
        hostname = "kuma.pub.example.com"
        service  = "http://uptime-kuma.kuma.svc.cluster.local:80"
      },
      {
        service = "http_status:404"
      },
    ]
  }
  source    = "cloudflare"
  tunnel_id = "00000000-0000-0000-0000-000000000015"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "k3s" {
  account_id    = "00000000000000000000000000000002"
  config_src    = "cloudflare"
  name          = "k3s"
  tunnel_secret = null # sensitive
}
