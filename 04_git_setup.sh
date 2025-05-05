#!/bin/bash
set -euo pipefail

echo "👤 Configuring Git identity…"
read -rp "Full name (no accents): " full_name
read -rp "GitHub email address: " email

git config --global user.name "$full_name"
git config --global user.email "$email"

echo "🔑 Setting default branch to main..."
git config --global init.defaultBranch main

echo "🔑 Logging in to GitHub..."
gh auth login

echo "👌 Git setup complete."
