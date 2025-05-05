#!/bin/bash
set -euo pipefail

echo "🔧 Updating package lists and installing core tools..."
sudo apt update
sudo apt install -y \
    curl \
    git \
    imagemagick \
    jq \
    unzip \
    vim \
    tree \
    gcc \
    build-essential \
    gnupg \
    ca-certificates \
    lsb-release \
    software-properties-common
echo "🔧 Updating package lists and installing core tools... - Completed !\n"

echo "📦 Installing ble.sh..."
git clone https://github.com/akinomyoga/ble.sh.git ~/.local/share/blesh
cd ~/.local/share/blesh
make
make install
cd ~
echo "📦 Installing ble.sh - Completed !\n"

echo "🌟 Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
echo "🌟 Installing Starship prompt - Completed !\n"

echo "🐍 Installing uv (the Python packaging tool)..."
curl -Ls https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
echo "🐍 Installing uv (the Python packaging tool) - Completed !\n"

echo "🐙 Installing GitHub CLI (gh)..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
    https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
  sudo apt update && sudo apt install -y gh
echo "🐙 Installing GitHub CLI (gh) - Completed !\n"

echo "✅ Base setup complete."
