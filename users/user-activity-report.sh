#!/bin/bash
# User Activity Report
# Generates comprehensive user activity reports

USERNAME=${1}

show_help() {
    echo "Usage: $0 [username]"
    echo ""
    echo "Examples:"
    echo "  $0                # All users"
    echo "  $0 john           # Specific user"
}

echo "=== User Activity Report ==="
echo "Generated: $(date)"
echo ""

if [ -z "$USERNAME" ]; then
    echo "=== All Active Users ==="
    w
else
    if ! id "$USERNAME" &>/dev/null; then
        echo "ERROR: User $USERNAME does not exist"
        exit 1
    fi
    
    echo "=== User: $USERNAME ==="
    echo ""
    
    echo "1. User Information:"
    id $USERNAME
    echo ""
    
    echo "2. Login History:"
    lastlog -u $USERNAME | head -5
    echo ""
    
    echo "3. Sudo Commands:"
    sudo grep "$(id -un $USERNAME)" /var/log/auth.log 2>/dev/null | grep "COMMAND" | tail -5
    echo ""
    
    echo "4. File Ownership:"
    find /home -user $USERNAME -type f 2>/dev/null | wc -l | awk '{print "Files owned: " $1}'
    echo ""
    
    echo "5. Group Membership:"
    groups $USERNAME
    echo ""
    
    echo "6. Recent Commands:"
    grep "^$USERNAME" ~/.bash_history 2>/dev/null | tail -5 || echo "No command history available"
fi
