#!/bin/bash
# Network Performance Test
# Tests network performance metrics

TEST_HOST=${1:-8.8.8.8}
DURATION=${2:-10}

echo "=== Network Performance Test ==="
echo "Target: $TEST_HOST"
echo "Duration: $DURATION seconds"
echo ""

# Latency and jitter
echo "1. Latency Test (ping):"
ping -c 10 $TEST_HOST | tail -1

# Packet loss
echo ""
echo "2. Packet Loss Test:"
ping -c 100 $TEST_HOST | grep "packet loss"

# DNS response time
echo ""
echo "3. DNS Response Time:"
time dig $TEST_HOST +short

# TCP connection time
echo ""
echo "4. TCP Connection Time:"
echo "Testing connection to $TEST_HOST:80..."
time timeout 5 bash -c "echo >/dev/tcp/$TEST_HOST/80" 2>/dev/null

# Network interface stats
echo ""
echo "5. Network Interface Statistics:"
ifstat -i eth0 1 5 2>/dev/null || netstat -i | head -3

# MTU check
echo ""
echo "6. MTU Size Check:"
ip link show | grep mtu

echo ""
echo "Performance test completed"
