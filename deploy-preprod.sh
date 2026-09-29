#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

SSH_KEY="$HOME/.ssh/kali"
NODE="debian@192.168.100.52"

echo "═══ Deploying to PREPROD ($NODE) ═══"

echo "→ Syncing files..."
tar -czf - \
  --exclude=.venv --exclude=venv --exclude=.git \
  --exclude=__pycache__ --exclude='*.pyc' --exclude=.env \
  . | ssh -i "$SSH_KEY" "$NODE" "tar -xzf - -C /srv/app"

echo "→ Installing deps and restarting service..."
ssh -i "$SSH_KEY" -t "$NODE" \
  "cd /srv/app && . venv/bin/activate && pip install -q -r requirements.txt && sudo systemctl restart flaskapp"

echo "→ Status:"
ssh -i "$SSH_KEY" "$NODE" "systemctl is-active flaskapp; curl -sI http://127.0.0.1:5000 | head -1"

echo "✅ Preprod deployed. Test at https://preprod.mydomain.com"
