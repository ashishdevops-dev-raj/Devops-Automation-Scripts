#!/bin/bash
# Incremental Backup
# Creates incremental backups based on file modification times

BACKUP_DIR=${1:-/backups}
BASE_BACKUP=${2:-}
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_NAME="incremental-backup-$TIMESTAMP"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo "=== Incremental Backup ==="
echo "Backup destination: $BACKUP_PATH"

mkdir -p "$BACKUP_DIR"

if [ -z "$BASE_BACKUP" ]; then
    echo "Creating new base backup..."
    tar -czpf "$BACKUP_PATH.tar.gz" \
        --exclude=/dev --exclude=/proc --exclude=/sys --exclude=/tmp \
        / 2>&1 | tee "$BACKUP_PATH.log"
else
    echo "Creating incremental backup based on: $BASE_BACKUP"
    tar -czpf "$BACKUP_PATH.tar.gz" \
        --newer-mtime-than="$BASE_BACKUP" \
        --exclude=/dev --exclude=/proc --exclude=/sys --exclude=/tmp \
        / 2>&1 | tee "$BACKUP_PATH.log"
fi

if [ -f "$BACKUP_PATH.tar.gz" ]; then
    SIZE=$(du -h "$BACKUP_PATH.tar.gz" | cut -f1)
    echo ""
    echo "Incremental backup completed!"
    echo "File: $BACKUP_PATH.tar.gz"
    echo "Size: $SIZE"
fi
