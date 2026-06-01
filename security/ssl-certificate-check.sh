#!/bin/bash
# SSL Certificate Checker
# Monitors SSL certificate expiration dates

check_certificate() {
    local domain=$1
    local port=${2:-443}
    
    echo "Checking certificate for: $domain:$port"
    
    EXPIRY=$(echo | openssl s_client -servername $domain -connect $domain:$port 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)
    EXPIRY_EPOCH=$(date -d "$EXPIRY" +%s)
    NOW_EPOCH=$(date +%s)
    DAYS_LEFT=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))
    
    echo "  Expiry Date: $EXPIRY"
    echo "  Days Left: $DAYS_LEFT"
    
    if [ $DAYS_LEFT -lt 30 ]; then
        echo "  WARNING: Certificate expires in less than 30 days!"
    fi
    echo ""
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 domain.com [port]"
    echo "Example: $0 example.com 443"
    exit 1
fi

check_certificate "$@"
