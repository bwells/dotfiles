" change leader to space
" required before plugin loads to ensure they configure correctly
let mapleader=" "

""""""""""
" PLUGINS
""""""""""
call plug#begin()

" basic setup for all vim
Plug 'tpope/vim-sensible'

" git integration. seems to have the most mindshare
Plug 'tpope/vim-fugitive'

" sanity to copy/paste
Plug 'svermeulen/vim-easyclip'

" goto anything like support
" alternative plugins: commandt
" ctrl-p to activate
" Plug 'ctrlpvim/ctrlp.vim'
" explore ctrlspace as alternative for both
" session management and fuzzy file finding

" better matcher for ctrlp
" be sure to run the manual C build step as well
" Plug 'nixprime/cpsm'

" weird/awesome move anywhere package
Plug 'Lokaltog/vim-easymotion'

" hopefully good git gutter support
Plug 'airblade/vim-gitgutter'

" is decent fucking commenting so much to ask?
" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plug 'tomtom/tcomment_vim'

" IDE level vim/go integration
Plug 'fatih/vim-go'

" consider neocomplete or YCM for autocomplete
" ^ required by vim-go for autocomplete

Plug 'itchyny/lightline.vim'

" auto quote/bracket/paren matching
Plug 'jiangmiao/auto-pairs'

" motions/text objects for surrounding selections with chars
" not super happy this this one,
" explore configuration or alternatives
Plug 'tpope/vim-surround'

" extend the power of . to more complex objects
Plug 'tpope/vim-repeat'

" not sure i need this. kind of a competitor of ctrlp
Plug 'Shougo/unite.vim'

" vimproc - required for Unite /async modes
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" color highlights same line navigation options
Plug 'unblevable/quick-scope'

" fish shell syntax etc
Plug 'dag/vim-fish'

" allow vim<->tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'

" automatic ctags management
Plug 'xolox/vim-easytags'

" requirement for easytags
Plug 'xolox/vim-misc'

" sneek - simpler alternative to easymotion
" or a better f
Plug 'justinmk/vim-sneak'

" better bdelete
Plug 'moll/vim-bbye'

" gave in and using nerdtree rather than netrw
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" add motions for word hunks in camel or underscore case
Plug 'chaoren/vim-wordmotion'

Plug 'bwells/vim-named-sessions'

Plug 'bwells/simplysublime'

" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""

" don't save hidden buffers
set sessionoptions-=buffers
set sessionoptions-=options

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeRespectWildIgnore = 1

" use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"

" bind easymotion to <Leader> instead of <Leader><Leader>
" \w for search down, \k for search up
" map <Leader> <Plug>(easymotion-prefix)

" " use cpsm instead of built ctrlp for matching
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
"
" " file patterns for ctrlp loading to ignore
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$,\.pyc'
"
" let g:ctrlp_extensions = ['mixed']
" let g:ctrlp_root_markers = ['.vimproject', 'Dockerfile', 'requirements.txt']
"
" " use vim cwd as search path root
" " so far the only reliable solution to the git submodule problem
" let g:ctrlp_working_path_mode = 'w'

" if executable('ag')
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"     let g:ctrlp_use_caching = 0
" endif

" let g:airline_powerline_fonts=1
  " let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#hunks#enabled = 0
" let g:airline_left_sep=''
" let g:airline_right_sep=''
  " let g:airline_theme='molokai'
  " let g:airline#extensions#whitespace#enabled = 1

" remap paste ring actions to ctrl-f (forward) and ctrl-d
let g:EasyClipUsePasteToggleDefaults = 0
nmap <c-f> <plug>EasyClipSwapPasteForward
nmap <c-d> <plug>EasyClipSwapPasteBackwards

" enable auto reformating on paste
" leader-p to paste w/ disabled
let g:EasyClipAutoFormat = 1

" remap mark to gm as easyclip adds Move operator on m
nnoremap gm m

call unite#custom#profile('files', 'filters', 'sorter_rank')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <Leader>f :Unite -start-insert file_rec/async<CR>
nnoremap <Leader>g :Unite -start-insert buffer<CR>

" alias Bdelete to Bclose
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" map 'bc' to 'Bc' for ease of typing
cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bc'):('bc'))

" uses menlo for powerline from
" https://gist.github.com/justinmayer/7537418#file-menlo-for-powerline-zip
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\       	  [ 'fugitive' ],
	\		  [ 'readonly', 'filename', 'modified' ] ],
	\	 'right': [ [ 'lineinfo' ],
	\                   [ 'percent' ],
	\                   [ 'filetype', 'fileformat', 'fileencoding' ] ]
	\ },
	\ 'inactive': {
	\ 	'left': [ [ 'filename' ] ],
	\ 	'right': [ [ 'lineinfo' ],
	\ 	           [ 'percent' ] ]
	\ },
	\ 'component_function': {
	\	'fugitive': 'LightLineFugitive'
	\ },
	\ 'component': {
	\  'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
	\  'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
	\ },
	\ 'component_visible_condition': {
	\   'readonly': '(&filetype!="help"&& &readonly)',
	\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
	\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

" wordmotion config
let g:wordmotion_prefix = "<leader>"

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

set guifont=Menlo\ Regular\ for\ Powerline:h11

" remap split navigation to match vim hjkl
" because we're not sociopaths
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" C-N and P to buffer navigation
" nnoremap <C-N> :bnext<CR>
" nnoremap <C-P> :bprev<CR>
" let's try tab and shift-tab instead
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>

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

" i keep hitting shift-j or k instead of ctrl-j or k
" override the defaults (join and lookup keyword) to something less annoying
nnoremap J 5j
nnoremap K 5k

" if i hit c-j/k in insert mode dump out and do what i wanted
inoremap <C-j> <esc><c-w><c-j>
inoremap <C-k> <esc><c-w><c-k>

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
colors molokai
" autocmd ColorScheme janah highlight Normal ctermbg=235
" colors janah

" hit f5 to toggle paste modes
" fixes vim reindenting pasted code
set pastetoggle=<F5>

"""""""
" MAPS
"""""""

" edit vimrc in place
nnoremap <leader>v :edit $MYVIMRC<cr>

" edit vimrc in a vsplit
nnoremap <leader>vv :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>r :source $MYVIMRC<cr>

" auto source vimrc on write
" autocmd! bufwritepost .vimrc source %
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

" tab settings for filetypes
augroup vim_filetype
    autocmd!
    autocmd FileType vim set tabstop=4 shiftwidth=4
    autocmd FileType javascript set tabstop=4 shiftwidth=4 expandtab
augroup END



" map jk to esc when in insert mode
inoremap jk <esc>l

" clear a line without removing it
nnoremap <leader>d 0D

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
    set shell=zsh
endif

" let's do some whitspace highlighting
" set listchars=tab:▶ ,space:.,trail:.

" set backupdir=~/.vim/backup//
" set directory=~/.vim/swap//
" set undodir=~/.vim/undo//
set noswapfile
