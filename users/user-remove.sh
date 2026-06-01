#!/bin/bash
# User Remove
# Removes a user from the system

USERNAME=${1}
REMOVE_HOME=${2:-false}

show_help() {
    echo "Usage: $0 <username> [remove_home: true/false]"
    echo ""
    echo "Examples:"
    echo "  $0 john false"
    echo "  $0 john true"
}

if [ -z "$USERNAME" ]; then
    show_help
    exit 1
fi

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "ERROR: User $USERNAME does not exist"
    exit 1
fi

echo "=== Removing User ==="
echo "Username: $USERNAME"
echo "Remove home directory: $REMOVE_HOME"
echo ""

# Show user info before deletion
echo "User to be deleted:"
id $USERNAME

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled"
    exit 1
fi

if [ "$REMOVE_HOME" = "true" ]; then
    echo "Removing user and home directory..."
    sudo userdel -r $USERNAME
else
    echo "Removing user (keeping home directory)..."
    sudo userdel $USERNAME
fi

if [ $? -eq 0 ]; then
    echo "User removed successfully"
else
    echo "ERROR: Failed to remove user"
    exit 1
fi
