#!/bin/bash
# VPN Connection Manager
# Connects/disconnects from VPN

VPN_CONFIG=${1}
ACTION=${2:-status}

show_help() {
    echo "Usage: $0 <vpn_config> {connect|disconnect|status}"
    echo ""
    echo "Example:"
    echo "  $0 company-vpn.ovpn connect"
}

if [ -z "$VPN_CONFIG" ] && [ "$ACTION" != "status" ]; then
    show_help
    exit 1
fi

case $ACTION in
    connect)
        if [ ! -f "$VPN_CONFIG" ]; then
            echo "ERROR: VPN config not found: $VPN_CONFIG"
            exit 1
        fi
        
        echo "Connecting to VPN using: $VPN_CONFIG"
        sudo openvpn --config "$VPN_CONFIG"
        ;;
    
    disconnect)
        echo "Disconnecting from VPN..."
        sudo killall openvpn
        ;;
    
    status)
        echo "=== VPN Status ==="
        if pgrep -x openvpn > /dev/null; then
            echo "VPN: CONNECTED"
            sudo openvpn --show-net
        else
            echo "VPN: DISCONNECTED"
        fi
        
        echo ""
        echo "Available VPN configs:"
        ls -la *.ovpn 2>/dev/null || echo "No .ovpn files found"
        ;;
    
    *)
        show_help
        ;;
esac
