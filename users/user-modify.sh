#!/bin/bash
# User Modify
# Modifies user account settings

USERNAME=${1}
ACTION=${2:-status}

show_help() {
    echo "Usage: $0 <username> {status|rename|shell|home|lock|unlock}"
    echo ""
    echo "Examples:"
    echo "  $0 john status"
    echo "  $0 john shell /bin/zsh"
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
        echo "=== User Status ==="
        id $USERNAME
        ;;
    
    rename)
        NEW_NAME=${3}
        if [ -z "$NEW_NAME" ]; then
            echo "ERROR: New username required"
            exit 1
        fi
        echo "Renaming user from $USERNAME to $NEW_NAME..."
        sudo usermod -l $NEW_NAME $USERNAME
        ;;
    
    shell)
        NEW_SHELL=${3}
        if [ -z "$NEW_SHELL" ]; then
            echo "ERROR: Shell path required"
            exit 1
        fi
        echo "Changing shell from $(grep $USERNAME /etc/passwd | cut -d: -f7) to $NEW_SHELL"
        sudo usermod -s $NEW_SHELL $USERNAME
        ;;
    
    home)
        NEW_HOME=${3}
        if [ -z "$NEW_HOME" ]; then
            echo "ERROR: Home directory path required"
            exit 1
        fi
        echo "Moving home directory..."
        sudo usermod -d $NEW_HOME -m $USERNAME
        ;;
    
    lock)
        echo "Locking user $USERNAME..."
        sudo usermod -L $USERNAME
        echo "User locked"
        ;;
    
    unlock)
        echo "Unlocking user $USERNAME..."
        sudo usermod -U $USERNAME
        echo "User unlocked"
        ;;
    
    *)
        show_help
        ;;
esac
