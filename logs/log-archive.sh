#!/bin/bash
# Log Archive
# Archives old log files

LOG_DIR=${1:-/var/log}
ARCHIVE_DIR=${2:-/backup/logs}
DAYS_OLD=${3:-30}

echo "=== Log Archive Manager ==="
echo "Source: $LOG_DIR"
echo "Archive: $ARCHIVE_DIR"
echo "Archive files older than: $DAYS_OLD days"
echo ""

mkdir -p "$ARCHIVE_DIR"

echo "Finding files to archive..."
find "$LOG_DIR" -maxdepth 1 -type f -mtime +$DAYS_OLD -name "*.log*" | while read logfile; do
    BASENAME=$(basename "$logfile")
    DEST="$ARCHIVE_DIR/$BASENAME"
    
    SIZE=$(du -h "$logfile" | cut -f1)
    echo "Archiving: $BASENAME ($SIZE)"
    
    cp "$logfile" "$DEST"
    gzip "$DEST"
done

echo ""
echo "Archive completed"
echo ""
echo "Archive statistics:"
du -sh "$ARCHIVE_DIR"
find "$ARCHIVE_DIR" -type f | wc -l | awk '{print "Files archived: " $1}'
