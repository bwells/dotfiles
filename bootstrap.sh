#!/bin/sh

# setup SSH
ssh-keygen -t ed25519 -C "kremlan@dioxin.com"
# add to github

# TODO: remap capslock to ctrl
# update keyboard repeat rate

# install command line tools and/or xcode

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew install basic packages
brew install ccrypt curl fish fzf git go mercurial kops kubernetes-cli mysql neovim nmap node ripgrep sqlite tmux vim python stern

# change default shell to fish
sudo chsh -s /usr/local/bin/fish kremlan

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

# setup cask
# brew tap homebrew/cask-fonts
# brew install font-menlo-for-powerline
# set font in Terminal Settings
# Instal Meslo from nerdfonts.com
# maybe
# brew install homebrew/cask-fonts/font-meslo-lg-nerd-font

# TODO: switch this to Packer for neovim
# install vim-plug and plugins for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugInstall

# install vim-plug for nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall

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
