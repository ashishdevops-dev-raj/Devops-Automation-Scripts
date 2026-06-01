#!/bin/bash
# File Permissions Auditor
# Audits and reports on file permissions

AUDIT_DIR=${1:-.}
ISSUES=0

echo "=== File Permissions Audit ==="
echo "Scanning: $AUDIT_DIR"
echo ""

# Find world-writable files
echo "Checking for world-writable files..."
WORLD_WRITE=$(find $AUDIT_DIR -type f -perm -002 2>/dev/null)
if [ -n "$WORLD_WRITE" ]; then
    echo "WARNING: Found world-writable files:"
    echo "$WORLD_WRITE"
    ISSUES=$((ISSUES + 1))
fi

# Find world-readable sensitive files
echo ""
echo "Checking for world-readable sensitive files..."
WORLD_READ=$(find $AUDIT_DIR -type f \( -name "*.key" -o -name "*.pem" -o -name "*.pass" \) -perm -004 2>/dev/null)
if [ -n "$WORLD_READ" ]; then
    echo "WARNING: Found world-readable sensitive files:"
    echo "$WORLD_READ"
    ISSUES=$((ISSUES + 1))
fi

# Find SUID/SGID files
echo ""
echo "SUID/SGID files:"
find $AUDIT_DIR -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null | head -10

echo ""
echo "Total issues found: $ISSUES"
