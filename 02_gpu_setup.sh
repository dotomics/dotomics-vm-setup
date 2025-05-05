#!/bin/bash
set -euo pipefail

# Add .local/bin to PATH
export PATH="/home/leonard/.local/bin:$PATH"

# Check Ubuntu version
echo "🔍 Checking Ubuntu version..."
if ! grep -q "Ubuntu 24.04" /etc/os-release; then
  echo "❌ This script requires Ubuntu 24.04"
  exit 1
fi

echo "🎮 Checking for NVIDIA GPU..."
if lspci | grep -i nvidia > /dev/null; then
  echo "🚀 NVIDIA GPU detected; installing drivers and CUDA toolkit..."

  # Update package list
  sudo apt update

  # Install CUDA toolkit
  echo "📦 Installing CUDA toolkit..."
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb
  sudo apt-get update
  sudo apt-get -y install cuda-toolkit-12-9
  
  # Install NVIDIA drivers
  sudo apt-get install -y nvidia-open
  sudo apt-get install -y cuda-drivers

  echo "🧪 Verifying NVIDIA installation..."
  nvidia-smi || echo "⚠️ nvidia-smi failed—reboot may be required."

  # Install NVIDIA Nsight Systems profiler
  echo "📊 Installing NVIDIA Nsight Systems and CLI..."
  # Add the NVIDIA devtools repository GPG key
  sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/7fa2af80.pub  :contentReference[oaicite:0]{index=0}
  # Add the Nsight Systems repository for this Ubuntu release and architecture
  sudo add-apt-repository \
    "deb https://developer.download.nvidia.com/devtools/repos/ubuntu$(source /etc/lsb-release; echo "$DISTRIB_RELEASE" | tr -d .)/$(dpkg --print-architecture)/ /"  :contentReference[oaicite:1]{index=1}
  sudo apt update
  # Install both the GUI host application and the CLI-only package
  sudo apt install -y nsight-systems nsight-systems-cli  :contentReference[oaicite:2]{index=2}

  echo "✅ NVIDIA Nsight Systems installation complete."
else
  echo "ℹ️ No NVIDIA GPU found; skipping GPU setup."
fi

echo "✅ GPU setup complete."
