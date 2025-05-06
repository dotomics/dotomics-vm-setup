#!/bin/bash
set -euo pipefail

source ~/.bash_profile

# Install Python 3.12 using uv
uv python install 3.12

# uv python pin 3.12