#!/bin/bash

set -e

PID_FILE="/var/run/9muunkkm-app.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")

    if kill -0 "$PID" 2>/dev/null; then
        echo "Stopping application PID $PID"
        kill "$PID"

        for i in {1..20}; do
            if ! kill -0 "$PID" 2>/dev/null; then
                break
            fi
            sleep 1
        done

        if kill -0 "$PID" 2>/dev/null; then
            echo "Force killing application PID $PID"
            kill -9 "$PID"
        fi
    fi

    rm -f "$PID_FILE"
fi

exit 0