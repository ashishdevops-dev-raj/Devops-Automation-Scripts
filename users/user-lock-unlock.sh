#!/bin/bash
# User Lock/Unlock
# Locks or unlocks user accounts

USERNAME=${1}
ACTION=${2:-status}

show_help() {
    echo "Usage: $0 <username> {status|lock|unlock}"
    echo ""
    echo "Examples:"
    echo "  $0 john lock"
    echo "  $0 john unlock"
}

if [ -z "$USERNAME" ]; then
    show_help
    exit 1
fi

if ! id "$USERNAME" &>/dev/null; then
    echo "ERROR: User $USERNAME does not exist"
    exit 1
fi

case $ACTION in
    status)
        echo "=== User Lock Status ==="
        echo "User: $USERNAME"
        
        # Check if account is locked
        SHADOW_LINE=$(sudo grep "^$USERNAME:" /etc/shadow)
        if [[ "$SHADOW_LINE" == *"!"* ]]; then
            echo "Status: LOCKED"
        else
            echo "Status: UNLOCKED"
        fi
        ;;
    
    lock)
        echo "Locking user account: $USERNAME"
        sudo usermod -L $USERNAME
        echo "User account locked"
        ;;
    
    unlock)
        echo "Unlocking user account: $USERNAME"
        sudo usermod -U $USERNAME
        echo "User account unlocked"
        ;;
    
    *)
        show_help
        ;;
esac
