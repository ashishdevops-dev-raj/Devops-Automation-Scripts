#!/bin/bash
# Bandwidth Speed Test
# Tests network bandwidth speed

TARGET_HOST=${1:-speedtest.net}
DURATION=${2:-10}

echo "=== Network Bandwidth Test ==="
echo "Target: $TARGET_HOST"
echo "Duration: $DURATION seconds"
echo ""

# iPerf-based test (if available)
if command -v iperf3 &> /dev/null; then
    echo "Running iperf3 test..."
    iperf3 -c $TARGET_HOST -t $DURATION
else
    # Alternative: wget/curl speed test
    echo "Using wget for speed test..."
    
    TEST_FILE="http://$TARGET_HOST/100mb"
    
    wget -O /dev/null "$TEST_FILE" 2>&1 | grep "Saving to" | awk '{print "Download speed: " $0}'
fi

# TCP/UDP throughput test using nc
if command -v nc &> /dev/null; then
    echo ""
    echo "Testing local network throughput..."
    (sleep 1; cat /dev/zero) | nc -l -p 5555 > /dev/null &
    dd if=/dev/zero | nc localhost 5555 count=1000 2>&1 | tail -1
fi
