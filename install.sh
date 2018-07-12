#!/bin/bash
###############################################################################
#
# Location
#
###############################################################################
LOCATION="$HOME/git/linux"
read -p "Theme (arch-tron-theme, night-city-theme): "  THEME

###############################################################################
#
# a function to simply print what package is being installed and then install it
# why? because it makes it easier to see what is being installed.
#
###############################################################################
install_packages(){
	for var in $@
	do
		echo -e "\033[0;32mInstalling package: $var\033[0m \n"
		sudo apt -y install $var
		echo -e "\n"
	done
}

###############################################################################
#
# grab my dotfiles
#
###############################################################################
echo -e "Downloading dotfiles\n"
sudo apt install git
mkdir $HOME/git/
mkdir $HOME/git/linux
cd $LOCATION
git clone https://github.com/axg4975/dotfiles.git

###############################################################################
#
# Debian Packages
#
###############################################################################
# Grab all debian packages for common programs
echo -e "Downloading .deb files\n"
wget https://github.com/atom/atom/releases/download/v1.27.2/atom-amd64.deb
echo -e "Done\n"
# Install all deb packages
echo -e "Installing .deb packages\n"
sudo dpkg -i *.deb
echo -e "Done\n"
# Remove all deb packages
echo -e "Deleting .deb files\n"
rm *.deb
echo -e "Done\n"

###############################################################################
#
# Other Common Installations
#
###############################################################################
# Add all needed repositories
echo -e "Adding External apt repos\n"
sudo apt-add-repository -y ppa:numix/ppa
sudo apt-add-repository -y ppa:papirus/papirus
sudo add-apt-repository -y ppa:snwh/pulp
sudo add-apt-repository -y ppa:george-edison55/cmake-3.x
sudo add-apt-repository -y ppa:webupd8team/java
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

# Ubuntu 16.04 or less
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"

# Install Packages
echo -e "Installing apt pip3 apm packages\n"
install_packages neovim git python3 python3-pip python-pip php arc-theme npm nodejs nodejs-legacy zsh papirus-icon-theme paper-icon-theme paper-cursor-theme paper-gtk-theme xcb-util-xrm fonts-font-awesome pycharm vlc terminator scrot make texlive pandoc sshfs help2man blueman libfftw3-dev libncursesw5-dev libpulse-dev glances texlive-full lxappearance zathura linux-tools-common linux-tools-generic neofetch openvpn cowsay fortunes okular

sudo pip3 install -r $LOCATION/dotfiles/requirements.txt

apm install markdown-preview-plus teletype pdf-view latex language-latex atom-prettify
echo -e "Done\n"

###############################################################################
#
# Others
#
###############################################################################
# Screenshots dir
mkdir $HOME/Pictures/screenshots
# Pipes.sh
cd $LOCATION
git clone https://github.com/pipeseroni/pipes.sh.git
cd $LOCATION/pipes.sh
sudo make install
# Brightness
cd $LOCATION
git clone https://github.com/haikarainen/light.git
cd $LOCATION/light
sudo make
sudo make install
# thefuck
#sudo echo 'eval $(thefuck --alias)' >> ~/.bashrc


###############################################################################
#
# Polybar and i3
#
###############################################################################
echo -e "Installing polybar & i3-gaps dependencies\n"
###############################################################################
# Dependencies
###############################################################################
## polybar
install_packages cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libxcb-cursor-dev libjsoncpp libsigc++ libpulse-dev
## i3
install_packages libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake rofi compton blueman-applet nm-applet mdp i3status dmenu libxcb-xrm-dev i3lock feh pulseaudio-module-bluetooth
## i3lock-color
install_packages libxcb1 libxcb-util1 libpam-dev libcairo-dev libfontconfig-dev libxcb-composite0 libxcb-composite0-dev libxcb-xinerama0 libxcb-randr0 libev4 libx11-xcb-dev libjpeg-dev
echo -e "Done\n"

###############################################################################
# Polybar
###############################################################################
echo -e "Installing polybar \n"
cd $LOCATION
# clone the repository
git clone --recursive https://github.com/jaagr/polybar
# compile & install
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install

yes | cp -rf $LOCATION/dotfiles/$THEME/polybar $HOME/.config/
echo -e "Done\n"

###############################################################################
# i3-gaps
###############################################################################
echo -e "Installing i3-gaps \n"
cd $LOCATION
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

yes | cp -rf $LOCATION/dotfiles/$THEME/i3 $HOME/.config/
echo -e "Done\n"

###############################################################################
# i3lock-color
###############################################################################
echo -e "Installing i3lock-color \n"
cd $LOCATION
# clone the repository
git clone https://github.com/PandorasFox/i3lock-color.git
cd i3lock-color
# compile & install
autoreconf -i && ./configure && make

###############################################################################
# cli-visualizer
###############################################################################
echo -e "Installing i3lock-color \n"
cd $LOCATION
# clone the repository
git clone https://github.com/dpayne/cli-visualizer.git
cd cli-visualizer
# compile & install
./install.sh
make ENABLE_PULSE=1

###############################################################################
#
# Wallpaper
#
###############################################################################
mkdir $HOME/Pictures/Wallpapers
wget -O $HOME/Pictures/Wallpapers/tardis-abstract.jpg https://www.walldevil.com/wallpapers/a71/wallpaper-images-abstract-tardis-cartoons.jpg
wget -O $HOME/Pictures/Wallpapers/tron.png https://i.pinimg.com/originals/2b/0f/18/2b0f18e400002dc4b5123f2ef773212a.png
cp $HOME/git/linux/dotfiles/night-city-theme/minimalist-cities-romain-trystram.jpg $HOME/Pictures/Wallpapers
gsettings set org.gnome.desktop.background picture-uri file:///$HOME/Pictures/Wallpapers/minimalist-cities-romain-trystram.jpg
echo -e "Added and changed wallpaper\n"

###############################################################################
#
# IntelliJ
#
###############################################################################
echo -e "installing intelliJ\n"
cd $HOME
mkdir apps
cd $HOME/Downloads
wget https://download.jetbrains.com/idea/ideaIC-2018.1.2.tar.gz
sudo tar xf ideaIC-2018.1.2.tar.gz -C $HOME/apps/
cd $HOME/apps/idea-IC-181.4668.68/bin
./idea.sh
echo -e "done installing intelliJ\n"


###############################################################################
#
# Other Files
#
###############################################################################
yes | cp -rf $LOCATION/dotfiles/neofetch $HOME/.config/
yes | cp -rf $LOCATION/dotfiles/$THEME/rofi $HOME/.config/
yes | cp -rf $LOCATION/dotfiles/vis $HOME/.config/
yes | cp -rf $LOCATION/dotfiles/$THEME/terminator $HOME/.config/
yes | cp -rf $LOCATION/dotfiles/.Xdefaults $HOME
xrdb -load ~/.Xdefaults

###############################################################################
#
# Oh-My-Zsh
#
###############################################################################
# Installing Oh-My-Zsh
echo -e "Installing Oh My ZSH\n"
yes | cp -rf $LOCATION/dotfiles/.zshrc $HOME/
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo -e "Done\n"
# Installing Zsh plugins
echo -e "Installing ZSH plugins\n"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/devinmatte/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo -e "Done\n"
# Switch to zsh as shell
echo -e "Changing Shell to ZSH\n"
echo -e "Done\n"

###############################################################################
#
# Finished
#
###############################################################################
echo -e "\n\nDONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE\n\n"
sudo chsh -s $(which zsh)
exit
