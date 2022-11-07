#!/usr/bin/bash
set -e

touch /tmp/rsyslog
cat <<EOF > /tmp/rsyslog
/var/log/syslog
/var/log/mail.info
/var/log/mail.warn
/var/log/mail.err
/var/log/mail.log
/var/log/daemon.log
/var/log/kern.log
/var/log/auth.log
/var/log/user.log
/var/log/lpr.log
/var/log/cron.log
/var/log/debug
/var/log/messages
{
        size 200000
        rotate 3
        daily
        missingok
        notifempty
        compress
        nodelaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}

EOF

sudo mv -f /tmp/rsyslog /etc/logrotate.d/rsyslog
sudo chown -R root:root /etc/logrotate.d/rsyslog
sudo rm /tmp/rsyslog

sudo systemctl restart logrotate.service &>/dev/null || true
sudo systemctl restart logrotate.timer &>/dev/null || true