#!/bin/bash
set -euo pipefail

echo "🎮 Checking for NVIDIA GPU..."
if lspci | grep -i nvidia > /dev/null; then
  echo "🚀 NVIDIA GPU detected; installing driver..."
  sudo apt update
  sudo apt install -y nvidia-driver-535
  echo "🧪 Verifying NVIDIA installation..."
  nvidia-smi || echo "⚠️ nvidia-smi failed—reboot may be required."
else
  echo "ℹ️ No NVIDIA GPU found; skipping GPU setup."
fi

echo "✅ GPU setup complete."
