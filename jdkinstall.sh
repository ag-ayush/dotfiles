#!/bin/sh

sudo apt update
sudo apt install default-jdk
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java9-installer
sudo update-alternatives --config java

