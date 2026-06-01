#!/bin/bash
# CPU Alert System
# Sends alerts when CPU usage exceeds threshold

THRESHOLD=${1:-80}
CHECK_INTERVAL=${2:-5}

cpu_usage() {
    top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d'.' -f1
}

echo "=== CPU Alert Monitor ==="
echo "Threshold: $THRESHOLD%"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Starting monitoring... (Ctrl+C to stop)"
echo ""

while true; do
    USAGE=$(cpu_usage)
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if [ $USAGE -gt $THRESHOLD ]; then
        echo "[$TIMESTAMP] ALERT: CPU usage is at $USAGE%"
        
        # Show top processes
        echo "Top CPU processes:"
        ps aux --sort=-%cpu | head -4 | awk '{printf "  %s: %.1f%%\n", $11, $3}'
        echo ""
    else
        echo "[$TIMESTAMP] CPU usage: $USAGE%"
    fi
    
    sleep $CHECK_INTERVAL
done
