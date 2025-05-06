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

  echo "📊 Installing NVIDIA Nsight Systems (GUI) and CLI tools..."

  # Ensure gnupg is available for key management
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends gnupg

  # Install CUDA repo keyring
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb
  sudo apt-get update
  
  # Add NVIDIA devtools (Nsight Systems) repo
  echo "deb http://developer.download.nvidia.com/devtools/repos/ubuntu$(source /etc/lsb-release; \
       echo \$DISTRIB_RELEASE | tr -d .)/$(dpkg --print-architecture) /" \
    | sudo tee /etc/apt/sources.list.d/nvidia-devtools.list
  
  
  sudo apt-get update
  sudo apt-get install -y nsight-systems
  sudo apt-get install -y nsight-systems-cli

else
  echo "ℹ️ No NVIDIA GPU found; skipping GPU setup."
fi

echo "✅ GPU setup complete."
