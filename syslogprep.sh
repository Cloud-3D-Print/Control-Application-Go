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
        #rotate 4
        rotate 3
        #weekly
        daily
        missingok
        notifempty
        compress
        #delaycompress
        nodelaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}

EOF

sudo mv -f /tmp/rsyslog /etc/logrotate.d/rsyslog