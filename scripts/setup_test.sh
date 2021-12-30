#!/usr/bin/env sh
set -eu

# Activate pyenv and virtualenv if present, then run the specified command

# pyenv, pyenv-virtualenv
if [ -s .python-version ]; then
    PYENV_VERSION=$(head -n 1 .python-version)
    export PYENV_VERSION
fi

# other common virtualenvs
my_path=$(git rev-parse --show-toplevel)

for venv in venv .venv .; do
  if [ -f "${my_path}/${venv}/bin/activate" ]; then
    . "${my_path}/${venv}/bin/activate"

    # Install testing requirements
    pip install wheel
    pip install --upgrade -r requirements_test.txt -c https://raw.githubusercontent.com/home-assistant/core/dev/homeassistant/package_constraints.txt -r https://raw.githubusercontent.com/home-assistant/core/dev/requirements_test.txt -r https://raw.githubusercontent.com/home-assistant/core/dev/requirements_test_pre_commit.txt
    # Install pre-commit hook
    ${my_path}/${venv}/bin/pre-commit install
  fi
done


