#!/bin/bash
# Bandwidth Monitor
# Monitors network bandwidth usage

INTERFACE=${1:-eth0}
CHECK_INTERVAL=${2:-5}

echo "=== Network Bandwidth Monitor ==="
echo "Interface: $INTERFACE"
echo "Check interval: $CHECK_INTERVAL seconds"
echo ""

RX_PREV=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes 2>/dev/null || echo 0)
TX_PREV=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes 2>/dev/null || echo 0)

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    RX_CURR=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    TX_CURR=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    
    RX_DIFF=$((RX_CURR - RX_PREV))
    TX_DIFF=$((TX_CURR - TX_PREV))
    
    RX_MBPS=$(echo "scale=2; $RX_DIFF / 1024 / 1024 / $CHECK_INTERVAL" | bc)
    TX_MBPS=$(echo "scale=2; $TX_DIFF / 1024 / 1024 / $CHECK_INTERVAL" | bc)
    
    echo "[$TIMESTAMP] RX: ${RX_MBPS} MB/s | TX: ${TX_MBPS} MB/s"
    
    RX_PREV=$RX_CURR
    TX_PREV=$TX_CURR
    
    sleep $CHECK_INTERVAL
done
