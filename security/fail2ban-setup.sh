#!/bin/bash
# Fail2Ban Setup and Configuration
# Installs and configures fail2ban for brute force protection

echo "=== Fail2Ban Setup ==="

# Install fail2ban
if ! command -v fail2ban-client &> /dev/null; then
    echo "Installing fail2ban..."
    sudo apt install fail2ban -y
fi

# Create jail configuration
echo "Configuring fail2ban..."
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log

[recidive]
enabled = true
filter = recidive
action = iptables-multiport[name=recidive, port="http,https,ssh"]
logpath = /var/log/fail2ban.log
bantime = 604800
findtime = 86400
maxretry = 5
EOF

# Start fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

echo ""
echo "=== Fail2Ban Status ==="
sudo fail2ban-client status
