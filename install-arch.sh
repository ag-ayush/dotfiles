#!/bin/bash
###############################################################################
# This installs parts of my current setup on Arch. This should be run after
# installing arch, configuring users and all that jazz, and cloning my dotfiles
# repo under $HOME/git/linux.
#
###############################################################################
###############################################################################
#
# Location
#
###############################################################################
LOCATION="$HOME/git/linux"
read -p "Theme (arch-tron-theme, $THEME): "  THEME

###############################################################################
#
# Pacman Installations
#
###############################################################################
mkdir $HOME/.config
mkdir $HOME/Pictures
mkdir $HOME/Pictures/screenshots

sudo pacman -S compton feh scrot i3-gaps rofi rofi-calc firefox 
atom zsh 
zsh-autosuggestions zsh-completions git python-pip lxappearance neofetch openvpn 
cowsay fortune-mod vlc terminator npm nodejs wget yajl pulseaudio 
pulseaudio-alsa pulseaudio-bluetooth arandr blueman bluez-utils 
gparted mplayer mesa nemo nemo-fileroller neofetch neovim 
networkmanager network-manager-applet p7zip ranger sshfs 
xf86-input-libinput xf86-video-intel xorg-server 
xorg-server-common xorg-twm xorg-xclock xorg-xinit xorg-xev xterm 
glances gimp mpv ruby nodejs

sudo pip3 install -r $LOCATION/dotfiles/requirements.txt
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
apm install markdown-preview-plus teletype pdf-view latex language-latex atom-prettify

###############################################################################
#
# Other installations
#
###############################################################################
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
# yaourt
cd $LOCATION
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si
cd $LOCATION
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
# Polybar
yaourt polybar
# i3lock-color
yaourt i3lock-color
# slack
yaourt slack
# cli-visualizer
cd $LOCATION
git clone https://github.com/dpayne/cli-visualizer.git
cd cli-visualizer
./install.sh
make ENABLE_PULSE=1

###############################################################################
#
# copy configs
#
###############################################################################
rm $HOME/.zshrc
cp $LOCATION/dotfiles/.zshrc $HOME/
cp -r $LOCATION/dotfiles/$THEME/i3 $HOME/.config/
cp -r $LOCATION/dotfiles/$THEME/polybar/ $HOME/.config/
cp -r $LOCATION/dotfiles/$THEME/rofi/ $HOME/.config/
cp -r $LOCATION/dotfiles/$THEME/terminator/ $HOME/.config/
cp -r $LOCATION/dotfiles/neofetch/ $HOME/.config/
cp -r $LOCATION/dotfiles/vis/ $HOME/.config/

###############################################################################
#
# Wallpaper
#
###############################################################################
mkdir $HOME/Pictures/Wallpapers
cp night-city-theme/minimalist-cities-romain-trystram.jpg $HOME/Pictures/Wallpapers/
