set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" basic setup for all vim
Plugin 'tpope/vim-sensible'

" git integration. seems to have the most mindshare
Plugin 'tpope/vim-fugitive'

" goto anything like support
" alternative plugins: commandt
" ctrl-p to activate
Plugin 'kien/ctrlp.vim'

" weird/awesome move anywhere package
Plugin 'Lokaltog/vim-easymotion'

" hopefully good git gutter support
Plugin 'airblade/vim-gitgutter'

" is decent fucking commenting so much to ask?
" nerdcomment, commentary.vim
" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plugin 'tomtom/tcomment_vim'

" IDE level vim/go integration
Plugin 'fatih/vim-go'

" consider neocomplete or YCM for autocomplete

" statusline
Plugin 'bling/vim-airline'

" Plugin 'nathanaelkane/vim-indent-guides'
" Not liking it - no way to highlight less than a column

Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required

" disable arrow keys :(
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"

" set ruler at 80 chars 
set colorcolumn=85

" turn on line numbers
set number
