cat > publish.sh <<'EOF'
#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

VERSION="$1"
if [ -z "$VERSION" ]; then
  echo "Usage: ./publish.sh v1.0.0"
  exit 1
fi

echo "→ Publishing $VERSION to GitHub"
git checkout main
git merge dev
git tag -a "$VERSION" -m "Release $VERSION — preprod-verified"
git push origin main --tags
git checkout dev
echo "✅ $VERSION published."
EOF