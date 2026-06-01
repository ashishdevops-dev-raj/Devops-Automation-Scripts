#!/bin/bash
# Uptime Reporter
# Reports system uptime in various formats

UPTIME_SECONDS=$(grep -oP '^\d+' /proc/uptime)

DAYS=$((UPTIME_SECONDS / 86400))
HOURS=$(((UPTIME_SECONDS % 86400) / 3600))
MINUTES=$(((UPTIME_SECONDS % 3600) / 60))
SECONDS=$((UPTIME_SECONDS % 60))

echo "=== System Uptime Report ==="
echo "System has been up for:"
echo "  $DAYS days, $HOURS hours, $MINUTES minutes, $SECONDS seconds"
echo ""
echo "Total uptime: $(uptime -p)"
echo "Current time: $(date)"
echo "System boot time: $(who -b | awk '{print $3, $4}')"

# Calculate system availability percentage
AVAILABILITY=$((UPTIME_SECONDS * 100 / (UPTIME_SECONDS + 1)))
echo "Availability: ~$AVAILABILITY%"
