# Control-Application-Go

## The printer controller application in Raspberry Pi (Golang version), includes
1. tpcpilocal - send video information from raspi to remote server
2. pi printer controller - receive commands from Project Management Centre to control 3D printers, and sync staatuses and attributes of devices

## Required environment:
1. Raspberry Pi or similar micro computer device
2. (suggested) ARM5 or ARM6 or ARM7 or ARM64

## How to install: 
1. copy install.sh into /home/{$USER}/ of raspi
2. make the install script to be executable 
```
chmod +x install.sh
```
3. make sure you have stable network connection
4. run by 
```
./install.sh
```

### P.S.
1. the default pattern of pi printer controller is marlin, not klipper
2. klipper service need to be deployed individually