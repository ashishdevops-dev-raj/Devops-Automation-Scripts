#!/bin/bash
# Kernel Version Checker
# Checks current kernel and available updates

echo "=== Kernel Information ==="
echo "Current Kernel: $(uname -r)"
echo "Kernel Release: $(cat /proc/version)"
echo "Architecture: $(uname -m)"
echo ""

if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" =~ "ubuntu" ]] || [[ "$ID" =~ "debian" ]]; then
        echo "=== Available Kernel Updates ==="
        apt list --upgradable 2>/dev/null | grep -i linux-image || echo "Kernel is up to date"
    fi
fi

echo ""
echo "=== Kernel Boot Parameters ==="
cat /proc/cmdline | tr ' ' '\n'
