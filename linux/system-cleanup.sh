#!/bin/bash
# System Cleanup
# Removes temporary files and caches

echo "=== System Cleanup Script ==="

# Clean package manager cache
echo "Cleaning package manager cache..."
sudo apt clean
sudo apt autoclean
sudo apt autoremove -y

# Clean temporary files
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean log files older than 30 days
echo "Cleaning old log files..."
sudo find /var/log -type f -mtime +30 -delete

# Clean systemd journal
echo "Cleaning systemd journal..."
sudo journalctl --vacuum=30d

# Clean pip cache
echo "Cleaning pip cache..."
pip cache purge

echo "Cleanup completed! Freed space:"
df -h | grep -E '/$'
