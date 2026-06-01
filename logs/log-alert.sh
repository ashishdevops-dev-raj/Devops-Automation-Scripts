#!/bin/bash
# Log Alert System
# Alerts on specific log patterns

LOG_FILE=${1:-/var/log/syslog}
ALERT_PATTERN=${2:-"ERROR|CRITICAL|FAILED"}
CHECK_INTERVAL=${3:-10}
EMAIL=${4}

echo "=== Log Alert System ==="
echo "Monitoring: $LOG_FILE"
echo "Pattern: $ALERT_PATTERN"
echo "Check interval: $CHECK_INTERVAL seconds"
if [ -n "$EMAIL" ]; then
    echo "Alert email: $EMAIL"
fi
echo ""

LAST_LINE=0

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    ALERTS=$(tail -n +$((LAST_LINE + 1)) "$LOG_FILE" 2>/dev/null | \
             grep -E "$ALERT_PATTERN")
    
    if [ -n "$ALERTS" ]; then
        echo "[$TIMESTAMP] ALERT TRIGGERED!"
        echo "Matching entries:"
        echo "$ALERTS"
        
        # Send email if configured
        if [ -n "$EMAIL" ]; then
            echo "$ALERTS" | mail -s "Log Alert: $ALERT_PATTERN" "$EMAIL"
            echo "Alert email sent to: $EMAIL"
        fi
        
        echo ""
    fi
    
    LAST_LINE=$(wc -l < "$LOG_FILE")
    sleep $CHECK_INTERVAL
done
