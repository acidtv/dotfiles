#!/bin/bash

set -e

#if [ -z "$SUDO_USER" ]; then
	#echo "Please run this script with sudo" >&2
	#exit 1
#fi

SCRIPT_DIR=$(cd `dirname "$0"`; pwd)
echo "Linking configs to $SCRIPT_DIR"

# apt update

# base packages
sudo apt install -y vim tmux zsh git mercurial curl whois traceroute

# dev packages
sudo apt install -y mercurial-keyring exuberant-ctags ack-grep phing composer php-mbstring python-pip ruby-dev ruby-bundler silversearcher-ag

# vim config
if [ ! -d ~/.config/nvim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi

# neovim
if [ ! -f /usr/bin/nvim ]; then
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt update
	sudo apt install -y neovim
fi

# neovim config
if [ ! -d ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi

cp -u $SCRIPT_DIR/.config/nvim/init.vim ~/.config/nvim/

# symlinks

SYMLINKS=".vimrc
.gitconfig
.zshrc
.tmux.conf
"
for link in $SYMLINKS; do
	if [ ! -e "$HOME/$link" ]; then
		echo "Linking $link ..."
		ln -s $SCRIPT_DIR/$link $HOME/
	fi
done

# mercurial config

if [ ! -e "$HOME/.hgrc" ]; then
	echo "Copying .hgrc ..."
	cp $SCRIPT_DIR/.hgrc.skel ~/.hgrc
fi

# set default shell

chsh -s /usr/bin/zsh $USER

# docker

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# 
# add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
# 
# apt update
# apt install -y docker-ce

# lxc

#if [ ! -f /usr/bin/lxd ]; then
#	apt install -y lxc1 lxd
#	lxd init
#fi

# GUI packages

sudo apt install -y keepassxc network-manager-openvpn network-manager-openvpn-gnome chromium-browser vlc mysql-workbench syncthing

# Enable syncthing user service
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
echo "Don't forget to share the syncthing folder with this device. Use 'syncthing -browser-only' to open the syncthing interface."

# Xubuntu packages

# apt install -y xubuntu-restricted-extras redshift redshift-gtk duplicity deja-dup

# Switch caps with escape

# sed -i "s/XKBOPTIONS=\"\"/XKBOPTIONS=\"caps:swapescape\"/" /etc/default/keyboard
