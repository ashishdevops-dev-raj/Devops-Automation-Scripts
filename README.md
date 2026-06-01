# DevOps Automation Scripts Repository

A comprehensive collection of **70+ useful Bash scripts** for DevOps, system administration, and infrastructure management.

## 📁 Repository Structure

```
devops-automation-scripts/
├── linux/              # System administration (10 scripts)
├── security/           # Security and hardening (10 scripts)
├── monitoring/         # System monitoring (10 scripts)
├── backup/             # Backup & recovery (10 scripts)
├── network/            # Network configuration (10 scripts)
├── users/              # User management (10 scripts)
├── logs/               # Log management (10 scripts)
└── README.md
```

## 🚀 Categories

### Linux Administration (linux/)
Essential system administration scripts for monitoring and management.

| Script | Purpose |
|--------|---------|
| `system-info.sh` | Display comprehensive system information |
| `disk-usage.sh` | Report disk usage for all filesystems |
| `memory-monitor.sh` | Track memory consumption with alerts |
| `process-monitor.sh` | List top CPU and memory consuming processes |
| `service-manager.sh` | Start/stop/restart system services |
| `package-updater.sh` | Update system packages safely |
| `system-cleanup.sh` | Clean temporary files and caches |
| `kernel-check.sh` | Check kernel version and updates |
| `uptime-reporter.sh` | Report system uptime statistics |
| `cpu-usage.sh` | Display CPU usage and top processes |

### Security (security/)
Security hardening and audit scripts.

| Script | Purpose |
|--------|---------|
| `firewall-setup.sh` | Configure UFW firewall rules |
| `ssl-certificate-check.sh` | Monitor SSL certificate expiration |
| `password-generator.sh` | Generate cryptographically secure passwords |
| `audit-permissions.sh` | Audit file permissions and SUID files |
| `fail2ban-setup.sh` | Install and configure fail2ban |
| `ssh-hardening.sh` | Harden SSH configuration |
| `port-scan.sh` | Scan for open ports |
| `user-activity-audit.sh` | Monitor user activities |
| `file-integrity-check.sh` | Monitor file integrity with checksums |
| `cron-job-audit.sh` | Audit scheduled cron jobs |

### Monitoring (monitoring/)
Real-time system monitoring and alerting scripts.

| Script | Purpose |
|--------|---------|
| `cpu-alert.sh` | Alert on high CPU usage |
| `memory-alert.sh` | Alert on high memory usage |
| `disk-alert.sh` | Alert on low disk space |
| `service-health-check.sh` | Monitor critical services |
| `log-monitor.sh` | Monitor logs for errors |
| `port-monitor.sh` | Monitor specific ports |
| `bandwidth-monitor.sh` | Monitor network bandwidth |
| `response-time-monitor.sh` | Monitor HTTP response times |
| `database-health.sh` | Check database connectivity |
| `application-monitor.sh` | Monitor application processes |

### Backup & Recovery (backup/)
Comprehensive backup and recovery scripts.

| Script | Purpose |
|--------|---------|
| `full-backup.sh` | Create complete system backups |
| `incremental-backup.sh` | Create incremental backups |
| `backup-verify.sh` | Verify backup integrity |
| `backup-restore.sh` | Restore files from backups |
| `backup-cleanup.sh` | Remove old backups (retention policy) |
| `database-backup.sh` | Backup MySQL or PostgreSQL |
| `backup-encrypt.sh` | Encrypt backups with GPG |
| `backup-compress.sh` | Compress backups (gzip/bzip2/xz) |
| `backup-schedule.sh` | Schedule automated backups |
| `backup-report.sh` | Generate backup status reports |

### Network Management (network/)
Network configuration and monitoring scripts.

| Script | Purpose |
|--------|---------|
| `network-config.sh` | Configure network interfaces |
| `dns-lookup.sh` | Perform DNS lookups and diagnostics |
| `connectivity-check.sh` | Test network connectivity |
| `bandwidth-test.sh` | Test network bandwidth speed |
| `proxy-setup.sh` | Configure system proxy settings |
| `load-balancer-check.sh` | Monitor load balancer health |
| `vpn-connect.sh` | Manage VPN connections |
| `ip-tables-setup.sh` | Configure firewall rules |
| `network-performance.sh` | Test network performance |
| `route-optimization.sh` | Optimize network routing |

### User Management (users/)
User and permission management scripts.

| Script | Purpose |
|--------|---------|
| `user-add.sh` | Add new users to system |
| `user-remove.sh` | Remove users safely |
| `user-modify.sh` | Modify user settings |
| `user-list.sh` | List system users |
| `user-permissions.sh` | Manage file permissions |
| `user-groups.sh` | Manage user groups |
| `user-quota.sh` | Set user disk quotas |
| `user-password-reset.sh` | Reset user passwords |
| `user-lock-unlock.sh` | Lock/unlock user accounts |
| `user-activity-report.sh` | Generate user activity reports |

### Log Management (logs/)
Log processing and analysis scripts.

