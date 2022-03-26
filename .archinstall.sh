!#/usr/bin/bash

sudo pacman -S xorg ly picom nitrogen base-devel zsh qtile alacritty lsd bat neovim

git clone https://aur.archlinux.org/yay-git.git yay
cd yay
makepkg -si

yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh hakou
