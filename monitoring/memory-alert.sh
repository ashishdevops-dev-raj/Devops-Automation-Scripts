#!/bin/bash
# Memory Alert System
# Sends alerts when memory usage exceeds threshold

THRESHOLD=${1:-85}
CHECK_INTERVAL=${2:-5}

memory_usage() {
    free | grep Mem | awk '{print int($3/$2 * 100)}'
}

echo "=== Memory Alert Monitor ==="
echo "Threshold: $THRESHOLD%"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Starting monitoring... (Ctrl+C to stop)"
echo ""

while true; do
    USAGE=$(memory_usage)
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if [ $USAGE -gt $THRESHOLD ]; then
        echo "[$TIMESTAMP] ALERT: Memory usage is at $USAGE%"
        
        # Show top memory consuming processes
        echo "Top memory processes:"
        ps aux --sort=-%mem | head -4 | awk '{printf "  %s: %.1f%% (%s)\n", $1, $4, $6}'
        echo ""
    else
        echo "[$TIMESTAMP] Memory usage: $USAGE%"
    fi
    
    sleep $CHECK_INTERVAL
done
