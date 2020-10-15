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
sudo apt install -y neovim vim tmux zsh git mercurial curl whois traceroute net-tools magic-wormhole xfce4-terminal fzf

# dev packages
sudo apt install -y mercurial-keyring exuberant-ctags ack-grep phing composer php-mbstring python3-pip ruby-dev ruby-bundler silversearcher-ag nodejs yarnpkg docker.io docker-compose

# yarn symlink

sudo ln -s /bin/yarnpkg /usr/local/bin/yarn

# neovim config
if [ ! -d ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi
cp -u $SCRIPT_DIR/.config/nvim/init.vim ~/.config/nvim/
ln -s $SCRIPT_DIR/.config/nvim/coc-settings.json ~/.config/nvim/

# vim config
if [ ! -d ~/.config/nvim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi

# symlinks

SYMLINKS=".vimrc
.zshrc
.tmux.conf
.fzf.zsh
.ideavimrc
"
for link in $SYMLINKS; do
	if [ ! -e "$HOME/$link" ]; then
		echo "Linking $link ..."
		ln -s $SCRIPT_DIR/$link $HOME/
	fi
done

# git config
if [ ! -e "$HOME/.gitconfig" ]; then
	cp .gitconfig ~/
fi

# tmux config
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# mercurial config

if [ ! -e "$HOME/.hgrc" ]; then
	echo "Copying .hgrc ..."
	cp $SCRIPT_DIR/.hgrc.skel ~/.hgrc
fi

# set default shell

chsh -s /usr/bin/zsh $USER

# GUI packages

sudo apt install -y keepassxc network-manager-openvpn network-manager-openvpn-gnome chromium-browser vlc syncthing

# Enable syncthing user service
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

# Remove Ubuntu ctrl-alt-(left|right) shortcuts so we can use them in phpstorm
# See: https://stackoverflow.com/questions/47808160/intellij-idea-ctrlaltleft-shortcut-doesnt-work-in-ubuntu
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"

# Xubuntu packages
# apt install -y xubuntu-restricted-extras redshift redshift-gtk duplicity deja-dup

if [ ! -e "$HOME/bin/PathPicker-master/fpp" ]; then
	curl -L "https://github.com/facebook/PathPicker/archive/master.zip" > ~/Downloads/fpp-master.zip
	unzip -d ~/bin ~/Downloads/fpp-master.zip
	ln -s /home/alex/bin/PathPicker-master/fpp /usr/local/bin/fpp
	rm ~/Downloads/fpp-master.zip
fi

# Switch caps with escape
echo "Switching caps and escape keys"
sudo sed -i "s/XKBOPTIONS=\"\"/XKBOPTIONS=\"caps:swapescape\"/" /etc/default/keyboard

echo "### NOTES ###"
echo " * Don't forget to share the syncthing folder with this device. Use 'syncthing -browser-only' to open the syncthing interface."
echo " * Install vim plugins with :PluginInstall"
echo " * Install COC deps with :call coc#util#install()"
echo " * Install fzf deps with :call fzf#install()"
echo " * Set default terminal in gnome with: sudo update-alternatives --config x-terminal-emulator"
echo " * Install tmux plugins with c-a shift-i"
