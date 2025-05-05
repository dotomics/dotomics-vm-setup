# Virtual Machine Set Up

## Minimal Set-Up

I have written a few scripts that should install a number of packages enabling anyone to get started.

### TL;DR

```shell
chmod +x 00_setup.sh
./00_setup.sh
```

### More detailed version

This repo contains five scripts taking care of the installation and configuration:

> You can install every files individually or handle everything via `00_setup.sh`.

```shell

# Install all at once
chmod +x 00_setup.sh
./00_setup.sh

# or

# Install the different components individually
chmod +x 01_base_setup.sh
./01_base_setup.sh
chmod +x 02_gpu_setup.sh
./02_gpu_setup.sh
chmod +x 03_dotfiles_setup.sh
./03_dotfiles_setup.sh
chmod +x 04_git_setup.sh
./04_git_setup.sh
chmod +x 05_uv_setup.sh
./05_uv_setup.sh

```

#### 1. Base Setup (`01_base_setup.sh`)
- System updates and upgrades to ensure latest packages
- Core system packages and development tools
- Terminal enhancements:
  - [`ble.sh`](https://github.com/akinomyoga/ble.sh): Advanced line editor for Bash with syntax highlighting
  - [`starship`](https://starship.rs/): Cross-shell customizable prompt
  - Essential command-line tools (curl, wget, git, etc.)
- Modern development tools:
  - [`uv`](https://docs.astral.sh/uv/): Fast Python package installer and resolver.
  - `gh`: GitHub CLI for managing repositories and PRs

#### 2. GPU Setup (`02_gpu_setup.sh`)
- NVIDIA drivers and CUDA toolkit installation
- GPU monitoring tools
- Required dependencies for GPU-accelerated applications

*Note: Everything has been done with Ubuntu 24.04 in mind. You may need to change some parts if you are going for another distro.*

#### 3. Dotfiles Setup (`03_dotfiles_setup.sh`)
- Configures shell environment with custom dotfiles:
  - `.bashrc`: Shell initialization and configuration
  - `.bash_profile`: Login shell configuration
  - `.bash_aliases`: Common command aliases
  - `.blerc`: Bash Line Editor configuration with custom styling
- Sets up a modern and efficient command-line experience
- Configures PATH and environment variables

#### 4. Git Setup (`04_git_setup.sh`)
- Configures Git global settings
- Sets up Git credentials
- Configures default Git behavior and aliases

#### 5. UV Setup (`05_uv_setup.sh`)
- Install python 3.12 through `uv`