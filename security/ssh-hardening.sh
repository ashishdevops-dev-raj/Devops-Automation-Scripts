#!/bin/bash
# SSH Hardening Script
# Hardens SSH configuration for better security

echo "=== SSH Hardening Script ==="

SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP_FILE="${SSH_CONFIG}.backup.$(date +%s)"

echo "Creating backup of current SSH config..."
sudo cp $SSH_CONFIG $BACKUP_FILE
echo "Backup saved to: $BACKUP_FILE"

echo ""
echo "Applying SSH hardening configurations..."

# Create hardened SSH config
sudo tee -a $SSH_CONFIG > /dev/null <<EOF

# SSH Hardening
Protocol 2
Port 22
AddressFamily inet
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
PermitEmptyPasswords no
X11Forwarding no
MaxAuthTries 3
MaxSessions 5
ClientAliveInterval 300
ClientAliveCountMax 2
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
KexAlgorithms curve25519-sha256
HostKeyAlgorithms ecdsa-sha2-nistp256
EOF

# Validate SSH config
echo "Validating SSH configuration..."
sudo sshd -t

if [ $? -eq 0 ]; then
    echo "SSH configuration is valid"
    read -p "Restart SSH service? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo systemctl restart ssh
        echo "SSH service restarted"
    fi
else
    echo "ERROR: SSH configuration validation failed"
    echo "Restoring backup..."
    sudo cp $BACKUP_FILE $SSH_CONFIG
fi
