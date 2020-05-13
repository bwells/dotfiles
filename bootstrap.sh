#!/bin/sh

# setup SSH
ssh-keygen -t rsa -b 4096 -C "kremlan@dioxin.com"
# add to github

# TODO: remap capslock to ctrl

# install command line tools and/or xcode

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install basic packages
brew install ccrypt curl fish fzf git go mercurial kops kubernetes-cli mysql@5.7 neovim nmap node ripgrep sqlite tmux vim zsh python@3.8

# change default shell to fish
sudo chsh -s /usr/local/bin/fish kremlan

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

# setup cask
brew tap homebrew/cask-fonts
brew cask install font-menlo-for-powerline
# set font in Terminal Settings

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
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/fish ~/.config/fish

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

# install docker
