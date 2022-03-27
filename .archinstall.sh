#!/bin/bash

sudo pacman -S base-devel xorg picom nitrogen zsh qtile alacritty\
lsd bat neovim vivid nautilus mypy python-pip python-iwlib rofi vlc\
transmission-gtk zsh-syntax-highlighting zsh-autosuggestions alsa-utils\
flameshot nomacs htop neofetch lxappearance qt5ct


## install yay
git clone https://aur.archlinux.org/yay-git.git yay
cd yay
makepkg -si
rm -rf yay

yay -S ly nerd-fonts-mononoki ttf-meslo-nerd-font-powerlevel11k\
nvim-packer-git colloid-gtk-theme-git colloid-icon-theme-git
sudo systemctl enable ly

yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh $USER

# change keyboard layout to azerty
sudo echo "
Section "InputClass"
       Identifier "system-keyboard"
       MatchIsKeyboard "on"
       Option "XkbLayout" "fr"
       Option "XkbModel" "pc105"
       Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection" > /etc/X11/xorg.conf.d/00-keyboard.conf 

## enable touchpad 
# sudo echo "
# Section "InputClass"
#    Identifier "libinput touchpad catchall"
#    Driver "libinput"
#    Option "Tapping" "on"
# EndSection" > /etc/X11/xorg.conf.d/40-libinput.conf
