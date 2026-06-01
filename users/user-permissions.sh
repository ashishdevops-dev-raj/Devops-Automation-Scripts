#!/bin/bash
# User Permissions
# Manages user file permissions

FILE=${1}
PERMISSION=${2}
ACTION=${3:-set}

show_help() {
    echo "Usage: $0 <file> <permission> {set|add|remove}"
    echo ""
    echo "Examples:"
    echo "  $0 script.sh 755 set"
    echo "  $0 script.sh +x add"
    echo "  $0 script.sh g+w add"
}

if [ -z "$FILE" ] || [ -z "$PERMISSION" ]; then
    show_help
    exit 1
fi

if [ ! -e "$FILE" ]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

echo "=== User Permissions Manager ==="
echo "File: $FILE"
echo "Current permissions: $(ls -l "$FILE" | awk '{print $1}')"
echo ""

case $ACTION in
    set)
        echo "Setting permissions to: $PERMISSION"
        chmod $PERMISSION "$FILE"
        ;;
    
    add)
        echo "Adding permissions: $PERMISSION"
        chmod +$PERMISSION "$FILE"
        ;;
    
    remove)
        echo "Removing permissions: $PERMISSION"
        chmod -$PERMISSION "$FILE"
        ;;
    
    *)
        show_help
        ;;
esac

if [ $? -eq 0 ]; then
    echo "New permissions: $(ls -l "$FILE" | awk '{print $1}')"
fi
