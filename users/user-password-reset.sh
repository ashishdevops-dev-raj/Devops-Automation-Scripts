#!/bin/bash
# User Password Reset
# Safely resets user passwords

USERNAME=${1}

show_help() {
    echo "Usage: $0 <username>"
    echo ""
    echo "Example:"
    echo "  $0 john"
}

if [ -z "$USERNAME" ]; then
    show_help
    exit 1
fi

if ! id "$USERNAME" &>/dev/null; then
    echo "ERROR: User $USERNAME does not exist"
    exit 1
fi

echo "=== User Password Reset ==="
echo "User: $USERNAME"
echo ""

# Show password info
PASS_INFO=$(sudo chage -l $USERNAME 2>/dev/null)
echo "Current password status:"
echo "$PASS_INFO"
echo ""

read -p "Reset password for $USERNAME? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled"
    exit 1
fi

echo "Enter new password for $USERNAME:"
sudo passwd $USERNAME

if [ $? -eq 0 ]; then
    echo "Password reset successfully"
    
    # Force password change on next login
    read -p "Force password change on next login? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo chage -d 0 $USERNAME
        echo "User will be required to change password on next login"
    fi
fi
