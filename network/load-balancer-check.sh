#!/bin/bash
# Load Balancer Health Check
# Monitors load balancer backend server health

LB_HOST=${1:-localhost}
LB_PORT=${2:-80}
CHECK_INTERVAL=${3:-10}

echo "=== Load Balancer Health Monitor ==="
echo "Load Balancer: $LB_HOST:$LB_PORT"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Check main LB
    if timeout 2 bash -c "echo >/dev/tcp/$LB_HOST/$LB_PORT" 2>/dev/null; then
        STATUS="UP"
    else
        STATUS="DOWN"
    fi
    
    echo "[$TIMESTAMP] Load Balancer: $STATUS"
    
    # If LB has HAProxy stats
    if command -v curl &> /dev/null; then
        STATS=$(curl -s "http://$LB_HOST:8080/stats" 2>/dev/null | grep -E "BACKEND|FRONTEND" | head -5)
        if [ -n "$STATS" ]; then
            echo "Backend status:"
            echo "$STATS" | head -3
        fi
    fi
    
    echo "---"
    sleep $CHECK_INTERVAL
done
