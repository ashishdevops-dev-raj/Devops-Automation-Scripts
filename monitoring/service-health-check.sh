#!/bin/bash
# Service Health Check
# Monitors critical services and alerts if they go down

SERVICES=("nginx" "postgresql" "redis" "mysql")
CHECK_INTERVAL=${1:-10}

echo "=== Service Health Monitor ==="
echo "Monitoring services: ${SERVICES[@]}"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    for service in "${SERVICES[@]}"; do
        if systemctl is-active --quiet $service; then
            echo "[$TIMESTAMP] $service: RUNNING"
        else
            echo "[$TIMESTAMP] $service: DOWN - ALERT!"
            
            read -p "Restart $service? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo systemctl restart $service
                echo "[$TIMESTAMP] $service restarted"
            fi
        fi
    done
    
    echo "---"
    sleep $CHECK_INTERVAL
done
