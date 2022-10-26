#!/usr/bin/bash
set -e

SVCUSER=$USER  ### could be changed to another user with service permissions

if [ -d "/home/${SVCUSER}/control" ];
then
  echo "Control Application already exists"
  read -p "Do you want to reinstall? (y|n)" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # sudo rm -rf /home/${SVCUSER}/control
      echo "Reinstalling Control Application"
    else
      exit 0
  fi
fi

cd ~
mkdir -p ~/Downloads
cd Downloads
curl -L -O https://github.com/mech-soluitons-ltd/Control-Application-Go/releases/download/v1.0.1/control_app_rpi.tar.gz
mkdir -p ~/Downloads/control
tar xzf control_app_rpi.tar.gz -C ./control

cp -r -f ~/Downloads/control ~


# echo "Installing Git"
# sudo apt-get install git -y

# git clone https://github.com/mech-soluitons-ltd/Control-Application-Go.git /home/${SVCUSER}/control



echo "Changing folder permissions"
chown -R ${SVCUSER} /home/${SVCUSER}/control

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
