#!/bin/bash
# Process Monitor
# Lists top processes by CPU and memory usage

echo "=== Top 10 Processes by CPU Usage ==="
ps aux --sort=-%cpu | head -11

echo ""
echo "=== Top 10 Processes by Memory Usage ==="
ps aux --sort=-%mem | head -11

echo ""
echo "=== Process Count by User ==="
ps aux | awk '{print $1}' | sort | uniq -c | sort -rn
