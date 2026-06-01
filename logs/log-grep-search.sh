#!/bin/bash
# Log Grep Search
# Searches logs with various filters

LOG_DIR=${1:-/var/log}
PATTERN=${2}
FILTER=${3}

show_help() {
    echo "Usage: $0 [log_dir] <pattern> [filter]"
    echo ""
    echo "Filters: ERROR, WARNING, INFO, DEBUG, FAILED, DENIED"
    echo ""
    echo "Examples:"
    echo "  $0 /var/log \"nginx\" ERROR"
    echo "  $0 /var/log \"ssh\" FAILED"
}

if [ -z "$PATTERN" ]; then
    show_help
    exit 1
fi

echo "=== Log Search ==="
echo "Directory: $LOG_DIR"
echo "Pattern: $PATTERN"
echo "Filter: ${FILTER:-ALL}"
echo ""

if [ -n "$FILTER" ]; then
    echo "Results:"
    grep -r -i "$PATTERN" "$LOG_DIR" 2>/dev/null | grep -i "$FILTER" | head -20
else
    echo "Results:"
    grep -r -i "$PATTERN" "$LOG_DIR" 2>/dev/null | head -20
fi

echo ""
echo "Total matches:"
if [ -n "$FILTER" ]; then
    grep -r -i "$PATTERN" "$LOG_DIR" 2>/dev/null | grep -i "$FILTER" | wc -l | awk '{print $1 " entries"}'
else
    grep -r -i "$PATTERN" "$LOG_DIR" 2>/dev/null | wc -l | awk '{print $1 " entries"}'
fi
