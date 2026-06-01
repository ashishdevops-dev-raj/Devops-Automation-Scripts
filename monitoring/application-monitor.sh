#!/bin/bash
# Application Monitor
# Monitors application processes and restarts if needed

APP_NAME=${1:-nginx}
APP_CMD=${2:-nginx}
CHECK_INTERVAL=${3:-30}

echo "=== Application Monitor ==="
echo "Application: $APP_NAME"
echo "Check interval: $CHECK_INTERVAL seconds"
echo "Starting monitoring... (Ctrl+C to stop)"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if pgrep -x "$APP_CMD" > /dev/null; then
        PID=$(pgrep -x "$APP_CMD")
        MEM=$(ps -p $PID -o %mem= 2>/dev/null)
        CPU=$(ps -p $PID -o %cpu= 2>/dev/null)
        echo "[$TIMESTAMP] $APP_NAME: RUNNING (PID: $PID, CPU: $CPU%, MEM: $MEM%)"
    else
        echo "[$TIMESTAMP] $APP_NAME: NOT RUNNING - ALERT!"
        
        read -p "Start $APP_NAME? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            $APP_CMD &
            echo "[$TIMESTAMP] $APP_NAME started"
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
