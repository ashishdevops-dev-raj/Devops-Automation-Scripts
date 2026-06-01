#!/bin/bash
# DNS Lookup Utility
# Performs various DNS lookups and diagnostics

DOMAIN=${1}
RECORD_TYPE=${2:-A}

show_help() {
    echo "Usage: $0 <domain> [record_type]"
    echo ""
    echo "Record types: A, AAAA, MX, NS, CNAME, TXT, SOA, ALL"
    echo ""
    echo "Examples:"
    echo "  $0 example.com A"
    echo "  $0 example.com MX"
    echo "  $0 example.com ALL"
}

if [ -z "$DOMAIN" ]; then
    show_help
    exit 1
fi

echo "=== DNS Lookup Results for $DOMAIN ==="
echo ""

case $RECORD_TYPE in
    A|AAAA|MX|NS|CNAME|TXT|SOA)
        echo "$RECORD_TYPE Records:"
        dig +short $DOMAIN $RECORD_TYPE
        ;;
    ALL)
        echo "A Records:"
        dig +short $DOMAIN A
        echo ""
        echo "AAAA Records:"
        dig +short $DOMAIN AAAA
        echo ""
        echo "MX Records:"
        dig +short $DOMAIN MX
        echo ""
        echo "NS Records:"
        dig +short $DOMAIN NS
        echo ""
        echo "TXT Records:"
        dig +short $DOMAIN TXT
        ;;
    *)
        show_help
        ;;
esac

echo ""
echo "=== Reverse Lookup ==="
dig +short -x $(dig +short $DOMAIN A | head -1)

echo ""
echo "=== Full Trace ==="
dig $DOMAIN +trace
