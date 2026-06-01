#!/bin/bash
# User List
# Lists users on the system

FILTER=${1}

echo "=== System Users ==="
echo ""

if [ -z "$FILTER" ]; then
    echo "All users:"
    awk -F: '{print $1, "(" $3 ")"}' /etc/passwd | column -t
else
    echo "Users matching: $FILTER"
    grep "$FILTER" /etc/passwd | awk -F: '{print $1, "(" $3 ")"}'
fi

echo ""
echo "=== User Statistics ==="
TOTAL=$(awk -F: '$3 >= 0 {count++} END {print count}' /etc/passwd)
SYSTEM=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)
REGULAR=$((TOTAL - SYSTEM))

echo "Total users: $TOTAL"
echo "System users: $SYSTEM"
echo "Regular users: $REGULAR"

echo ""
echo "=== Users with Shell Access ==="
grep -E "/bin/(bash|zsh|sh)" /etc/passwd | awk -F: '{print $1, "(" $3 ")"}' | column -t
