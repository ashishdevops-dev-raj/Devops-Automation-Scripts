#!/bin/bash
# User Activity Auditor
# Monitors and audits user activities on the system

echo "=== User Activity Audit Report ==="
echo "Report generated: $(date)"
echo ""

# Active logged-in users
echo "=== Currently Logged-In Users ==="
who

# Last login information
echo ""
echo "=== Recent User Logins ==="
lastlog -t 7 | head -20

# User command history
echo ""
echo "=== Recent sudo Commands ==="
sudo journalctl SYSLOG_IDENTIFIER=sudo -n 10 --no-pager

# Failed login attempts
echo ""
echo "=== Failed Login Attempts (Last 24 hours) ==="
sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 || echo "No failed attempts found"

# Users with shell access
echo ""
echo "=== Users with Shell Access ==="
grep -v nologin /etc/passwd | grep -v false | awk -F: '{print $1, "(" $3 ")"}'
