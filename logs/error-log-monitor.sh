#!/bin/bash
# Error Log Monitor
# Monitors error logs in real-time

LOG_FILE=${1:-/var/log/syslog}
CHECK_INTERVAL=${2:-5}

echo "=== Error Log Monitor ==="
echo "Monitoring: $LOG_FILE"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Looking for: ERROR, CRITICAL, FATAL"
echo ""

LAST_LINE=0

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    ERRORS=$(tail -n +$((LAST_LINE + 1)) "$LOG_FILE" 2>/dev/null | \
             grep -iE "ERROR|CRITICAL|FATAL|PANIC")
    
    if [ -n "$ERRORS" ]; then
        echo "[$TIMESTAMP] ERRORS DETECTED:"
        echo "$ERRORS" | while read line; do
            echo "  $line"
        done
        echo ""
    fi
    
    LAST_LINE=$(wc -l < "$LOG_FILE")
    sleep $CHECK_INTERVAL
done
