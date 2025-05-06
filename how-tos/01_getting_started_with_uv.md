# Getting started with uv

## Why UV?

[`uv`](https://docs.astral.sh/uv/) is a modern Python package management tool that offers several advantages over traditional tools:

- **Speed**: Up to 10-100x faster than pip for package installation
- **Reliability**: Deterministic builds with precise dependency resolution
- **Caching**: Smart caching system that avoids redundant downloads
- **Isolation**: Built-in virtual environment management
- **Compatibility**: Drop-in replacement for pip, works with existing requirements.txt files
- **Security**: Built-in supply chain security features
- **Modern Features**: 
  - Native support for both wheels and source distributions
  - Automatic environment management
  - Built-in build system for Python packages
  - Support for modern lockfile formats

Using `uv` significantly improves the Python development workflow by making package management faster, more reliable, and more secure.

## How to...

### Start a new project

```shell
# initialize a project with everything you need to get started - .git, pyproject.toml, uv.lock, main.py, README.md
uv init

# start virtual environment
uv venv # initialize python virtual environment
source .venv/bin/activate 

# Add a dependency on a package
uv add <package-name>

# Install a package without adding a dependency
uv pip install <package-name>

```

### Work with jupyter notebooks...

```shell
# first make sure your virtual environment is activated
source .venv/bin/activate

# Install the required packages to work with uv
uv pip install jupyter notebook ipykernel

# Register your virtual environment as a kernel
python -m ipykernel install --user --name=your_env_name

# To verify the kernel installation
jupyter kernelspec list

# To remove a kernel, if needed
jupyter kernelspec uninstall your_env_name
```

To make sure you can work with your jupyter environement, make sure you have the VS code Jupyter extension installed and activated.

### Work with project that has been initialized with `uv`

```shell
uv pip install -r pyproject.toml
```
