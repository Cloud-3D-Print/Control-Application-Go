#!/usr/bin/bash
set -e

SVCUSER=$USER  ### could be changed to another user with service permissions

if [ -d "/home/${SVCUSER}/control" ];
then
  echo "Control Application already exists"
  read -p "Do you want to reinstall? (y|n)" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      sudo rm -rf /home/${SVCUSER}/control
    else
      exit 0
  fi
fi

echo "Installing Git"
sudo apt-get install git -y

git clone https://github.com/mech-soluitons-ltd/Control-Application-Go.git /home/${SVCUSER}/control

echo "Changing folder permissions"
chown -R pi /home/pi/control

echo "Installing pi printer controller service"
chmod +x /home/${SVCUSER}/control/piPrinterCtrl/install_piPrinterCtrl_systemd.sh
chmod +x /home/${SVCUSER}/control/piPrinterCtrl/piPrinterCtrl
cd /home/${SVCUSER}/control/piPrinterCtrl/
./install_piPrinterCtrl_systemd.sh &>/dev/null || true


echo "Installing tpcpi local video & AI sync service"
chmod +x /home/${SVCUSER}/control/tpcpilocal/install_tpcpilocal_systemd.sh
chmod +x /home/${SVCUSER}/control/tpcpilocal/tpcpilocal
cd /home/${SVCUSER}/control/tpcpilocal/
./install_tpcpilocal_systemd.sh &>/dev/null || true
