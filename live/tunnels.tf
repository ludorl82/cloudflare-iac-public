# One tunnel: `k3s`, in-cluster connectors, every public hostname in the lab.
#
# It is REMOTELY managed (remote_config=true) — ingress rules live in
# Cloudflare, not in any connector-side config file — so this file is the
# source of truth for hostname -> origin routing. The tunnel secret is not
# managed (write-only attribute, never read back).
#
# The second tunnel, `keepass-webdav` (2fef02a3), was deleted 2026-08-06. It
# was the legacy aws-docker connector: the one piece of the edge path that
# lived outside the cluster, on a host that is itself a k3s node. Its last
# five hostnames are all above except traefik.pub.example.com, which was retired
# outright along with the Docker Traefik dashboard it fronted.
#
# dev.labodeludo.dev was removed 2026-08-07: the staging site moved to
# Cloudflare Pages, so it is served at the edge and no longer reaches an origin
# through this tunnel at all. It was the only rule pointing at Traefik's plain
# HTTP entrypoint.
#
# Ordering note: this is a single array and Cloudflare evaluates it in order,
# with the http_status:404 catch-all last. Appending is safe; inserting ahead
# of a more specific rule is not.

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
        hostname = "unifi.pub.example.com"
        origin_request = {
          no_tls_verify = true
        }
        service = "https://unifi.unifi.svc.cluster.local:8443"
      },
      {
        hostname = "plex.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "plex.pub.example.com"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      # Basic auth is applied by the in-cluster Traefik Middleware, so this must
      # route through Traefik and not straight at the WebDAV Service — a direct
      # dial would expose the .kdbx files unauthenticated.
      {
        hostname = "vault.family.example"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "vault.family.example"
        }
        service = "https://traefik.kube-system.svc.cluster.local:443"
      },
      # router (pfSense) and ha-01 (Home Assistant) are not cluster
      # workloads and have no in-cluster IngressRoute, so the connector dials
      # their LAN addresses directly rather than hopping through Traefik. The
      # aws-resident connector reaches both over the WireGuard tunnel.
      {
        hostname = "router.pub.example.com"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "router.pub.example.com"
        }
        service = "https://192.0.2.254:443"
      },
      {
        hostname = "ha-01.family.example"
        origin_request = {
          no_tls_verify      = true
          origin_server_name = "ha-01.family.example"
        }
        service = "https://192.0.2.34:443"
      },
      {
        hostname = "ntfy.pub.example.com"
        service  = "http://ntfy.ntfy.svc.cluster.local:80"
      },
      {
        hostname = "kuma.pub.example.com"
        service  = "http://uptime-kuma.kuma.svc.cluster.local:80"
      },
      # The Access apps and the WAF rule that gate this hostname were applied
      # FIRST, in a separate change: creating the name before the gate would
      # have put an unauthenticated Ollama on the internet, and that API carries
      # /api/pull, /api/create and /api/delete.
      # /api/embed goes to the CLUSTER, everything else to the host. Order
      # matters and this is why the path rule sits first: the tunnel takes the
      # first matching rule, so putting it after the catch-all below would mean
      # it is never reached.
      #
      # The embedding model moved into a pod on 2026-09-12 so the GPU reserved
      # for Kubernetes on that node has a real consumer. Routing by PATH rather
      # than by a new hostname is what keeps this free: same name, same Access
      # applications, same WAF rule. A second hostname would have meant a second
      # public surface to gate, and gating is the part that gets forgotten.
      {
        hostname = "ollama.pub.example.com"
        path     = "/api/embed"
        service  = "http://embeddings.embeddings.svc.cluster.local:11434"
      },
      # Everything else on this hostname is the host's Ollama, dialled straight
      # at its LAN address like router and ha-01 — it is not a cluster
      # workload and has no IngressRoute. Plain HTTP, so no origin_request
      # block. Serves the chat model for labodeludo.dev's widget.
      {
        hostname = "ollama.pub.example.com"
        service  = "http://192.0.2.129:11434"
      },
      {
        service = "http_status:404"
      },
    ]
  }
  source    = "cloudflare"
  tunnel_id = "00000000-0000-0000-0000-000000000012"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "k3s" {
  account_id    = "00000000000000000000000000000002"
  config_src    = "cloudflare"
  name          = "k3s"
  tunnel_secret = null # sensitive
}
