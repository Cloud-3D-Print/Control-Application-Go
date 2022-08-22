#!/usr/bin/bash
set -e

SVCUSER=$USER  ### could be changed to another user with service permissions

git clone https://github.com/mech-soluitons-ltd/Control-Application-Go.git /home/${SVCUSER}/control

echo "Changing folder permissions"
chown -R pi /home/pi/control

chmod +x /home/${SVCUSER}/control/piPrinterCtrl/install_piPrinterCtrl_systemd.sh
chmod +x /home/${SVCUSER}/control/piPrinterCtrl/piPrinterCtrl
/home/${SVCUSER}/control/piPrinterCtrl/install_piPrinterCtrl_systemd.sh

chmod +x /home/${SVCUSER}/control/tpcpilocal/install_tpcpilocal_systemd.sh
chmod +x /home/${SVCUSER}/control/tpcpilocal/tpcpilocal
/home/${SVCUSER}/control/tpcpilocal/install_tpcpilocal_systemd.sh
