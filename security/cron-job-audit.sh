#!/bin/bash
# Cron Job Auditor
# Lists and audits all cron jobs on the system

echo "=== Cron Job Audit Report ==="
echo "Report generated: $(date)"
echo ""

# System cron jobs
echo "=== System Cron Jobs ==="
ls -la /etc/cron.* 2>/dev/null | head -5
echo ""

# User cron jobs
echo "=== User Cron Jobs ==="
for user in $(cut -f1 -d: /etc/passwd); do
    CRON=$(crontab -u $user -l 2>/dev/null)
    if [ -n "$CRON" ]; then
        echo "User: $user"
        echo "$CRON"
        echo "---"
    fi
done

# Cron files in cron.d
echo ""
echo "=== Cron.d Directory ==="
ls -la /etc/cron.d/ 2>/dev/null

# At jobs
echo ""
echo "=== At Scheduled Jobs ==="
sudo atq 2>/dev/null || echo "At daemon not running or no jobs scheduled"

echo ""
echo "=== Cron Logs (Last 10 entries) ==="
sudo grep CRON /var/log/syslog 2>/dev/null | tail -10 || sudo journalctl | grep CRON | tail -10
