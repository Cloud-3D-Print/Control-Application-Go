#!/usr/bin/bash
set -e

echo "Getting updates"
sudo apt-get update

SVCNAME=piPrinterCtrl
SVCUSER=$USER  ### could be changed to another user with service permissions
WORKDIR="$HOME/control/piPrinterCtrl"

sudo systemctl disable ${SVCNAME} &>/dev/null || true
sudo systemctl stop ${SVCNAME} &>/dev/null || true
sudo rm /etc/systemd/system/${SVCNAME}.service

cat > ${SVCNAME}.service <<EOF
[Unit]
Description=TPCPI Remote Server
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

sudo systemctl start ${SVCNAME} &>/dev/null || true
sudo systemctl enable ${SVCNAME} &>/dev/null || true

sudo systemctl status ${SVCNAME}
echo -e "You could use the following command to monitor the server:\njournalctl -n 100 -f -u ${SVCNAME}"