#!/bin/bash

set -e

SCRIPT_DIR=`dirname "$0"`

# apt update

# base packages
apt install -y vim tmux zsh git mercurial mercurial-keyring exuberant-ctags ack-grep curl phing composer php-mbstring python-pip

# vim config
if [ ! -d ~/.config/nvim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi

if [ ! ~/.vimrc ]; then
	ln -s $SCRIPT_DIR/.vimrc ~/
fi

# neovim
if [ ! -f /usr/bin/nvim ]; then
	sudo add-apt-repository ppa:neovim-ppa/stable
	apt update
	apt install -y neovim
fi

# neovim config
if [ ! -d ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi

cp -u $SCRIPT_DIR/.config/nvim/init.vim ~/.config/nvim/

# docker

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update
apt install -y docker-ce

# lxc

if [ ! -f /usr/bin/lxd ]; then
	apt install -y lxc1 lxd
	lxd init
fi

# GUI packages

apt install -y keepassxc network-manager-openvpn network-manager-openvpn-gnome chromium-browser

# Xubuntu packages

apt install -y xubuntu-restricted-extras redshift redshift-gtk
