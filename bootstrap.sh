#!/bin/sh

# symlink in dotfiles
ln -s .gitconfig ~/.gitconfig
ln -s .gitignore ~/.gitignore
ln -s .tmux.conf ~/.tmux.conf
ln -s .vimrc ~/.vimrc
mkdir ~/.config
ln -s fish ~/.config/fish

# install command line tools and/or xcode

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install basic packages
brew install fish zsh tmux vim macvim git go mysql nmap node python

# setup cask
brew tap caskroom/cask

# install apps
brew cask install google-chrome firefox iterm2 slack flowdock adium dropbox \
	          1password mysqlworkbench

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim -c PlugInstall

# setup repo checkouts root
mkdir ~/workspace

# setup GOPATH dir
mkdir -p ~/workspace/go/src/github.com/bwells
ln -s ~/workspace/go/src/github.com ~/workspace/bewlls

# setup SSH
# * copy work puppet keys
# * copy own id_rsa and id_rsa.pub
# * copy config w/ ec2 instance aliases

# App setups
# login to dropbox
# setup 1password
# setup work vpn
# download menucalanderclock
# setup adium accounts?
