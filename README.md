# Control-Application-Go

## The printer controller application in Raspberry Pi (Golang version), includes
1. tpcpilocal - send video information from raspi to remote server
2. pi printer controller - receive commands from Project Management Centre to control 3D printers, and sync staatuses and attributes of devices

## Required environment:
1. Raspberry Pi or similar micro computer device
2. (suggested) ARM5 or ARM6 or ARM7 or ARM64

## How to install: 
1. copy install_marlin.sh or install_klipper.sh into /home/{$USER}/ of raspi
    * depends on your 3D printer firmware
2. make the install script (install_marlin.sh or install_klipper.sh) to be executable 
```
chmod +x {install_script}
```
3. make sure you have stable network connection
4. run by 
```
./{install_script}
```

### P.S.
1. klipper service need to be deployed individually