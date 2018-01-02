#!/bin/bash

### Update Everything 
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt clean -y
sudo apt autoclean -y

### Clean old logs
sudo rm /var/log/*.log.*
sudo rm /var/log/syslog.*
sudo rm /var/log/wtmp.*
sudo rm /var/log/btmp.*
sudo rm /var/log/*/*.log.*
sudo rm /var/log/*/*.*.gz
