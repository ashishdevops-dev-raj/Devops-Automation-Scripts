#!/bin/bash
# CPU Usage Monitor
# Displays CPU usage statistics

echo "=== CPU Usage Report ==="
echo "CPU Load Averages:"
uptime | awk -F'load average:' '{print $2}'

echo ""
echo "Per-CPU Usage:"
mpstat 1 1 2>/dev/null | tail -n +4

echo ""
echo "Top CPU Consuming Processes:"
ps aux --sort=-%cpu | head -6 | awk '{printf "%-10s %5s%%  %s\n", $1, $3, $11}'
