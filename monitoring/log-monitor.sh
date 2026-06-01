#!/bin/bash
# Log Monitor
# Monitors log files for errors and anomalies

LOG_FILE=${1:-/var/log/syslog}
CHECK_INTERVAL=${2:-5}

echo "=== Log File Monitor ==="
echo "Monitoring: $LOG_FILE"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Looking for: ERROR, CRITICAL, FAILED, WARNING"
echo ""

LAST_LINE=0

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    ERRORS=$(tail -n +$((LAST_LINE + 1)) $LOG_FILE 2>/dev/null | \
             grep -iE "ERROR|CRITICAL|FAILED|WARNING" | \
             while read line; do
                 echo "[$TIMESTAMP] $line"
             done)
    
    if [ -n "$ERRORS" ]; then
        echo "$ERRORS"
    fi
    
    LAST_LINE=$(wc -l < $LOG_FILE)
    sleep $CHECK_INTERVAL
done
