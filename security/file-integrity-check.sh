#!/bin/bash
# File Integrity Checker
# Monitors file integrity using checksums

WATCH_DIR=${1:-.}
CHECKSUM_FILE=".file-integrity.txt"

echo "=== File Integrity Monitor ==="
echo ""

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "Creating initial checksums for: $WATCH_DIR"
    find $WATCH_DIR -type f -exec md5sum {} \; > $CHECKSUM_FILE
    echo "Baseline created in: $CHECKSUM_FILE"
else
    echo "Verifying files in: $WATCH_DIR"
    echo ""
    
    CHANGES=$(md5sum -c $CHECKSUM_FILE 2>/dev/null | grep FAILED)
    if [ -n "$CHANGES" ]; then
        echo "WARNING: File changes detected!"
        echo "$CHANGES"
    else
        echo "All files verified successfully"
    fi
    
    # Check for new files
    NEW_FILES=$(find $WATCH_DIR -type f ! -exec md5sum -c $CHECKSUM_FILE \; 2>/dev/null | grep "open failed" || echo "")
    if [ -n "$NEW_FILES" ]; then
        echo ""
        echo "New files detected:"
        echo "$NEW_FILES"
    fi
fi
