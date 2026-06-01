#!/bin/bash
# Disk Usage Monitor
# Reports disk usage for all mounted filesystems

echo "=== Disk Usage Report ==="
df -h | awk 'NR==1 {print; next} {printf "%-15s %10s %10s %10s %5s  %s\n", $1, $2, $3, $4, $5, $6}'

# Alert if any partition is > 80% used
echo ""
echo "=== Usage Alerts ==="
df -h | awk 'NR>1 {gsub("%",""); if ($5+0 > 80) print "WARNING: " $6 " is " $5 "% full"}'
