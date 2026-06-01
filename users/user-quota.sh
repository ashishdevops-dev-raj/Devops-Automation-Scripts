#!/bin/bash
# User Quota
# Sets and manages user disk quotas

USERNAME=${1}
QUOTA=${2}
DEVICE=${3:-/}

show_help() {
    echo "Usage: $0 <username> <quota_GB> [device]"
    echo ""
    echo "Examples:"
    echo "  $0 john 10"
    echo "  $0 john 50 /home"
}

if [ -z "$USERNAME" ] || [ -z "$QUOTA" ]; then
    show_help
    exit 1
fi

if ! id "$USERNAME" &>/dev/null; then
    echo "ERROR: User $USERNAME does not exist"
    exit 1
fi

# Convert GB to blocks (1GB = 1048576 blocks of 1K)
BLOCKS=$((QUOTA * 1048576))
INODES=$((QUOTA * 1024))

echo "=== User Quota Manager ==="
echo "User: $USERNAME"
echo "Quota: ${QUOTA}GB"
echo "Device: $DEVICE"
echo ""

# Check if quota is enabled
if ! grep -q usrquota /etc/fstab; then
    echo "WARNING: User quotas may not be enabled on this system"
    echo "To enable, add 'usrquota' option to fstab entry for $DEVICE"
fi

# Get UID
UID=$(id -u $USERNAME)

echo "Setting quota..."
sudo setquota -u $UID $BLOCKS $((BLOCKS * 2)) $INODES $((INODES * 2)) $DEVICE

if [ $? -eq 0 ]; then
    echo "Quota set successfully"
    echo ""
    echo "Current quota:"
    sudo quota -u $USERNAME
fi
