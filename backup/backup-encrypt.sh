#!/bin/bash
# Backup Encryption
# Encrypts backup files using GPG

BACKUP_FILE=${1}
GPG_RECIPIENT=${2:-}

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: $0 <backup_file> [gpg_recipient]"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "=== Backup Encryption ==="
echo "Backup file: $BACKUP_FILE"
echo ""

if [ -z "$GPG_RECIPIENT" ]; then
    echo "Encrypting with symmetric cipher (password)..."
    gpg --symmetric --cipher-algo AES256 "$BACKUP_FILE"
else
    echo "Encrypting for recipient: $GPG_RECIPIENT"
    gpg --encrypt --recipient "$GPG_RECIPIENT" "$BACKUP_FILE"
fi

if [ -f "$BACKUP_FILE.gpg" ]; then
    ORIGINAL_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    ENCRYPTED_SIZE=$(du -h "$BACKUP_FILE.gpg" | cut -f1)
    echo ""
    echo "Encryption completed!"
    echo "Original: $ORIGINAL_SIZE"
    echo "Encrypted: $ENCRYPTED_SIZE"
else
    echo "ERROR: Encryption failed!"
    exit 1
fi
