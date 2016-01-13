set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" basic setup for all vim
Plugin 'tpope/vim-sensible'

" sublime matching theme
Plugin 'sickill/vim-monokai'

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
" nerdcomment, commentary.vim alternatives
" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plugin 'tomtom/tcomment_vim'

" IDE level vim/go integration
Plugin 'fatih/vim-go'

" consider neocomplete or YCM for autocomplete
" ^ required by vim-go for autocomplete

" statusline
Plugin 'bling/vim-airline'

" Plugin 'nathanaelkane/vim-indent-guides'
" Not liking it - no way to highlight less than a column

Plugin 'jiangmiao/auto-pairs'

Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-surround'

" session management
" :Prosession <dir> to change/create
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

Plugin 'nixprime/cpsm'

Plugin 'Shougo/unite.vim'

Plugin 'unblevable/quick-scope'

" tell vim that your terminal supports 256 colors
let base16colorspace=256  
set t_Co=256 

" theme
" Plugin 'chriskempson/base16-vim'

" explore ctrlspace as alternative for both 
" session management and fuzzy file finding

call vundle#end()            " required
filetype plugin indent on    " required

" disable arrow keys :(
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"

" set ruler at 81 chars 
set colorcolumn=81

" turn on line numbers
set number

" bind easymotion to <Leader> instead of <Leader><Leader>
map <Leader> <Plug>(easymotion-prefix)
" \w for search down, \k for search up

" remap split navigation to vim hjkl 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open new splits to the right or below
" like a non sociopath
set splitbelow
set splitright

" clear highlight with <esc> after a search
nnoremap <esc><esc> :noh<return><esc>

" file patterns for ctrlp loading to ignore
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_extensions = ['mixed']

" if executable('ag')
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"     let g:ctrlp_use_caching = 0
" endif

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" this command doesn't work with submodule contents 
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" allows you to have multiple buffers open
set hidden
" lines of code will not wrap to hte next line
set nowrap
" set autoindent
" set autoindent
" copy the indentation of the previous line if the auto indent doesn't know
" what to do
" set copyindent
" indenting a line with >> or << will move by 4
" set shiftwidth=4
" pressing tab in insert mode will use 4 spaces
" set softtabstop=4
" use spaces instead of tabs
" set expandtab
" highlight matching braces/tags
set showmatch
" ignore case when searching
set ignorecase
" ... unless there's a capital letter in the query
set smartcase
" indent to correct locatin with tab
set smarttab
" highlight search matches
set hlsearch
" search while you enter they query, not after
set incsearch
" let vim set the title of the terminal window
set title
" use a visual indiator instead of a beep
set visualbell
" or just turn off errors bells 
" set noerrorbells
" enable syntax highlighting
syntax enable
colorscheme monokai

set pastetoggle=<F5>

" change leader to space
let mapleader=" "

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 0
" let g:airline_left_sep=''
" let g:airline_right_sep=''
let g:airline_theme='molokai'
let g:airline#extensions#whitespace#enabled = 1

if has('mouse')
    set mouse=a
    if !has('nvim')
	set ttymouse=xterm2
    endif
endif

" edit vimrc in a vsplit
nnoremap <leader>vv :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>VV source $MYVIMRC<cr>

" map jk to esc
inoremap jk <esc>l 
