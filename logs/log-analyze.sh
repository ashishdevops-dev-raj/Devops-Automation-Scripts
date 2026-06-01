#!/bin/bash
# Log Analyzer
# Analyzes log files for patterns and statistics

LOG_FILE=${1:-/var/log/syslog}
PATTERN=${2:-.}

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file not found: $LOG_FILE"
    exit 1
fi

echo "=== Log Analysis ==="
echo "File: $LOG_FILE"
echo "Pattern: $PATTERN"
echo ""

# File statistics
echo "=== File Statistics ==="
SIZE=$(du -h "$LOG_FILE" | cut -f1)
LINES=$(wc -l < "$LOG_FILE")
echo "Size: $SIZE"
echo "Lines: $LINES"
echo ""

# Most common log entries
echo "=== Top 10 Most Common Entries ==="
grep "$PATTERN" "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo ""

# Error distribution
echo "=== Error/Warning Distribution ==="
echo "Errors: $(grep -ic "error" "$LOG_FILE")"
echo "Warnings: $(grep -ic "warning" "$LOG_FILE")"
echo "Critical: $(grep -ic "critical" "$LOG_FILE")"
echo ""

# Time range
echo "=== Time Range ==="
echo "First entry: $(head -1 "$LOG_FILE" | awk '{print $1, $2, $3}')"
echo "Last entry: $(tail -1 "$LOG_FILE" | awk '{print $1, $2, $3}')"