| Script | Purpose |
|--------|---------|
| `log-rotation.sh` | Rotate and manage log files |
| `log-compress.sh` | Compress old log files |
| `log-archive.sh` | Archive logs for long-term storage |
| `log-cleanup.sh` | Delete old logs (retention policy) |
| `log-analyze.sh` | Analyze log patterns and statistics |
| `error-log-monitor.sh` | Monitor error logs in real-time |
| `access-log-parse.sh` | Parse and analyze web access logs |
| `log-grep-search.sh` | Search logs with filters |
| `log-statistics.sh` | Generate log statistics reports |
| `log-alert.sh` | Alert on specific log patterns |

## 📋 Quick Start

### 1. Make scripts executable
```bash
chmod +x linux/*.sh
chmod +x security/*.sh
chmod +x monitoring/*.sh
chmod +x backup/*.sh
chmod +x network/*.sh
chmod +x users/*.sh
chmod +x logs/*.sh
```

### 2. View script help
```bash
./linux/system-info.sh
./backup/full-backup.sh
./monitoring/cpu-alert.sh
```

### 3. Run a script
```bash
# System information
./linux/system-info.sh

# Disk usage report
./linux/disk-usage.sh

# Memory monitoring (real-time)
./monitoring/memory-alert.sh 80 5

# Full system backup
./backup/full-backup.sh /backups
```

## 🔧 Common Usage Patterns

### Monitor System Health
```bash
./linux/system-info.sh
./monitoring/cpu-alert.sh 75
./monitoring/memory-alert.sh 80
./monitoring/disk-alert.sh 85
```

### Backup Management
```bash
./backup/full-backup.sh /backups
./backup/backup-schedule.sh
./backup/backup-cleanup.sh /backups 30
./backup/backup-report.sh /backups
```

### Security Hardening
```bash
./security/ssh-hardening.sh
./security/firewall-setup.sh
./security/fail2ban-setup.sh
./security/audit-permissions.sh /home
```

### User Administration
```bash
./users/user-list.sh
./users/user-add.sh john
./users/user-groups.sh john
./users/user-activity-report.sh john
```

### Log Management
```bash
./logs/log-rotation.sh /var/log
./logs/log-analyze.sh /var/log/syslog
./logs/error-log-monitor.sh
./logs/log-cleanup.sh /var/log 90
```

## 📋 Requirements

- Bash 4.0+
- Linux/Unix environment
- Standard GNU tools (grep, awk, sed, find)
- Sudo/root access (for some scripts)
- Optional: curl, wget, netcat for network scripts

### Optional Dependencies
- UFW (firewall)
- Fail2Ban (intrusion detection)
- OpenVPN (VPN management)
- MySQL/PostgreSQL clients
- iperf3 (bandwidth testing)

## ⚙️ Installation

### Option 1: Clone and use directly
```bash
git clone <repository>
cd devops-automation-scripts
chmod +x **/*.sh
```

### Option 2: Add to PATH
```bash
export PATH="$PATH:$(pwd)"
chmod +x **/*.sh
```

### Option 3: Install system-wide
```bash
sudo cp -r . /usr/local/share/devops-scripts
sudo chmod +x /usr/local/share/devops-scripts/**/*.sh
export PATH="$PATH:/usr/local/share/devops-scripts"
```

## 🔐 Security Notes

- Scripts requiring sudo will prompt for authentication
- Always review scripts before running on production systems
- Test scripts in safe environments first
- Backup important data before running destructive operations
- Some scripts create backups before making changes

## 📝 Configuration

Most scripts accept parameters:
- First parameter: Primary target (file, user, service, etc.)
- Additional parameters: Options and values
- Use `--help` or no parameters for usage information

Example:
```bash
./backup/full-backup.sh /backups        # Full backup to /backups
./users/user-add.sh john /bin/bash      # Add user with bash shell
./monitoring/cpu-alert.sh 85 10         # Alert at 85% every 10 seconds
```

## 🐛 Troubleshooting

### Scripts not running
```bash
chmod +x script.sh
```

### Permission denied
```bash
# For system-level operations, use sudo
sudo ./security/firewall-setup.sh
```

### Missing commands
- Install required tools: `apt-get install curl wget netcat-openbsd`
- Some scripts gracefully skip unavailable tools

### Logs not found
- Check log file paths: `ls /var/log/`
- May require sudo for some log files

## 📚 Best Practices

1. **Scheduling**: Use cron for automated execution
2. **Logging**: Redirect output to log files for monitoring
3. **Testing**: Run in test environment first
4. **Documentation**: Document custom modifications
5. **Versioning**: Track changes in version control

Example cron job:
```bash
0 2 * * * /path/to/devops-scripts/backup/full-backup.sh /backups
0 * * * * /path/to/devops-scripts/monitoring/cpu-alert.sh 80
```

## 📄 License

These scripts are provided as-is for educational and operational use.

## 🤝 Contributing

Improvements and additional scripts are welcome. Please test thoroughly before submitting.

---

**Total Scripts: 70**
- Linux: 10 scripts
- Security: 10 scripts
- Monitoring: 10 scripts
- Backup: 10 scripts
- Network: 10 scripts
- Users: 10 scripts
- Logs: 10 scripts

**Last Updated**: $(date)
