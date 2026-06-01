#!/bin/bash
# User Groups
# Manages user groups and membership

USERNAME=${1}
GROUP=${2}
ACTION=${3:-status}

show_help() {
    echo "Usage: $0 <username> [group] {status|add|remove|list}"
    echo ""
    echo "Examples:"
    echo "  $0 john status"
    echo "  $0 john sudo add"
    echo "  $0 john list"
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
        echo "=== User Group Status ==="
        echo "User: $USERNAME"
        echo "Groups:"
        groups $USERNAME
        ;;
    
    add)
        if [ -z "$GROUP" ]; then
            echo "ERROR: Group name required"
            exit 1
        fi
        echo "Adding user $USERNAME to group $GROUP..."
        sudo usermod -aG $GROUP $USERNAME
        echo "User added to group"
        ;;
    
    remove)
        if [ -z "$GROUP" ]; then
            echo "ERROR: Group name required"
            exit 1
        fi
        echo "Removing user $USERNAME from group $GROUP..."
        sudo gpasswd -d $USERNAME $GROUP
        echo "User removed from group"
        ;;
    
    list)
        echo "=== Available Groups ==="
        cat /etc/group | awk -F: '{print $1}' | sort
        ;;
    
    *)
        show_help
        ;;
esac
