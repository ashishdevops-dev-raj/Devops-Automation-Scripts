#!/bin/bash
# Access Log Parser
# Parses and analyzes web access logs

LOG_FILE=${1:-/var/log/nginx/access.log}

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file not found: $LOG_FILE"
    exit 1
fi

echo "=== Access Log Analysis ==="
echo "File: $LOG_FILE"
echo ""

# Total requests
echo "=== Request Statistics ==="
echo "Total requests: $(wc -l < "$LOG_FILE")"
echo ""

# Top 10 IPs
echo "=== Top 10 IP Addresses ==="
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo ""

# Top 10 URLs
echo "=== Top 10 Requested URLs ==="
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo ""

# HTTP Status Codes
echo "=== HTTP Status Codes ==="
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
echo ""

# Bandwidth usage
echo "=== Bandwidth Usage ==="
awk '{sum+=$10} END {printf "Total: %.2f MB\n", sum/1024/1024}' "$LOG_FILE"
echo ""

# User Agents
echo "=== Top 5 User Agents ==="
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
