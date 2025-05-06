#!/bin/bash
set -euo pipefail

# === Configuration Variables ===
UBUNTU_VER="$(lsb_release -rs)"                   # e.g. "24.04"
UBUNTU_VER_NODOT="${UBUNTU_VER//./}"              # e.g. "2404"
ARCH="$(dpkg --print-architecture)"               # e.g. "x86_64"
CUDA_VERSION="12-9"
KEYRING_DEB="cuda-keyring_1.1-1_all.deb"
CUDA_KEYRING_URL="https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VER_NODOT}/${ARCH}/${KEYRING_DEB}"
DEVTOOLS_REPO_URL="http://developer.download.nvidia.com/devtools/repos/ubuntu${UBUNTU_VER_NODOT}/${ARCH}/"

# Add .local/bin to PATH
export PATH="/home/leonard/.local/bin:$PATH"

# === OS Check ===
echo "🔍 Checking Ubuntu version..."
if [[ "$UBUNTU_VER" != "24.04" ]]; then
  echo "❌ This script requires Ubuntu 24.04"
  exit 1
fi

# === GPU Check ===
echo "🎮 Checking for NVIDIA GPU..."
if lspci | grep -i nvidia > /dev/null; then
  echo "🚀 NVIDIA GPU detected; installing drivers and CUDA toolkit..."

  sudo apt update

  # === Install CUDA toolkit and drivers ===
  echo "📦 Installing CUDA toolkit and drivers..."
  wget "$CUDA_KEYRING_URL"
  sudo dpkg -i "$KEYRING_DEB"
  sudo apt-get update
  sudo apt-get -y install "cuda-toolkit-${CUDA_VERSION}"
  sudo apt-get -y install nvidia-open cuda-drivers

  # === Check NVIDIA installation ===
  echo "🧪 Verifying NVIDIA installation..."
  if ! nvidia-smi; then
    echo "⚠️ nvidia-smi failed—reboot may be required."
  fi

  # === Install Nsight Systems ===
  echo "📊 Installing NVIDIA Nsight Systems (GUI and CLI)..."
  sudo apt-get install -y --no-install-recommends gnupg

  echo "deb ${DEVTOOLS_REPO_URL} /" \
    | sudo tee /etc/apt/sources.list.d/nvidia-devtools.list

  sudo apt-get update
  sudo apt-get install -y nsight-systems nsight-systems-cli

else
  echo "ℹ️ No NVIDIA GPU found; skipping GPU setup."
fi

echo "✅ GPU setup complete."
