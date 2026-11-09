#!/bin/bash
set -euo pipefail

UBUNTU_VERSION=$(lsb_release -rs | tr -d '.')
ARCH=$(dpkg --print-architecture)

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Check Ubuntu version
echo "🔍 Checking Ubuntu version..."
if ! grep -q "Ubuntu 24.04" /etc/os-release; then
  echo "❌ This script requires Ubuntu 24.04"
  exit 1
fi

echo "🎮 Checking for NVIDIA GPU..."
if lspci | grep -i nvidia > /dev/null; then
  echo "🚀 NVIDIA GPU detected; checking existing installations..."

  # Update package list
  sudo apt update

  # Check and install CUDA toolkit
  CUDA_VERSION="12.9"
  if command -v nvcc &> /dev/null && nvcc --version | grep -q "release ${CUDA_VERSION}"; then
    echo "📦 CUDA ${CUDA_VERSION} is already installed, skipping CUDA installation..."
  else
    echo "📦 Installing CUDA toolkit..."
    # Check if cuda-keyring is already installed
    if ! dpkg -l | grep -q cuda-keyring; then
      wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
      sudo dpkg -i cuda-keyring_1.1-1_all.deb
    fi
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-9
  fi

  # Check and install NVIDIA drivers
  if command -v nvidia-smi &> /dev/null; then
    echo "🎮 NVIDIA drivers are already installed, skipping driver installation..."
  else
    echo "🎮 Installing NVIDIA drivers..."
    sudo apt-get update
    sudo apt-get install -y nvidia-open
    sudo apt-get install -y cuda-drivers
  fi

  echo "🧪 Verifying NVIDIA installation..."
  if ! nvidia-smi; then
    echo "⚠️ nvidia-smi failed—a reboot may be required to complete the installation."
    echo "Please reboot your system after this script finishes."
  fi

  # Previous parts of the script seems to already take care of what's below 👇🏼

  # echo "🎯 Checking Nsight Systems installation..."
  # if command -v nsys &> /dev/null; then
  #   echo "✅ Nsight Systems is already installed:"
  #   nsys --version
  # else
  #   echo "🎯 Installing latest Nsight Systems..."
    
  #   LATEST_VERSION=$(curl -s "https://developer.download.nvidia.com/devtools/repos/ubuntu${UBUNTU_VERSION}/${ARCH}/Packages" \
  #     | awk '/^Package: nsight-systems$/,/^Version:/ { if ($1 == "Version:") print $2 }' \
  #     | sort -V \
  #     | tail -n 1)
  #   PACKAGE_NAME="nsight-systems-${LATEST_VERSION}_amd64.deb"
  #   DOWNLOAD_URL="https://developer.download.nvidia.com/devtools/repos/ubuntu${UBUNTU_VERSION}/${ARCH}/${PACKAGE_NAME}"
    
  #   wget -q "${DOWNLOAD_URL}" -O "${PACKAGE_NAME}"
  #   sudo apt install -y "./${PACKAGE_NAME}"
    
  #   echo "🔍 Verifying Nsight Systems installation..."
    
  #   if command -v nsys >/dev/null 2>&1; then
  #     echo "✅ Nsight Systems installed successfully:"
  #     nsys --version
  #   else
  #     echo "❌ Nsight Systems installation failed."
  #     exit 1
  #   fi
  # fi

else
  echo "ℹ️ No NVIDIA GPU found; skipping GPU setup."
fi

echo "✅ GPU setup complete."