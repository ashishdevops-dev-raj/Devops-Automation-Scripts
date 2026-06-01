#!/bin/bash
# Database Backup
# Backs up MySQL or PostgreSQL databases

DB_TYPE=${1:-mysql}
DB_HOST=${2:-localhost}
DB_USER=${3:-root}
DB_PASS=${4:-password}
BACKUP_DIR=${5:-/backups}

echo "=== Database Backup ==="
echo "Database: $DB_TYPE"
echo "Host: $DB_HOST"
echo "Backup directory: $BACKUP_DIR"
echo ""

mkdir -p "$BACKUP_DIR"

if [ "$DB_TYPE" == "mysql" ]; then
    BACKUP_FILE="$BACKUP_DIR/mysql-backup-$(date +%Y%m%d-%H%M%S).sql.gz"
    echo "Backing up MySQL databases..."
    
    mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS --all-databases | gzip > "$BACKUP_FILE"
    
elif [ "$DB_TYPE" == "postgresql" ]; then
    BACKUP_FILE="$BACKUP_DIR/postgresql-backup-$(date +%Y%m%d-%H%M%S).sql.gz"
    echo "Backing up PostgreSQL databases..."
    
    PGPASSWORD=$DB_PASS pg_dumpall -h $DB_HOST -U $DB_USER | gzip > "$BACKUP_FILE"
fi

if [ -f "$BACKUP_FILE" ]; then
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "Backup completed successfully!"
    echo "File: $BACKUP_FILE"
    echo "Size: $SIZE"
else
    echo "ERROR: Backup failed!"
    exit 1
fi
