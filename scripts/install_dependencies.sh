#!/bin/bash

set -e

APP_DIR="/opt/9muunkkm-app"

cd "$APP_DIR"

python3 -m venv venv
./venv/bin/pip install --upgrade pip
./venv/bin/pip install -r requirements.txt