#!/bin/bash
# Proxy Setup and Configuration
# Configures system proxy settings

PROXY_HOST=${1}
PROXY_PORT=${2:-3128}
ACTION=${3:-set}

show_help() {
    echo "Usage: $0 <proxy_host> [port] {set|unset|test}"
    echo ""
    echo "Examples:"
    echo "  $0 proxy.example.com 3128 set"
    echo "  $0 proxy.example.com 3128 test"
}

if [ -z "$PROXY_HOST" ] && [ "$ACTION" != "unset" ]; then
    show_help
    exit 1
fi

case $ACTION in
    set)
        echo "Setting proxy: $PROXY_HOST:$PROXY_PORT"
        
        export http_proxy="http://$PROXY_HOST:$PROXY_PORT"
        export https_proxy="http://$PROXY_HOST:$PROXY_PORT"
        export ftp_proxy="http://$PROXY_HOST:$PROXY_PORT"
        export HTTP_PROXY="http://$PROXY_HOST:$PROXY_PORT"
        export HTTPS_PROXY="http://$PROXY_HOST:$PROXY_PORT"
        export FTP_PROXY="http://$PROXY_HOST:$PROXY_PORT"
        
        # For apt (Debian/Ubuntu)
        sudo tee /etc/apt/apt.conf.d/90proxy > /dev/null <<EOF
Acquire::http::Proxy "http://$PROXY_HOST:$PROXY_PORT";
Acquire::https::Proxy "http://$PROXY_HOST:$PROXY_PORT";
Acquire::ftp::Proxy "http://$PROXY_HOST:$PROXY_PORT";
EOF
        
        echo "Proxy set successfully"
        ;;
    
    unset)
        echo "Unsetting proxy..."
        unset http_proxy https_proxy ftp_proxy
        unset HTTP_PROXY HTTPS_PROXY FTP_PROXY
        sudo rm /etc/apt/apt.conf.d/90proxy 2>/dev/null
        echo "Proxy unset"
        ;;
    
    test)
        echo "Testing proxy connection..."
        curl -I -x "http://$PROXY_HOST:$PROXY_PORT" http://example.com 2>&1 | head -5
        ;;
    
    *)
        show_help
        ;;
esac
