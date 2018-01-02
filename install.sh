#!/bin/bash

### This is a function to simply print what package is being installed and then install it ###
install_packages(){
	for var in $@
	do
		echo "Installing package: $var\n"
		sudo apt -q install $var
		echo "\n"
	done
}


### Grab my dotfiles ###
echo "Downloading dotfiles"
git clone https://github.com/ag-ayush/dotfiles.git $HOME/git/linux/dotfiles


### Debian Packages ###
# Grab all debian packages for common programs
echo "Downloading .deb files\n"
wget https://atom-installer.github.com/v1.23.1/atom-amd64.deb
echo "Done\n"
# Install all deb packages
echo "Installing .deb packages\n"
sudo dpkg -i *.deb
echo "Done\n"
# Remove all deb packages
echo "Deleting .deb files\n"
rm *.deb
echo "Done\n"


### Other common installations ###
# Add all needed repositories
echo "Adding External apt repos\n"
sudo apt-add-repository ppa:numix/ppa
sudo apt-add-repository ppa:papirus/papirus

# Updates and Upgrades
echo "Updating system\n"
sudo apt update -q=3
sudo apt upgrade -q=3
sudo apt dist-upgrade -q=3
sudo apt autoremove -q=3
sudo apt clean -q=3
sudo apt autoclean -q=3
sudo apt install -f -q=3
sudo apt install --fix-broken -q=3
echo "Done\n"

# Install Packages
echo "Installing apt packages\n"
install_packages vim git python3 python3-pip php spotify-client openjdk-8-* arc-theme npm nodejs nodejs-legacy zsh papirus-icon-theme paper-icon-theme paper-cursor-theme 
echo "Done\n"


### Oh-My-Zsh ###
# Installing Oh-My-Zsh
echo "Installing Oh My ZSH\n"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "Done\n"
# Installing Zsh plugins
echo "Installing ZSH plugins\n"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/devinmatte/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "Done\n"
# Switch to zsh as shell
echo "Changing Shell to ZSH\n"
chsh -s $(which zsh)
echo "Done\n"

### i3-gaps ###
## Dependencies
# Ubuntu 14.04 - 16.04
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf
sudo add-apt-repository ppa:aguignard/ppa
sudo apt-get update
sudo apt-get install libxcb-xrm-dev  xcb-util-xrm
# Ubuntu 16.10+
#sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake 

## Install
cd $HOME/git/linux
# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

### Setups Update Crontab ###
echo "Installing Crontab"
touch mycron
echo "0 0,12 * * * $HOME/git/linux/dotfiles/.daily.sh" >> mycron
sudo crontab mycron 
rm mycron
echo "Done\n"

### Bye bye ###
echo "goodbye"
