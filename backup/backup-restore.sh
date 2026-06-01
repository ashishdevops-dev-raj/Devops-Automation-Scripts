#!/bin/bash
# Backup Restore
# Restores files from a backup archive

BACKUP_FILE=${1}
RESTORE_PATH=${2:-/}

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: $0 <backup_file> [restore_path]"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "=== Backup Restore ==="
echo "Backup file: $BACKUP_FILE"
echo "Restore path: $RESTORE_PATH"
echo ""

read -p "Are you sure you want to restore? This will overwrite existing files. (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Restore cancelled"
    exit 1
fi

echo "Starting restore process..."
tar -xzpf "$BACKUP_FILE" -C "$RESTORE_PATH" 2>&1 | tee restore-$(date +%s).log

if [ $? -eq 0 ]; then
    echo ""
    echo "Restore completed successfully!"
else
    echo ""
    echo "ERROR: Restore failed!"
    exit 1
fi
