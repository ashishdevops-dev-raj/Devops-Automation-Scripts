#!/bin/bash
# Log Statistics
# Generates comprehensive log statistics

LOG_FILE=${1:-/var/log/syslog}

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file not found: $LOG_FILE"
    exit 1
fi

echo "=== Log Statistics Report ==="
echo "File: $LOG_FILE"
echo "Generated: $(date)"
echo ""

{
    echo "=== File Information ==="
    echo "Size: $(du -h "$LOG_FILE" | cut -f1)"
    echo "Lines: $(wc -l < "$LOG_FILE")"
    echo "Last Modified: $(stat -f%Sm -t "%Y-%m-%d %H:%M:%S" "$LOG_FILE" 2>/dev/null || stat -c%y "$LOG_FILE" | cut -d. -f1)"
    echo ""
    
    echo "=== Severity Distribution ==="
    echo "ERROR: $(grep -ic "ERROR" "$LOG_FILE")"
    echo "WARNING: $(grep -ic "WARNING" "$LOG_FILE")"
    echo "INFO: $(grep -ic "INFO" "$LOG_FILE")"
    echo "DEBUG: $(grep -ic "DEBUG" "$LOG_FILE")"
    echo ""
    
    echo "=== Top 10 Processes ==="
    grep -o '[a-zA-Z0-9_-]*\[' "$LOG_FILE" | sed 's/\[//' | sort | uniq -c | sort -rn | head -10
    echo ""
    
    echo "=== Time Distribution ==="
    awk '{print $1}' "$LOG_FILE" | head -20 | sort | uniq -c
    
} | tee log-statistics-$(date +%s).txt

echo ""
echo "Statistics report saved"
