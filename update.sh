#!/usr/bin/bash
set -e

echo "Installing Git"
sudo apt-get install git -y


git config core.sparsecheckout true

SVCUSER=$USER  ### could be changed to another user with service permissions



if [ -d "/home/${SVCUSER}/control" ];
then
    cd /home/${SVCUSER}/control
    BRANCH=main

    LOCAL=$(git log $BRANCH -n 1 --pretty=format:"%H")
    REMOTE=$(git log remotes/origin/$BRANCH -n 1 --pretty=format:"%H")

    if [ $LOCAL = $REMOTE ]; then
        echo "Up-to-date"
    else
        echo "Need update"
        read -p "Do you want to upgrade? (y|n)" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
            then
                echo "Upgrading"
                git pull origin main
                sudo systemctl restart piPrinterCtrl.service
                sudo systemctl restart piPrinterCtrl.tpcpilocal
            else
                exit 0
        fi
    fi
fi
