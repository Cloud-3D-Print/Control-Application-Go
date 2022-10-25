#!/usr/bin/bash
set -e

SVCNAME=tpcpilocal
SVCUSER=$USER   ### could be changed to another user with service permissions
WORKDIR="$HOME/control/tpcpilocal"

sudo systemctl stop ${SVCNAME} &>/dev/null || true
sudo systemctl disable ${SVCNAME} &>/dev/null || true
# sudo rm /etc/systemd/system/${SVCNAME}.service &>/dev/null || true

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

touch /home/${SVCUSER}/control/tpcpilocal/tpcpi_localconfig.yml
cat <<EOF > /home/${SVCUSER}/control/tpcpilocal/tpcpi_localconfig.yml
### resolution support 360P, 480P, 720P, 1080P, 2K. default is 720P
resolution: 720P
gpuJPEGQualityRank: 8    ### 1~10
localVidHttpPort: 9988
gRPCPortForPrinterControler: 19988
videoTimeLimit: 600
iNotifyConfFile: /home/${SVCUSER}/control/AI_Config.json

EOF

sudo systemctl stop webcamd.service &>/dev/null || true # disable klipper webcam function 
sudo systemctl disable webcamd.service &>/dev/null || true # disable klipper webcam function

# sudo cp ./${SVCNAME}.service /etc/systemd/system/
sudo cp -r -f ./${SVCNAME}.service /etc/systemd/system/

sudo systemctl daemon-reload ${SVCNAME} &>/dev/null || true
sudo systemctl start ${SVCNAME} &>/dev/null || true
sudo systemctl enable ${SVCNAME} &>/dev/null || true

sudo systemctl status ${SVCNAME}
echo -e "You could use the following command to monitor the server:\njournalctl -n 100 -f -u ${SVCNAME}"