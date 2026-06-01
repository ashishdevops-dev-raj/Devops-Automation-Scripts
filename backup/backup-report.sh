#!/bin/bash
# Backup Report Generator
# Generates backup status and statistics reports

BACKUP_DIR=${1:-/backups}
REPORT_FILE=${2:-backup-report-$(date +%Y%m%d).txt}

echo "=== Backup Report Generator ==="
echo "Backup directory: $BACKUP_DIR"
echo "Report file: $REPORT_FILE"
echo ""

{
    echo "=================================="
    echo "Backup Report"
    echo "Generated: $(date)"
    echo "=================================="
    echo ""
    
    echo "Backup Directory Statistics:"
    echo "---"
    du -sh "$BACKUP_DIR" | awk '{print "Total size: " $1}'
    find "$BACKUP_DIR" -type f | wc -l | awk '{print "Total backups: " $1}'
    echo ""
    
    echo "Backup Files:"
    echo "---"
    ls -lh "$BACKUP_DIR" | tail -n +2 | awk '{printf "%-40s %10s %12s\n", $9, $5, $6" "$7" "$8}'
    echo ""
    
    echo "Backup Status:"
    echo "---"
    LATEST=$(find "$BACKUP_DIR" -type f -name "*.tar.gz" -o -name "*.sql.gz" | xargs ls -t | head -1)
    if [ -n "$LATEST" ]; then
        MTIME=$(stat -c%y "$LATEST" 2>/dev/null | cut -d' ' -f1 || stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$LATEST")
        SIZE=$(du -h "$LATEST" | cut -f1)
        echo "Latest backup: $LATEST"
        echo "Size: $SIZE"
        echo "Modified: $MTIME"
    fi
} | tee "$REPORT_FILE"

echo ""
echo "Report saved to: $REPORT_FILE"
