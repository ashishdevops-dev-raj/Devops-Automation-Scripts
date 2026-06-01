#!/bin/bash
# Backup Verification
# Verifies backup integrity and completeness

BACKUP_FILE=${1}

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "=== Backup Verification ==="
echo "Backup file: $BACKUP_FILE"
echo ""

# Check file integrity
echo "Checking file integrity..."
if tar -tzf "$BACKUP_FILE" > /dev/null 2>&1; then
    echo "✓ Archive structure is valid"
else
    echo "✗ Archive is corrupted!"
    exit 1
fi

# File count
FILE_COUNT=$(tar -tzf "$BACKUP_FILE" | wc -l)
echo "✓ Total files: $FILE_COUNT"

# Archive size
SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "✓ Archive size: $SIZE"

# Calculate compression ratio
UNCOMPRESSED=$(tar -tzf "$BACKUP_FILE" | awk '{s+=$3} END {print s}')
RATIO=$(echo "scale=2; (($UNCOMPRESSED - $(stat -f%z "$BACKUP_FILE")) / $UNCOMPRESSED) * 100" | bc 2>/dev/null || echo "N/A")
echo "✓ Compression ratio: $RATIO%"

# List first few files
echo ""
echo "First 10 files in backup:"
tar -tzf "$BACKUP_FILE" | head -10

echo ""
echo "Verification completed successfully!"
