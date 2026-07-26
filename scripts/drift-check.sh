#!/usr/bin/env bash
# Nightly drift check for this repo. Runs INSIDE the console container on
# bastion (the only place holding the Cloudflare general token, at
# ~/.cf-general-token) — invoked by the Cronicle "cloudflare-iac Drift Check"
# event over ssh port 2222 as the forced command of a dedicated key.
#
# Exit codes mirror tofu: 0 = no drift, 2 = drift, anything else = broken.
# The Kuma push happens in the Cronicle event, not here.
set -u
export PATH=/usr/local/bin:/usr/bin:/bin
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export TF_IN_AUTOMATION=1

TOKEN_FILE="$HOME/.cf-general-token"
REPO="$HOME/cloudflare-iac/live"

if [ ! -s "$TOKEN_FILE" ]; then
  echo "BROKEN: token file $TOKEN_FILE missing or empty"
  exit 1
fi
cd "$REPO" || { echo "BROKEN: $REPO missing"; exit 1; }

# Detect a stale working tree (drift checks should test what is pushed).
git fetch -q origin 2>/dev/null || true
BEHIND=$(git rev-list --count HEAD..origin/master 2>/dev/null || echo "?")
[ "$BEHIND" != "0" ] && echo "note: working tree is $BEHIND commit(s) behind origin/master"

CLOUDFLARE_API_TOKEN=$(tr -d '\n' < "$TOKEN_FILE") \
  tofu plan -detailed-exitcode -lock=false -input=false -no-color > /tmp/cf-drift.log 2>&1
rc=$?

case "$rc" in
  0) echo "no drift — cloudflare matches cloudflare-iac" ;;
  2) echo "DRIFT DETECTED:"
     grep -E "will be|must be|^Plan:" /tmp/cf-drift.log | head -15 ;;
  *) echo "BROKEN: tofu plan failed (rc=$rc)"
     tail -c 300 /tmp/cf-drift.log ;;
esac
exit $rc
