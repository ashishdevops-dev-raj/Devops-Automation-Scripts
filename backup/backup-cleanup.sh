#!/bin/bash
# Backup Cleanup
# Removes old backups based on retention policy

BACKUP_DIR=${1:-/backups}
RETENTION_DAYS=${2:-30}

echo "=== Backup Cleanup ==="
echo "Backup directory: $BACKUP_DIR"
echo "Retention period: $RETENTION_DAYS days"
echo ""

if [ ! -d "$BACKUP_DIR" ]; then
    echo "ERROR: Backup directory not found: $BACKUP_DIR"
    exit 1
fi

echo "Finding backups older than $RETENTION_DAYS days..."
OLD_BACKUPS=$(find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +$RETENTION_DAYS)

if [ -z "$OLD_BACKUPS" ]; then
    echo "No old backups found"
    exit 0
fi

echo "Backups to be deleted:"
echo "$OLD_BACKUPS" | while read backup; do
    SIZE=$(du -h "$backup" | cut -f1)
    MTIME=$(stat -c%y "$backup" 2>/dev/null | cut -d' ' -f1 || stat -f "%Sm" -t "%Y-%m-%d" "$backup")
    echo "  $backup ($SIZE, modified: $MTIME)"
done

TOTAL_SIZE=$(echo "$OLD_BACKUPS" | xargs du -ch 2>/dev/null | tail -1 | awk '{print $1}')
echo ""
echo "Total space to be freed: $TOTAL_SIZE"

read -p "Delete these backups? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$OLD_BACKUPS" | xargs rm -v
    echo "Cleanup completed"
fi
