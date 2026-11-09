#!/bin/bash
set -euo pipefail

echo "🚀 Starting complete system setup..."

# Function to run a script and check its status
run_script() {
    local script=$1
    echo "📋 Running $script..."
    if [ -x "$script" ]; then
        ./"$script"
    else
        chmod +x "$script"
        ./"$script"
    fi
    echo "✅ Completed $script successfully"
    echo
}

# Run all scripts in order
run_script "01_base_setup.sh"
run_script "02_gpu_setup.sh"
run_script "03_dotfiles_setup.sh"
run_script "04_git_setup.sh"
run_script "05_uv_setup.sh"

echo "🎉 All setup scripts completed successfully!" 