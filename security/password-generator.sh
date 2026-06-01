#!/bin/bash
# Secure Password Generator
# Generates cryptographically secure passwords

LENGTH=${1:-16}
SPECIAL_CHARS=${2:-true}

if [ "$LENGTH" -lt 8 ]; then
    echo "Error: Password length must be at least 8 characters"
    exit 1
fi

generate_password() {
    if [ "$SPECIAL_CHARS" = "true" ]; then
        openssl rand -base64 $((LENGTH * 2)) | tr -d '=' | cut -c1-$LENGTH
    else
        openssl rand -base64 $((LENGTH * 2)) | tr -cd '[:alnum:]' | head -c $LENGTH
    fi
}

echo "=== Password Generator ==="
echo "Generated passwords:"
echo ""

for i in {1..5}; do
    echo "  Password $i: $(generate_password)"
done

echo ""
echo "Usage: $0 [length] [special_chars: true/false]"
