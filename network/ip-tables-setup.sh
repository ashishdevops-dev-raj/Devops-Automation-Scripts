#!/bin/bash
# IP Tables Setup
# Configures firewall rules using iptables

ACTION=${1:-status}
PROTOCOL=${2:-tcp}
PORT=${3:-80}

show_help() {
    echo "Usage: $0 {status|allow|deny|flush} [protocol] [port]"
    echo ""
    echo "Examples:"
    echo "  $0 allow tcp 22"
    echo "  $0 deny tcp 23"
    echo "  $0 status"
}

case $ACTION in
    status)
        echo "=== IPTables Status ==="
        sudo iptables -L -v -n
        ;;
    
    allow)
        echo "Allowing $PROTOCOL traffic on port $PORT..."
        sudo iptables -A INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
        sudo iptables -A FORWARD -p $PROTOCOL --dport $PORT -j ACCEPT
        echo "Rule added"
        ;;
    
    deny)
        echo "Denying $PROTOCOL traffic on port $PORT..."
        sudo iptables -A INPUT -p $PROTOCOL --dport $PORT -j DROP
        sudo iptables -A FORWARD -p $PROTOCOL --dport $PORT -j DROP
        echo "Rule added"
        ;;
    
    flush)
        echo "Flushing all iptables rules..."
        read -p "Are you sure? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo iptables -F
            sudo iptables -X
            echo "Rules flushed"
        fi
        ;;
    
    *)
        show_help
        ;;
esac
