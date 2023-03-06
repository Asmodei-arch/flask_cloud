#!/bin/bash

# Exit early on errors
set -eu

# Python buffers stdout. Without this, you won't see what you "print" in the Activity Logs
export PYTHONUNBUFFERED=true

# Install Python 3 virtual env
VIRTUALENV=./venv

if [ ! -d $VIRTUALENV ]; then
  python3 -m venv $VIRTUALENV
fi

# Install pip into virtual environment
if [ ! -f $VIRTUALENV/bin/pip ]; then
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | $VIRTUALENV/bin/python
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | $VIRTUALENV/bin/python
fi

# Install the requirements
$VIRTUALENV/bin/poetry install

# Run your glorious application
$VIRTUALENV/bin/python3 server.py
