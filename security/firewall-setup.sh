#!/bin/bash
# Firewall Configuration Setup
# Configures UFW firewall rules

echo "=== Firewall Setup Script ==="

if ! command -v ufw &> /dev/null; then
    echo "UFW not installed. Installing..."
    sudo apt install ufw -y
fi

read -p "Enable UFW firewall? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo ufw reset
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    
    # Allow common services
    echo "Allowing common services..."
    sudo ufw allow 22/tcp    # SSH
    sudo ufw allow 80/tcp    # HTTP
    sudo ufw allow 443/tcp   # HTTPS
    
    sudo ufw enable
    echo "Firewall enabled"
fi

echo ""
echo "=== Current Firewall Status ==="
sudo ufw status verbose
