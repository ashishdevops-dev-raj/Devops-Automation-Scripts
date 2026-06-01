#!/bin/bash
# Network Configuration
# Configures network interfaces and settings

INTERFACE=${1}
ACTION=${2:-status}

show_help() {
    echo "Usage: $0 <interface> {status|up|down|restart|dhcp|static <ip> <netmask> <gateway>}"
    echo ""
    echo "Examples:"
    echo "  $0 eth0 status"
    echo "  $0 eth0 up"
    echo "  $0 eth0 dhcp"
    echo "  $0 eth0 static 192.168.1.10 255.255.255.0 192.168.1.1"
}

if [ -z "$INTERFACE" ]; then
    show_help
    exit 1
fi

case $ACTION in
    status)
        echo "=== Network Interface Status ==="
        ip addr show $INTERFACE
        ip link show $INTERFACE
        ;;
    up)
        echo "Bringing up interface: $INTERFACE"
        sudo ip link set $INTERFACE up
        ;;
    down)
        echo "Bringing down interface: $INTERFACE"
        sudo ip link set $INTERFACE down
        ;;
    restart)
        echo "Restarting interface: $INTERFACE"
        sudo ip link set $INTERFACE down
        sleep 1
        sudo ip link set $INTERFACE up
        ;;
    dhcp)
        echo "Configuring $INTERFACE for DHCP..."
        sudo dhclient $INTERFACE
        ;;
    static)
        IP=$3
        NETMASK=$4
        GATEWAY=$5
        echo "Configuring $INTERFACE as static: $IP/$NETMASK"
        sudo ip addr add $IP/$NETMASK dev $INTERFACE
        sudo ip route add default via $GATEWAY
        ;;
    *)
        show_help
        ;;
esac
