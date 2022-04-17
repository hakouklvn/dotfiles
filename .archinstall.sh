#!/usr/bin/env bash

sudo pacman -S base-devel xorg picom nitrogen zsh qtile alacritty lsd bat neovim vivid nautilus mypy python-pip python-iwlib rofi vlc transmission-gtk zsh-syntax-highlighting zsh-autosuggestions alsa-utils light zip unzip ripgrep fd emacs most

## install yay
git clone https://aur.archlinux.org/yay-git.git yay && cd yay || exit
makepkg -si
cd ..
rm -rf yay

# install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# install fonts & thmes
yay -S nerd-fonts-mononoki ttf-meslo-nerd-font-powerlevel11k nvim-packer-git colloid-gtk-theme-git colloid-icon-theme-git
sudo pacman -S ttf-fira-code ttf-font-awesome

# install login manager
yay -S ly 
sudo systemctl enable ly

#install some apps
yay -S brave-bin spotify flameshot nomacs htop neofetch lxappearance qt5ct nm-connection-editor 

# configure zsh
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

sudo touch /etc/X11/xorg.conf.d/00-keyboard.conf
sudo touch /etc/X11/xorg.conf.d/40-libinput.conf

# change keyboard layout to azerty
echo '
Section "InputClass"
       Identifier "system-keyboard"
       MatchIsKeyboard "on"
       Option "XkbLayout" "fr"
       Option "XkbModel" "pc105"
       Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection' > sudo /etc/X11/xorg.conf.d/00-keyboard.conf

## enable touchpad 
echo '
Section "InputClass"
   Identifier "libinput touchpad catchall"
   Driver "libinput"
   Option "Tapping" "on"
EndSection' > sudo /etc/X11/xorg.conf.d/40-libinput.conf
