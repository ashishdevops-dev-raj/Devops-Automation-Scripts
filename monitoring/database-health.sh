#!/bin/bash
# Database Health Check
# Monitors database connectivity and performance

DB_HOST=${1:-localhost}
DB_USER=${2:-root}
DB_PASS=${3:-password}
DB_TYPE=${4:-mysql}
CHECK_INTERVAL=${5:-10}

echo "=== Database Health Monitor ==="
echo "Database: $DB_TYPE"
echo "Host: $DB_HOST"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

check_mysql() {
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "SELECT 1" &>/dev/null; then
        echo "[$TIMESTAMP] MySQL: CONNECTED"
        
        # Check connection count
        CONNECTIONS=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "SHOW STATUS WHERE variable_name='Threads_connected';" 2>/dev/null | tail -1 | awk '{print $2}')
        echo "  Active connections: $CONNECTIONS"
    else
        echo "[$TIMESTAMP] MySQL: CONNECTION FAILED - ALERT!"
    fi
}

check_postgresql() {
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -d postgres -c "SELECT 1" &>/dev/null; then
        echo "[$TIMESTAMP] PostgreSQL: CONNECTED"
    else
        echo "[$TIMESTAMP] PostgreSQL: CONNECTION FAILED - ALERT!"
    fi
}

while true; do
    case $DB_TYPE in
        mysql)
            check_mysql
            ;;
        postgresql)
            check_postgresql
            ;;
        *)
            echo "Unsupported database type: $DB_TYPE"
            exit 1
            ;;
    esac
    
    sleep $CHECK_INTERVAL
done
