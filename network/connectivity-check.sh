#!/bin/bash
# Connectivity Checker
# Tests connectivity to remote hosts

HOST=${1:-8.8.8.8}
PORT=${2:-80}

echo "=== Network Connectivity Check ==="
echo ""

# Ping test
echo "1. Ping test to $HOST:"
ping -c 4 $HOST
echo ""

# Traceroute
echo "2. Traceroute to $HOST:"
traceroute -m 15 $HOST
echo ""

# Port connectivity
echo "3. Port connectivity test ($HOST:$PORT):"
if timeout 2 bash -c "echo >/dev/tcp/$HOST/$PORT" 2>/dev/null; then
    echo "Port $PORT: OPEN"
else
    echo "Port $PORT: CLOSED/UNREACHABLE"
fi
echo ""

# DNS resolution
echo "4. DNS Resolution:"
nslookup $HOST | grep -A 5 "Name:"
echo ""

# Route information
echo "5. Route Information:"
ip route show | head -5
echo ""

# Network statistics
echo "6. Network Statistics:"
ss -s

echo ""
echo "Connectivity check completed"
