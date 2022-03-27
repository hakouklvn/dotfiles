#!/bin/bash

sudo pacman -S base-devel xorg picom nitrogen zsh qtile alacritty lsd bat neovim vivid nautilus
sudo pacman -S mypy python-pip python-iwlib rofi
sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions alsa-utils

git clone https://aur.archlinux.org/yay-git.git yay
cd yay
makepkg -si
rm -rf yay

yay -S ly nerd-fonts-mononoki ttf-meslo-nerd-font-powerlevel10k brave
sudo systemctl enable ly

yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh hakou

# change keyboard layout to azerty
echo "
# Written by systemd-localed(8), read by systemd-localed and Xorg. It's
# probably wise not to edit this file manually. Use localectl(1) to
# instruct systemd-localed to update it.
Section "InputClass"
       Identifier "system-keyboard"
       MatchIsKeyboard "on"
       Option "XkbLayout" "fr"
       Option "XkbModel" "pc105"
       Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection" > /etc/X11/xorg.conf.d/00-keyboard.conf 

## enable touchpad 
echo "
Section "InputClass"
   Identifier "libinput touchpad catchall"
   Driver "libinput"
   Option "Tapping" "on"
EndSection" > /etc/X11/xorg.conf.d/40-libinput.conf
