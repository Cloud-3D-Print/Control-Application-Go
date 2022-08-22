#!/usr/bin/bash
set -e

SVCNAME=tpcpilocal
SVCUSER=$USER   ### could be changed to another user with service permissions
WORKDIR="$HOME/control/tpcpilocal"

sudo systemctl stop ${SVCNAME} >> /dev/null 2>&1
sudo systemctl disable ${SVCNAME} >> /dev/null 2>&1
sudo rm /etc/systemd/system/${SVCNAME}.service

cat > ./${SVCNAME}.service <<EOF
[Unit]
Description=TPCPI Local Daemon
After=network-online.target syslog.target

[Service]
Type=simple
WorkingDirectory=${WORKDIR}
User=${SVCUSER}
ExecStart=${WORKDIR}/${SVCNAME}
Restart=on-failure
LimitNOFILE=65536
RestartSec=5s
TimeoutSec=0
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=${SVCNAME}

[Install]
WantedBy=multi-user.target
EOF

sudo cp ./${SVCNAME}.service /etc/systemd/system/

sudo systemctl start ${SVCNAME} >> /dev/null 2>&1
sudo systemctl enable ${SVCNAME} >> /dev/null 2>&1

sudo systemctl status ${SVCNAME}
echo -e "You could use the following command to monitor the server:\njournalctl -n 100 -f -u ${SVCNAME}"
