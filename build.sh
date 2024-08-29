#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if Pyright is installed
if ! command -v pyright &> /dev/null
then
    echo "Pyright could not be found, please install it first."
    exit 1
fi

# Run Pyright to check for type errors
echo "Running Pyright..."
pyright

# If Pyright passes, proceed to build the package
echo "Pyright check passed. Building the package..."

# Check if pyproject.toml exists (indicating use of poetry)
if [ -f "pyproject.toml" ]; then
    # If using poetry
    if grep -q "\[tool.poetry\]" "pyproject.toml"; then
        echo "Building package with Poetry..."
        poetry build
    else
        echo "Building package with standard tools (setuptools)..."
        python setup.py sdist bdist_wheel
    fi
else
    echo "No pyproject.toml found. Assuming setup.py is used for building."
    python setup.py sdist bdist_wheel
fi

echo "Package build complete."
