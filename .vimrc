""""""""""
" PLUGINS
""""""""""
set nocompatible   " be iMproved, required
filetype off       " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" basic setup for all vim
Plugin 'tpope/vim-sensible'

" git integration. seems to have the most mindshare
Plugin 'tpope/vim-fugitive'

" sanity to copy/paste
Plugin 'svermeulen/vim-easyclip'

" goto anything like support
" alternative plugins: commandt
" ctrl-p to activate
Plugin 'ctrlpvim/ctrlp.vim'
" explore ctrlspace as alternative for both
" session management and fuzzy file finding

" better matcher for ctrlp
" be sure to run the manual C build step as well
Plugin 'nixprime/cpsm'

" weird/awesome move anywhere package
Plugin 'Lokaltog/vim-easymotion'

" hopefully good git gutter support
Plugin 'airblade/vim-gitgutter'

" is decent fucking commenting so much to ask?
" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plugin 'tomtom/tcomment_vim'

" IDE level vim/go integration
Plugin 'fatih/vim-go'

" consider neocomplete or YCM for autocomplete
" ^ required by vim-go for autocomplete

" statusline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" auto quote/bracket/paren matching
Plugin 'jiangmiao/auto-pairs'

" motions/text objects for surrounding selections with chars
" not super happy this this one,
" explore configuration or alternatives
Plugin 'tpope/vim-surround'

" extend the power of . to more complex objects
Plugin 'tpope/vim-repeat'

" session management
" :Prosession <dir> to change/create
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

" not sure i need this. kind of a competitor of ctrlp
Plugin 'Shougo/unite.vim'

" color highlights same line navigation options
Plugin 'unblevable/quick-scope'

" fish shell syntax etc
Plugin 'dag/vim-fish'

" allow vim<->tmux pane navigation
Plugin 'christoomey/vim-tmux-navigator'

" automatic ctags management
Plugin 'xolox/vim-easytags'

" requirement for easytags
Plugin 'xolox/vim-misc'

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""

" use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"

" bind easymotion to <Leader> instead of <Leader><Leader>
" \w for search down, \k for search up
map <Leader> <Plug>(easymotion-prefix)

" use cpsm instead of built ctrlp for matching
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" file patterns for ctrlp loading to ignore
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$,\.pyc'

let g:ctrlp_extensions = ['mixed']
let g:ctrlp_root_markers = ['.vimproject', 'Dockerfile', 'requirements.txt']

" use vim cwd as search path root
" so far the only reliable solution to the git submodule problem
let g:ctrlp_working_path_mode = 'w'

" if executable('ag')
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"     let g:ctrlp_use_caching = 0
" endif

" let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 0
" let g:airline_left_sep=''
" let g:airline_right_sep=''
let g:airline_theme='molokai'
let g:airline#extensions#whitespace#enabled = 1

" remap paste ring actions to ctrl-f (forward) and ctrl-d
let g:EasyClipUsePasteToggleDefaults = 0
nmap <c-f> <plug>EasyClipSwapPasteForward
nmap <c-d> <plug>EasyClipSwapPasteBackwards

" enable auto reformating on paste
" leader-p to paste w/ disabled
let g:EasyClipAutoFormat = 1

" remap mark to gm as easyclip adds Move operator on m
nnoremap gm m

""""""""""""""""
" IT'S NOT 1970
""""""""""""""""

" tell vim that your terminal supports 256 colors
let base16colorspace=256
set t_Co=256

set ttyfast

" enable the mouse
if has('mouse')
    set mouse=a
    if !has('nvim')
	set ttymouse=xterm2
    endif
endif

"""""""""""""""""""""""""
" BASE VIM CONFIGURATION
"""""""""""""""""""""""""

" remap split navigation to match vim hjkl
" because we're not sociopaths
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" clear highlight with <esc> after a search
nnoremap <esc><esc> :noh<return><esc>

" turn on line numbers
set number

" set ruler at 81 chars
set colorcolumn=81

" disable arrow keys :/
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" open new splits to the right or below
" like a non sociopath
set splitbelow
set splitright

" allows you to have multiple buffers open
set hidden

" lines of code will not wrap to hte next line
set nowrap

" copy the indentation of the previous line
" if the auto indent doesn't know what to do
" set autoindent

" set copyindent
" indenting a line with >> or << will move by 4

" pressing tab in insert mode will use 4 spaces
" set shiftwidth=4
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

" https://github.com/tomasr/molokai
colorscheme molokai

" hit f5 to toggle paste modes
" fixes vim reindenting pasted code
set pastetoggle=<F5>

"""""""
" MAPS
"""""""

" change leader to space
let mapleader=" "

" edit vimrc in a vsplit
nnoremap <leader>vv :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>VV source $MYVIMRC<cr>

" map jk to esc when in insert mode
inoremap jk <esc>l

" change the default register to the system clipboard
set clipboard^=unnamed

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" files to hide from netrw
let g:netrw_list_hide = '.*\.pyc$,'
let g:netrw_list_hide.='\.DS_Store,'
let g:netrw_list_hide.= '\.git,'
let g:netrw_list_hide.= '\__pycache__,'

" sane files to ignore
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/*.pyc

" fish doesn't play posix
" tell vim to use a regular shell
if &shell =~# 'fish$'
    set shell=sh
endif
