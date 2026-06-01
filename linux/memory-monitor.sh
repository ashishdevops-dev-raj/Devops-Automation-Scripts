#!/bin/bash
# Memory Usage Monitor
# Tracks memory consumption in real-time

THRESHOLD=${1:-80}

check_memory() {
    TOTAL=$(free | grep Mem | awk '{print $2}')
    USED=$(free | grep Mem | awk '{print $3}')
    PERCENT=$((USED * 100 / TOTAL))
    
    echo "Total Memory: $(numfmt --to=iec $((TOTAL * 1024)) 2>/dev/null || echo $TOTAL) KB"
    echo "Used Memory: $(numfmt --to=iec $((USED * 1024)) 2>/dev/null || echo $USED) KB"
    echo "Memory Usage: $PERCENT%"
    
    if [ $PERCENT -gt $THRESHOLD ]; then
        echo "WARNING: Memory usage is at $PERCENT%!"
        ps aux --sort=-%mem | head -6
    fi
}

check_memory
