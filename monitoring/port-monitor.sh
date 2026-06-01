#!/bin/bash
# Port Monitor
# Monitors if specific ports remain open and accessible

PORTS=${1:-"80 443 22 3306 5432"}
CHECK_INTERVAL=${2:-10}
HOST=${3:-localhost}

echo "=== Port Monitor ==="
echo "Monitoring ports: $PORTS on $HOST"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    for port in $PORTS; do
        if timeout 2 bash -c "echo >/dev/tcp/$HOST/$port" 2>/dev/null; then
            echo "[$TIMESTAMP] Port $port: OPEN"
        else
            echo "[$TIMESTAMP] Port $port: CLOSED - ALERT!"
        fi
    done
    
    echo "---"
    sleep $CHECK_INTERVAL
done
