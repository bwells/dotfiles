#!/bin/sh

# setup SSH
ssh-keygen -t ed25519 -C "kremlan@dioxin.com"
# add to github

# remap capslock to ctrl in keyboard settings
# update keyboard repeat rate

# install command line tools and/or xcode

# install brew. installs via .pkg these days, download from homebrew website

# brew install basic packages
brew install ccrypt curl fish fzf git go kops kubernetes-cli mysql neovim nmap ripgrep fd sqlite tmux vim python stern pkg-config uv

# change default shell to fish
sudo chsh -s /opt/homebrew/bin/fish kremlan

# setup cask
# brew tap homebrew/cask-fonts
# brew install font-menlo-for-powerline
# set font in Terminal Settings
# Instal Meslo from nerdfonts.com
# maybe
# brew install homebrew/cask-fonts/font-meslo-lg-nerd-font

# symlink in dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.pylintrc ~/.pylintrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/kitty ~/.config/kitty
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/dotfiles/nvim/ftplugin ~/.config/nvim/ftplugin
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua

# setup repo checkouts root
mkdir ~/workspace

# setup GOPATH dir
mkdir -p ~/workspace/go/src/github.com/bwells
ln -s ~/workspace/go/src/github.com ~/workspace/bwells

# App setups
# login to dropbox
# setup 1password - install from app store
# setup work vpn

# install docker

# install virtualfish
mkdir ~/environments
python3 -m pip install virtualfish
vf install
