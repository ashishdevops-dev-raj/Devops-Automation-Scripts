#!/bin/bash
# Service Manager
# Manage system services

ACTION=${1:-status}
SERVICE=${2}

show_help() {
    echo "Usage: $0 {start|stop|restart|status|enable|disable} [service_name]"
    echo ""
    echo "Examples:"
    echo "  $0 status nginx"
    echo "  $0 restart postgresql"
    echo "  $0 enable ssh"
}

case $ACTION in
    start|stop|restart|enable|disable)
        if [ -z "$SERVICE" ]; then
            echo "Error: Service name required"
            show_help
            exit 1
        fi
        sudo systemctl $ACTION $SERVICE
        ;;
    status)
        if [ -z "$SERVICE" ]; then
            echo "=== Active Services ==="
            systemctl list-units --type=service --state=running --no-pager
        else
            systemctl status $SERVICE
        fi
        ;;
    *)
        show_help
        ;;
esac
