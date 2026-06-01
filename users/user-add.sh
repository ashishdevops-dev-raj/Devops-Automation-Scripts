#!/bin/bash
# User Add
# Adds a new user to the system

USERNAME=${1}
SHELL=${2:-/bin/bash}
HOMEDIR=${3:-/home/$USERNAME}

show_help() {
    echo "Usage: $0 <username> [shell] [home_directory]"
    echo ""
    echo "Examples:"
    echo "  $0 john"
    echo "  $0 john /bin/bash /home/john"
}

if [ -z "$USERNAME" ]; then
    show_help
    exit 1
fi

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo "ERROR: User $USERNAME already exists"
    exit 1
fi

echo "=== Adding New User ==="
echo "Username: $USERNAME"
echo "Shell: $SHELL"
echo "Home: $HOMEDIR"
echo ""

read -p "Create user $USERNAME? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled"
    exit 1
fi

sudo useradd -m -s $SHELL -d $HOMEDIR $USERNAME

if [ $? -eq 0 ]; then
    echo "User created successfully"
    
    # Set password
    read -p "Set password for $USERNAME? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo passwd $USERNAME
    fi
    
    # Show user info
    echo ""
    echo "User information:"
    id $USERNAME
else
    echo "ERROR: Failed to create user"
    exit 1
fi
