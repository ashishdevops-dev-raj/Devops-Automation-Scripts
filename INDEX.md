# Scripts Index

## Quick Reference Guide

### 🐧 Linux Administration (10 scripts)
1. `system-info.sh` - System information report
2. `disk-usage.sh` - Disk usage monitoring  
3. `memory-monitor.sh` - Memory usage tracking
4. `process-monitor.sh` - Process monitoring
5. `service-manager.sh` - Service control
6. `package-updater.sh` - Package management
7. `system-cleanup.sh` - System cleanup
8. `kernel-check.sh` - Kernel status
9. `uptime-reporter.sh` - Uptime tracking
10. `cpu-usage.sh` - CPU monitoring

### 🔒 Security (10 scripts)
1. `firewall-setup.sh` - UFW firewall
2. `ssl-certificate-check.sh` - SSL monitoring
3. `password-generator.sh` - Secure passwords
4. `audit-permissions.sh` - Permission audits
5. `fail2ban-setup.sh` - DDoS protection
6. `ssh-hardening.sh` - SSH security
7. `port-scan.sh` - Port scanning
8. `user-activity-audit.sh` - Activity logging
9. `file-integrity-check.sh` - File monitoring
10. `cron-job-audit.sh` - Cron monitoring

### 📊 Monitoring (10 scripts)
1. `cpu-alert.sh` - CPU alerting
2. `memory-alert.sh` - Memory alerting
3. `disk-alert.sh` - Disk alerting
4. `service-health-check.sh` - Service monitoring
5. `log-monitor.sh` - Log monitoring
6. `port-monitor.sh` - Port monitoring
7. `bandwidth-monitor.sh` - Network bandwidth
8. `response-time-monitor.sh` - Response timing
9. `database-health.sh` - Database monitoring
10. `application-monitor.sh` - Application monitoring

### 💾 Backup & Recovery (10 scripts)
1. `full-backup.sh` - Full system backup
2. `incremental-backup.sh` - Incremental backups
3. `backup-verify.sh` - Backup verification
4. `backup-restore.sh` - Backup restoration
5. `backup-cleanup.sh` - Old backup cleanup
6. `database-backup.sh` - Database backups
7. `backup-encrypt.sh` - Encryption
8. `backup-compress.sh` - Compression
9. `backup-schedule.sh` - Scheduling
10. `backup-report.sh` - Reporting

### 🌐 Network (10 scripts)
1. `network-config.sh` - Interface configuration
2. `dns-lookup.sh` - DNS resolution
3. `connectivity-check.sh` - Connectivity testing
4. `bandwidth-test.sh` - Speed testing
5. `proxy-setup.sh` - Proxy configuration
6. `load-balancer-check.sh` - LB monitoring
7. `vpn-connect.sh` - VPN management
8. `ip-tables-setup.sh` - Firewall rules
9. `network-performance.sh` - Performance testing
10. `route-optimization.sh` - Route optimization

### 👥 User Management (10 scripts)
1. `user-add.sh` - Add users
2. `user-remove.sh` - Remove users
3. `user-modify.sh` - Modify users
4. `user-list.sh` - List users
5. `user-permissions.sh` - Manage permissions
6. `user-groups.sh` - Manage groups
7. `user-quota.sh` - Disk quotas
8. `user-password-reset.sh` - Password reset
9. `user-lock-unlock.sh` - Account control
10. `user-activity-report.sh` - Activity reports

### 📝 Log Management (10 scripts)
1. `log-rotation.sh` - Log rotation
2. `log-compress.sh` - Log compression
3. `log-archive.sh` - Log archiving
4. `log-cleanup.sh` - Log cleanup
5. `log-analyze.sh` - Log analysis
6. `error-log-monitor.sh` - Error monitoring
7. `access-log-parse.sh` - Access log parsing
8. `log-grep-search.sh` - Log searching
9. `log-statistics.sh` - Statistics
10. `log-alert.sh` - Log alerting

---

**Total: 70 Scripts**

## Usage Syntax

```bash
# Make executable
chmod +x <script>.sh

# Run with help
./<script>.sh --help
./<script>.sh          # Shows usage if no args

# With parameters
./<script>.sh param1 param2 param3
```

## Common Operations

### View script help
```bash
./linux/system-info.sh
./backup/full-backup.sh
./monitoring/cpu-alert.sh --help
```

### Run with sudo (if needed)
```bash
sudo ./security/firewall-setup.sh
sudo ./backup/full-backup.sh /backups
```

### Schedule with cron
```bash
0 2 * * * /path/to/backup/full-backup.sh /backups
0 * * * * /path/to/monitoring/cpu-alert.sh 80
*/15 * * * * /path/to/logs/log-monitor.sh
```

### Monitor continuously
```bash
./monitoring/cpu-alert.sh 75 5      # Alert if CPU > 75%, check every 5s
./monitoring/memory-alert.sh 80 10  # Alert if MEM > 80%, check every 10s
./logs/log-monitor.sh               # Monitor logs continuously
```

## Script Categories by Use Case

### For Daily Operations
- system-info.sh, disk-usage.sh, memory-monitor.sh
- process-monitor.sh, service-manager.sh

### For Security
- firewall-setup.sh, ssh-hardening.sh, fail2ban-setup.sh
- audit-permissions.sh, ssl-certificate-check.sh

### For Backups
- full-backup.sh, incremental-backup.sh, backup-verify.sh
- backup-schedule.sh, backup-cleanup.sh

### For Monitoring
- cpu-alert.sh, memory-alert.sh, disk-alert.sh
- service-health-check.sh, log-monitor.sh

### For Administration
- user-add.sh, user-remove.sh, user-list.sh
- package-updater.sh, system-cleanup.sh

### For Troubleshooting
- connectivity-check.sh, dns-lookup.sh, port-scan.sh
- log-analyze.sh, network-performance.sh

---

**Happy DevOps Automation! 🚀**
