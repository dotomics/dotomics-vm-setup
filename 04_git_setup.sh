#!/bin/bash
set -euo pipefail

echo "👤 Configuring Git identity…"
read -rp "Full name (no accents): " full_name
read -rp "GitHub email address: " email

git config --global user.name "$full_name"
git config --global user.email "$email"

echo "📂 Ensuring repository is initialized…"
git init 2>/dev/null || true

git add .
git commit -m "Configure Git identity for @lewagon" || echo "⚠️ Nothing to commit."

echo "📤 Pushing to origin/master…"
git push origin master || echo "⚠️ Push failed—check remote or permissions."

echo "🔗 Adding upstream remote…"
git remote add upstream git@github.com:lewagon/dotfiles.git   || echo "⚠️ Upstream remote may already exist."

echo "👌 Git setup complete."
