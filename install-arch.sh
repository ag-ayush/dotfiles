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

sudo pacman -S compton feh scrot i3-gaps rofi chromium atom zsh zsh-autosuggestions zsh-completions git python-pip lxappearance neofetch openvpn cowsay fortune-mod vlc terminator npm nodejs wget yajl pulseaudio pulseaudio-alsa pulseaudio-bluetooth arandr blueman bluez-utils gparted mplayer mesa nemo nemo-fileroller neovim networkmanager network-manager-applet p7zip ranger sshfs xf86-input-libinput xf86-video-intel xorg-server xorg-server-common xorg-twm xorg-xclock xorg-xinit xorg-xev xterm glances gimp mpv ruby nodejs vim dunst steam openssh cheese light dlang sqlite

# following install ttf-*
pacman -S `pacman -Ss ttf | cut -d/ -f2 | grep ^ttf | cut -d' ' -f1`

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
# yaourt
cd $LOCATION
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Onedrive
cd $LOCATION
git clone https://github.com/skilion/onedrive.git
cd onedrive
make
sudo make install
# Polybar
yay polybar
# i3lock-color
yay i3lock-color
# slack
yay slack
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
cp -r $LOCATION/dotfiles/dunst $HOME/.config/
cp -r $LOCATION/dotfiles/i3 $HOME/.config/
cp -r $LOCATION/dotfiles/polybar/ $HOME/.config/
cp -r $LOCATION/dotfiles/ranger $HOME/.config/
cp -r $LOCATION/dotfiles/rofi/ $HOME/.config/
cp -r $LOCATION/dotfiles/terminator/ $HOME/.config/
cp -r $LOCATION/dotfiles/neofetch/ $HOME/.config/
cp -r $LOCATION/dotfiles/vis/ $HOME/.config/

###############################################################################
#
# Wallpaper
#
###############################################################################
mkdir $HOME/Pictures/Wallpapers
cd $LOCATION
cp -r wallpaper/ $HOME/Pictures/Wallpapers/
