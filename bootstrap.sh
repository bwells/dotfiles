#!/bin/sh

# setup SSH
ssh-keygen -t ed25519 -C "kremlan@dioxin.com"
# add to github

# remap capslock to ctrl in keyboard settings
# update keyboard repeat rate

# install command line tools and/or xcode

# install brew. installs via .pkg these days, download from homebrew website

# brew install basic packages
brew install awscli ccrypt curl elm fd fish fzf git go kops kubernetes-cli kubectx mysql neovim nmap node ripgrep sops sqlite stern tmux vim python stern pkg-config uv s5cmd ghostty

brew install --cask font-meslo-lg-nerd-font kitty

# change default shell to fish
# add /opt/homebrew/bin/fish to /etc/shells
sudo chsh -s /opt/homebrew/bin/fish kremlan

# brew install font-menlo-for-powerline
# set font in Terminal Settings

# symlink in dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.pylintrc ~/.pylintrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/ghostty.config ~/Library/Application\ Support/com.mitchellh.ghostty/config
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
# setup 1password - install from app store
# install tailscale from tailscale

# install docker desktop
