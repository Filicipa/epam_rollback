#!/bin/bash

set -e

for i in {1..20}; do
    if curl -fsS http://127.0.0.1:8000/health > /dev/null; then
        echo "Application health check passed"
        exit 0
    fi

    echo "Waiting for application..."
    sleep 2
done

echo "Application health check failed"
exit 1