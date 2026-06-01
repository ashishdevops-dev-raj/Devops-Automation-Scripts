#!/bin/bash
# Package Updater
# Updates system packages safely

echo "=== Package Update Script ==="
echo "This script will update your system packages"

read -p "Do you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Update cancelled"
    exit 1
fi

# Detect OS and update accordingly
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        ubuntu|debian)
            echo "Detected Debian/Ubuntu system"
            sudo apt update
            sudo apt upgrade -y
            sudo apt autoremove -y
            ;;
        centos|rhel|fedora)
            echo "Detected RedHat-based system"
            sudo yum update -y
            ;;
        *)
            echo "Unknown distribution: $ID"
            ;;
    esac
fi

echo "Update completed!"
