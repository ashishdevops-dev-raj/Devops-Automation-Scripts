#!/bin/bash
# Full System Backup
# Creates a complete system backup

BACKUP_DIR=${1:-/backups}
BACKUP_NAME="full-backup-$(date +%Y%m%d-%H%M%S)"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo "=== Full System Backup ==="
echo "Backup destination: $BACKUP_PATH"

mkdir -p "$BACKUP_DIR"

# Exclude directories
EXCLUDE="--exclude=/dev --exclude=/proc --exclude=/sys --exclude=/tmp --exclude=/mnt --exclude=/media --exclude=/var/tmp --exclude=/run"

echo "Starting backup... This may take a while"
tar -czpf "$BACKUP_PATH.tar.gz" $EXCLUDE / 2>&1 | tee "$BACKUP_PATH.log"

if [ -f "$BACKUP_PATH.tar.gz" ]; then
    SIZE=$(du -h "$BACKUP_PATH.tar.gz" | cut -f1)
    echo ""
    echo "Backup completed successfully!"
    echo "File: $BACKUP_PATH.tar.gz"
    echo "Size: $SIZE"
else
    echo "ERROR: Backup failed!"
    exit 1
fi
