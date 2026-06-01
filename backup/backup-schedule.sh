#!/bin/bash
# Backup Scheduler
# Sets up automated backup scheduling

BACKUP_SCRIPT=${1:-/usr/local/bin/backup.sh}
SCHEDULE=${2:-"0 2 * * *"}
CRON_JOB="$SCHEDULE $BACKUP_SCRIPT"

echo "=== Backup Scheduler ==="
echo "Script: $BACKUP_SCRIPT"
echo "Schedule (cron): $SCHEDULE"
echo ""

if [ ! -f "$BACKUP_SCRIPT" ]; then
    echo "ERROR: Backup script not found: $BACKUP_SCRIPT"
    exit 1
fi

# Add to crontab
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Backup scheduled successfully!"
echo ""
echo "Current cron jobs:"
crontab -l
