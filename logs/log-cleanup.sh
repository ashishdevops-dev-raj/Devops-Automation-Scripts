#!/bin/bash
# Log Cleanup
# Removes old log files based on retention policy

LOG_DIR=${1:-/var/log}
RETENTION_DAYS=${2:-90}

echo "=== Log Cleanup ==="
echo "Directory: $LOG_DIR"
echo "Retention: $RETENTION_DAYS days"
echo ""

echo "Finding files to delete..."
FILES_TO_DELETE=$(find "$LOG_DIR" -maxdepth 1 -type f -name "*.log*" -mtime +$RETENTION_DAYS)

if [ -z "$FILES_TO_DELETE" ]; then
    echo "No files to delete"
    exit 0
fi

TOTAL_SIZE=0
while read logfile; do
    SIZE=$(stat -f%z "$logfile" 2>/dev/null || stat -c%s "$logfile")
    TOTAL_SIZE=$((TOTAL_SIZE + SIZE))
    echo "  $(basename "$logfile") - $(du -h "$logfile" | cut -f1)"
done <<< "$FILES_TO_DELETE"

echo ""
echo "Total space to be freed: $(echo "scale=2; $TOTAL_SIZE / 1048576" | bc)MB"
echo ""

read -p "Delete these files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$FILES_TO_DELETE" | xargs rm -v
    echo ""
    echo "Cleanup completed"
fi
