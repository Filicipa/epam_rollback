#!/bin/bash

set -e

APP_DIR="/opt/9muunkkm-app"
PID_FILE="/var/run/9muunkkm-app.pid"
LOG_FILE="/var/log/9muunkkm-app.log"

cd "$APP_DIR"

nohup ./venv/bin/gunicorn \
    --bind 0.0.0.0:8000 \
    --workers 2 \
    --access-logfile - \
    --error-logfile - \
    app:app > "$LOG_FILE" 2>&1 &

echo $! > "$PID_FILE"

sleep 2

if ! kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo "Application failed to start"
    cat "$LOG_FILE"
    exit 1
fi

echo "Application started with PID $(cat "$PID_FILE")"