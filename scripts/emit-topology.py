#!/usr/bin/env python3
"""Emit topology.json for the public snapshot (edge layer).

Runs against the ALREADY-SANITIZED tree (sanitize-public.sh calls this after
every substitution, before the verification gate), so everything it can read
is already fictional — and the gate re-scans its output like any other file.

Extraction is line-regex over live/*.tf. The edge layer is: the tunnel, the
public hostnames its ingress rules route (tunnels.tf is the source of truth
for hostname -> origin), the Access applications protecting them, and the
one static-site CNAME that points the blog's apex at its S3 bucket.
Fail-closed: zero tunnel, an implausibly small ingress list, or zero Access
apps kills the run rather than emitting a partial layer.

Contract: labodeludo.dev scripts/topology/README.md (topologyVersion 1).
"""
import glob
import json
import os
import re
import sys

def die(msg):
    print(f"emit-topology: {msg}", file=sys.stderr)
    sys.exit(1)

if len(sys.argv) != 2:
    die("usage: emit-topology.py <sanitized-tree>")
ROOT = sys.argv[1]

def read(rel):
    path = os.path.join(ROOT, rel)
    if not os.path.isfile(path):
        die(f"{rel} missing")
    return open(path, encoding="utf-8").read()

nodes, edges = [], []
seen = set()

def add_node(node):
    if node["id"] not in seen:
        seen.add(node["id"])
        nodes.append(node)

# --- the tunnel and its ingress rules -------------------------------------
tunnels = read("live/tunnels.tf")
tunnel_names = re.findall(
    r'^resource\s+"cloudflare_zero_trust_tunnel_cloudflared"\s+"([\w-]+)"',
    tunnels, re.M)
if len(tunnel_names) != 1:
    die(f"expected exactly one tunnel, found {tunnel_names}")
tunnel = tunnel_names[0]
tid = f"tunnel:{tunnel}"
add_node({"id": tid, "kind": "tunnel", "label": tunnel, "layer": "edge",
          "source": "live/tunnels.tf", "meta": {}})
# the ingress rules' dominant origin is the in-cluster traefik service, so
# the tunnel as a whole terminates in the cluster
edges.append({"from": tid, "to": "cluster:k3s", "kind": "routes-to"})

# hostname = "X" ... service = "Y" pairs, in order, within tunnels.tf
pairs = re.findall(r'hostname\s*=\s*"([^"]+)"(.*?)service\s*=\s*"([^"]+)"',
                   tunnels, re.S)
if len(pairs) < 5:
    die(f"only {len(pairs)} tunnel ingress rules parsed — parser broken?")
for host, _, service in pairs:
    did = f"dns:{host}"
    add_node({"id": did, "kind": "dns", "label": host, "layer": "edge",
              "source": "live/tunnels.tf", "meta": {"origin": service}})
    edges.append({"from": did, "to": tid, "kind": "routes-to"})
    # an origin that is NOT an in-cluster Service is hors-IaC hardware the
    # tunnel merely reaches (the router's UI, the Home Assistant box...) —
    # surface it as an external node named after the public hostname's
    # leftmost label, which the shared sanitizer host map already aligns
    # with the machine's public name (router, ha-01)
    if service.startswith(("http://", "https://")) \
            and ".svc.cluster.local" not in service \
            and service != "http_status:404":
        name = host.split(".")[0]
        add_node({"id": f"external:{name}", "kind": "external",
                  "label": name, "layer": "external",
                  "source": "live/tunnels.tf",
                  "meta": {"origin": service}})
        edges.append({"from": did, "to": f"external:{name}",
                      "kind": "routes-to"})

# --- Access applications ---------------------------------------------------
access = read("live/access-apps.tf")
apps = re.finditer(
    r'^resource\s+"cloudflare_zero_trust_access_application"\s+"([\w-]+)"'
    r'(.*?)(?=^resource|\Z)', access, re.M | re.S)
n_access = 0
for m in apps:
    rname, body = m.group(1), m.group(2)
    domain = re.search(r'domain\s*=\s*"([^"]+)"', body)
    label = re.search(r'name\s*=\s*"([^"]+)"', body)
    if not domain:
        continue
    n_access += 1
    host = domain.group(1).split("/")[0]
    aid = f"access:{rname}"
    add_node({"id": aid, "kind": "access",
              "label": label.group(1) if label else rname, "layer": "edge",
              "source": "live/access-apps.tf",
              "meta": {"domain": domain.group(1)}})
    # a protected hostname that is not tunnel ingress (e.g. the Pages
    # staging site) still deserves a dns node so the edge resolves locally
    add_node({"id": f"dns:{host}", "kind": "dns", "label": host,
              "layer": "edge", "source": "live/access-apps.tf", "meta": {}})
    edges.append({"from": aid, "to": f"dns:{host}", "kind": "protects"})
if n_access == 0:
    die("extracted zero Access applications — parser broken?")

# --- the blog apex: proxied CNAME to its S3 website bucket -----------------
for path in sorted(glob.glob(os.path.join(ROOT, "live", "dns-*.tf"))):
    rel = os.path.relpath(path, ROOT)
    text = open(path, encoding="utf-8").read()
    for m in re.finditer(
            r'content\s*=\s*"([\w.-]+)\.s3-website[\w.-]*"\s*\n'
            r'\s*name\s*=\s*"([^"]+)"', text):
        bucket, name = m.group(1), m.group(2)
        did = f"dns:{name}"
        add_node({"id": did, "kind": "dns", "label": name, "layer": "edge",
                  "source": rel, "meta": {"origin": "s3-website"}})
        edges.append({"from": did, "to": f"bucket:{bucket}",
                      "kind": "routes-to"})

out = {"topologyVersion": 1, "repo": "cloudflare-iac-public", "layer": "edge",
       "nodes": nodes, "edges": edges}
with open(os.path.join(ROOT, "topology.json"), "w", encoding="utf-8") as fh:
    json.dump(out, fh, indent=2, sort_keys=True)
    fh.write("\n")
print(f"emit-topology: {len(nodes)} nodes ({len(pairs)} ingress hostnames, "
      f"{n_access} access apps), {len(edges)} edges")
