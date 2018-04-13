#!/bin/sh

# setup SSH
#ssh-keygen -t rsa -b 4096 -C "kremlan@dioxin.com"
# add to github

# TODO: remap capslock to ctrl

# symlink in dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.pylintrc ~/.pylintrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/fish ~/.config/fish

# install command line tools and/or xcode

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install basic packages
brew install fish zsh tmux vim macvim git go mysql nmap node \
	     sqlite python python3 fzf ripgrep the_silver_searcher

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

# TODO: change default shell to fish

# setup cask
brew tap caskroom/cask

# install apps
brew cask install adium

# optional installs
# brew cask install vagrant vmware-fusion

# need vagrant

# install vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim-plug for nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim -c PlugInstall

# install nvim plugins
nvim -c PlugInstall

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install tmux plugins - prefix + I

# setup repo checkouts root
mkdir ~/workspace

# setup GOPATH dir
mkdir -p ~/workspace/go/src/github.com/bwells
ln -s ~/workspace/go/src/github.com ~/workspace/bwells

# App setups
# login to dropbox
# setup 1password - install from app store
# setup work vpn
# setup adium accounts?

# install menlo for powerline font
# setup Terminal.app and iTerm2 to use that font
