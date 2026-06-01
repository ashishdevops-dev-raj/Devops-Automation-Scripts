#!/bin/bash
# Response Time Monitor
# Monitors HTTP response times

URL=${1:-"http://localhost"}
CHECK_INTERVAL=${2:-10}
THRESHOLD=${3:-2000}

echo "=== Response Time Monitor ==="
echo "URL: $URL"
echo "Threshold: ${THRESHOLD}ms"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    RESPONSE_TIME=$(curl -s -o /dev/null -w '%{time_total}' "$URL" 2>/dev/null)
    RESPONSE_MS=$(echo "$RESPONSE_TIME * 1000" | bc | cut -d'.' -f1)
    
    if [ -z "$RESPONSE_TIME" ]; then
        echo "[$TIMESTAMP] Connection failed - ALERT!"
    elif [ "$RESPONSE_MS" -gt "$THRESHOLD" ]; then
        echo "[$TIMESTAMP] Response time: ${RESPONSE_MS}ms - SLOW!"
    else
        echo "[$TIMESTAMP] Response time: ${RESPONSE_MS}ms - OK"
    fi
    
    sleep $CHECK_INTERVAL
done
