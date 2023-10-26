## Recommended actions when first setting up server/KVM-VM.
### Set static-IP

### Create `/etc/ssh/sshd_config` and `/etc/ssh/banner` from `server-tweaks - etc/ssh/sshd_config` from `server-tweaks - etc/ssh/banner`

### Copy `sysctl.conf` and `iptables.sh` and other `iptables scripts` to `/usr/local/bin/bean6754/` and create and enable systemd `firewall` service.

### Run `# bash /root/iptables.sh`

### Create `/etc/fail2ban/jail.local`.

### Change in `/etc/mail/sendmail.mc` then run `# make -C /etc/mail`.
```
MASQUERADE_AS(`<your-hostname>')dnl
define(`SMART_HOST',`[<ext-smtp-server>]')dnl
```
