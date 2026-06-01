#!/bin/bash
# Disk Space Alert System
# Sends alerts when disk usage exceeds threshold

THRESHOLD=${1:-80}
CHECK_INTERVAL=${2:-10}

echo "=== Disk Space Alert Monitor ==="
echo "Threshold: $THRESHOLD%"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Starting monitoring... (Ctrl+C to stop)"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    df -h | awk 'NR>1 {
        gsub("%","");
        usage=$5+0;
        if (usage > '"$THRESHOLD"') {
            printf "['"$TIMESTAMP"'] ALERT: %s is %d%% full\n", $6, usage;
        }
    }'
    
    sleep $CHECK_INTERVAL
done
