#!/bin/bash
# Port Scanner
# Scans for open ports on the system

PORT_RANGE=${1:-1-65535}
HOST=${2:-localhost}

echo "=== Network Port Scanner ==="
echo "Scanning $HOST for open ports in range $PORT_RANGE"
echo ""

# Using nc (netcat) for quick scan
echo "Open ports detected:"
for port in $(seq 1 65535); do
    timeout 0.1 bash -c "echo >/dev/tcp/$HOST/$port" 2>/dev/null && echo "Port $port: OPEN"
done

echo ""
echo "=== Listening Ports on Local System ==="
sudo netstat -tlnp 2>/dev/null | grep LISTEN || ss -tlnp | grep LISTEN
