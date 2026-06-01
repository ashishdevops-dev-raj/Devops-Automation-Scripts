#!/bin/bash
# Log Compression
# Compresses log files to save space

LOG_DIR=${1:-/var/log}
COMPRESSION=${2:-gzip}
DAYS_OLD=${3:-7}

echo "=== Log Compression ==="
echo "Directory: $LOG_DIR"
echo "Method: $COMPRESSION"
echo "Compress files older than: $DAYS_OLD days"
echo ""

echo "Finding log files to compress..."
find "$LOG_DIR" -maxdepth 1 -name "*.log*" -type f -mtime +$DAYS_OLD ! -name "*.gz" ! -name "*.bz2" ! -name "*.xz" | while read logfile; do
    SIZE=$(du -h "$logfile" | cut -f1)
    echo "Compressing: $logfile ($SIZE)"
    
    case $COMPRESSION in
        gzip)
            gzip -9 "$logfile"
            ;;
        bzip2)
            bzip2 -9 "$logfile"
            ;;
        xz)
            xz -9 "$logfile"
            ;;
    esac
done

echo ""
echo "Compression completed"
echo ""
echo "Total space in $LOG_DIR:"
du -sh "$LOG_DIR"
