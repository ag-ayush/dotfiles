#!/bin/bash

### This is a function to simply print what package is being installed and then install it ###
install_packages(){
	for var in $@
	do
		echo -e "Installing package: $var\n"
		sudo apt -q install $var
		echo -e "\n"
	done
}


### Grab my dotfiles ###
#echo -e "Downloading dotfiles\n"
#git clone https://github.com/ag-ayush/dotfiles.git $HOME/git/linux/dotfiles


### Debian Packages ###
# Grab all debian packages for common programs
echo -e "Downloading .deb files\n"
wget https://atom-installer.github.com/v1.23.1/atom-amd64.deb
echo -e "Done\n"
# Install all deb packages
echo -e "Installing .deb packages\n"
sudo dpkg -i *.deb
echo -e "Done\n"
# Remove all deb packages
echo -e "Deleting .deb files\n"
rm *.deb
echo -e "Done\n"


### Other common installations ###
# Add all needed repositories
echo -e "Adding External apt repos\n"
sudo apt-add-repository ppa:numix/ppa
sudo apt-add-repository ppa:papirus/papirus
sudo add-apt-repository ppa:snwh/pulp

# Updates and Upgrades
echo -e "Updating system\n"
sudo apt update -q=3
sudo apt upgrade -q=3
sudo apt dist-upgrade -q=3
sudo apt autoremove -q=3
sudo apt clean -q=3
sudo apt autoclean -q=3
sudo apt install -f -q=3
sudo apt install --fix-broken -q=3
echo -e "Done\n"

# Install Packages
echo -e "Installing apt packages\n"

# Ubuntu 16.04 or less
sudo sh -c "echo -e 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"
sudo add-apt-repository ppa:aguignard/ppa
sudo apt-get update
sudo apt-get install arc-theme xcb-util-xrm

install_packages neovim git python3 python3-pip php openjdk-8-* arc-theme npm nodejs nodejs-legacy zsh papirus-icon-theme paper-icon-theme paper-cursor-theme paper-gtk-theme
echo -e "Done\n"


### polybar and i3 ###
echo -e "Installing polybar & i3-gaps \n"
## Dependencies

# polybar
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libxcb-cursor-dev libjsoncpp libsigc++

# i3
# Ubuntu 16.04 or less
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf
sudo apt install libxcb-xrm-dev
# Ubuntu 16.10+
#sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake 

## Install polybar
cd $HOME/git/linux
# clone the repository
git clone --recursive https://github.com/jaagr/polybar
# compile & install
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install

## Install i3-gaps
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
echo -e "Installing Crontab"
touch mycron
echo -e "0 0,12 * * * $HOME/git/linux/dotfiles/.daily.sh" >> mycron
sudo crontab mycron 
rm mycron
echo -e "Done\n"


### Oh-My-Zsh ###
# Installing Oh-My-Zsh
echo -e "Installing Oh My ZSH\n"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo -e "Done\n"
# Installing Zsh plugins
echo -e "Installing ZSH plugins\n"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/devinmatte/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo -e "Done\n"
# Switch to zsh as shell
echo -e "Changing Shell to ZSH\n"
chsh -s $(which zsh)
echo -e "Done\n"


### Bye bye ###
echo -e "goodbye"
