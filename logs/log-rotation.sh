#!/bin/bash
# Log Rotation
# Manages log file rotation

LOG_DIR=${1:-/var/log}
MAX_SIZE=${2:-10485760}  # 10MB in bytes
BACKUP_COUNT=${3:-10}

echo "=== Log Rotation Manager ==="
echo "Directory: $LOG_DIR"
echo "Max size: $((MAX_SIZE / 1048576))MB"
echo "Backup count: $BACKUP_COUNT"
echo ""

find "$LOG_DIR" -maxdepth 1 -name "*.log" -type f | while read logfile; do
    SIZE=$(stat -f%z "$logfile" 2>/dev/null || stat -c%s "$logfile")
    
    if [ $SIZE -gt $MAX_SIZE ]; then
        TIMESTAMP=$(date +%Y%m%d-%H%M%S)
        ROTATED="${logfile}.${TIMESTAMP}"
        
        echo "Rotating: $logfile ($(du -h "$logfile" | cut -f1))"
        
        mv "$logfile" "$ROTATED"
        gzip "$ROTATED"
        
        # Keep only backup count
        ls -t "${logfile}".* 2>/dev/null | tail -n +$((BACKUP_COUNT + 1)) | xargs rm -f
        
        # Restart service if needed
        SERVICE=$(echo $(basename "$logfile") | sed 's/\.log//')
        if systemctl list-units --all | grep -q "$SERVICE"; then
            sudo systemctl reload $SERVICE 2>/dev/null
        fi
    fi
done

echo ""
echo "Log rotation completed"
echo ""
echo "Current log files:"
ls -lh "$LOG_DIR"/*.log 2>/dev/null | head -5
