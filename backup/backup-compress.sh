#!/bin/bash
# Backup Compression
# Compresses backup files with various algorithms

BACKUP_FILE=${1}
COMPRESSION=${2:-gzip}

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: $0 <backup_file> [gzip|bzip2|xz|lz4]"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "=== Backup Compression ==="
echo "File: $BACKUP_FILE"
echo "Method: $COMPRESSION"
echo ""

ORIGINAL_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "Original size: $ORIGINAL_SIZE"
echo "Compressing..."

case $COMPRESSION in
    gzip)
        gzip -9 "$BACKUP_FILE"
        COMPRESSED_FILE="$BACKUP_FILE.gz"
        ;;
    bzip2)
        bzip2 -9 "$BACKUP_FILE"
        COMPRESSED_FILE="$BACKUP_FILE.bz2"
        ;;
    xz)
        xz -9 "$BACKUP_FILE"
        COMPRESSED_FILE="$BACKUP_FILE.xz"
        ;;
    lz4)
        lz4 -9 "$BACKUP_FILE"
        COMPRESSED_FILE="$BACKUP_FILE.lz4"
        ;;
    *)
        echo "ERROR: Unknown compression method: $COMPRESSION"
        exit 1
        ;;
esac

if [ -f "$COMPRESSED_FILE" ]; then
    COMPRESSED_SIZE=$(du -h "$COMPRESSED_FILE" | cut -f1)
    echo ""
    echo "Compression completed!"
    echo "Compressed size: $COMPRESSED_SIZE"
fi
