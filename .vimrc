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

" sneek - simpler alternative to easymotion
" or a better f
Plug 'justinmk/vim-sneak'

" sanity to copy/paste
Plug 'svermeulen/vim-easyclip'

" goto anything like support
" alternative plugins: commandt
" ctrl-p to activate
" Plug 'ctrlpvim/ctrlp.vim'

" better matcher for ctrlp
" be sure to run the manual C build step as well
" Plug 'nixprime/cpsm'
"
" explore ctrlspace as alternative for both
" fuzzy file finding
" Plug 'vim-ctrlspace/vim-ctrlspace'

" weird/awesome move anywhere package
" Plug 'Lokaltog/vim-easymotion'

" git gutter. []c to navigate change hunks
" <leader>hs to stage hunk
Plug 'airblade/vim-gitgutter'

" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plug 'tomtom/tcomment_vim'

" lightweight and independent statusline plugin
Plug 'itchyny/lightline.vim'

" auto quote/bracket/paren matching
Plug 'jiangmiao/auto-pairs'

" motions/text objects for surrounding selections with chars
" not super happy this this one,
" explore configuration or alternatives
Plug 'tpope/vim-surround'

" extend the power of . to more complex objects
Plug 'tpope/vim-repeat'

" plugin management QOL from tpope
" zS to show active syntax highlight group
Plug 'tpope/vim-scriptease'

" provides mixed case abbreviations and searches
Plug 'tpope/vim-abolish'

" deep python understanding
" Plug 'davidhalter/jedi-vim'

" do everything interface library
Plug 'Shougo/unite.vim'

" vimproc - required for Unite /async modes
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" color highlights same line navigation options
" Plug 'unblevable/quick-scope'

" TODO: conflicting with ctrl j/k working with fzf results
"       disabled until figured out
" allow vim<->tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'

" automatic ctags management
Plug 'xolox/vim-easytags'

" requirement for easytags
Plug 'xolox/vim-misc'

" better bdelete
Plug 'moll/vim-bbye'

" gave in and using nerdtree rather than netrw
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" add motions for word hunks in camel or underscore case
Plug 'chaoren/vim-wordmotion'

" lots of targets
" separators, args, etc
Plug 'wellle/targets.vim'

" adds indent level as an object
Plug 'michaeljsmith/vim-indent-object'

Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'

" IDE level vim/go integration
Plug 'fatih/vim-go', { 'for': 'go' }

" fish shell syntax etc
Plug 'dag/vim-fish', { 'for': 'fish' }

" dockerfile support
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }

" mako support
Plug 'sophacles/vim-bundle-mako'

" color scheme
Plug 'tomasr/molokai'

" Plug 'scrooloose/syntastic'

Plug 'w0rp/ale'

" adds gS and gJ to syntactically aware split/join constructs
Plug 'AndrewRadev/splitjoin.vim'

" :s live feedback
Plug 'osyo-manga/vim-over'

" fzf fuzzy finder wrapper
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" finally something to give vertical spacing alignment bars?
" Disabling for now. Kills scroll performance once the viewport is moving
" Plug 'Yggdroot/indentLine'

Plug 'hynek/vim-python-pep8-indent'

Plug 'bwells/vim-named-sessions'

Plug 'bwells/simplysublime'

Plug 'takac/vim-hardtime'

" defines a sort motion
Plug 'christoomey/vim-sort-motion'

" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""

let g:rehash256=1

let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = []
let g:hardtime_timeout = 1000
let g:hardtime_maxcount = 8
let g:hardtime_ignore_buffer_patterns = ["NERD.*", ".*Location List.*"]
let g:hardtime_ignore_quickfix = 1

" TODO: idea: add command for jumping up or down when you meant the opposite
" -> 10j, shit i meant to 10k. rather than have to hit 20k, hit K and it
" calculates that your last jump was 10 down, so go up 20.

" don't save hidden buffers
" set sessionoptions-=buffers
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

" remap mark to gm as easyclip adds Move operator on m
nnoremap gm m

" remap paste ring actions to ctrl-f (forward) and ctrl-d
" let g:EasyClipUsePasteToggleDefaults = 0
" nmap <c-f> <plug>EasyClipSwapPasteForward
" nmap <c-d> <plug>EasyClipSwapPasteBackwards
" Defaulting back to ctrl-p and ctrl-n

" enable auto reformating on paste
" leader-p to paste w/ disabled
let g:EasyClipAutoFormat = 1

" call unite#custom#profile('files', 'filters', 'sorter_rank')
" call unite#custom#source('file_rec', 'sorters', 'sorter_length')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#source('file,file_rec,file_rec/async',
				       \ 'ignore_pattern',
				       \ join(['data/', '.git'], '\|'))

" if executable('ag')
"   let g:unite_source_rec_async_command =
"     \ ['ag', '--nocolor', '--nogroup',
"     \  '--depth', '10', '-g', '']
"   " ag is quite fast, so we increase this number
"   let g:unite_source_rec_min_cache_files = 1200
" endif

if has('nvim')
	nnoremap <Leader>f :Unite -start-insert file_rec/neovim<CR>
else
	nnoremap <Leader>f :Unite -start-insert file_rec/async<CR>
endif
nnoremap <Leader>b :Unite -start-insert buffer<CR>
nnoremap <Leader>/ :Unite grep:. -buffer-name=search-buffer<CR>

if executable('ag')
	  let g:unite_source_grep_command = 'ag'
	  let g:unite_source_grep_default_opts =
	  \ '-i --vimgrep --hidden --ignore ' .
	  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	  let g:unite_source_grep_recursive_opt = ''
endif

if executable('pt')
	let g:unite_source_grep_command = 'pt'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_grep_encoding = 'utf-8'
endif

call unite#custom#profile('default', 'context', {
      \   'start_insert': 1,
      \   'winheight': 15,
      \   'direction': 'botright',
      \ })


" trying fzf for file and buffer search
" nnoremap <leader>f :Files<CR>
" nnoremap <leader>g :Buffers<CR>
" nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

let g:EasyMotion_do_mapping = 0 " Disable default mappings
map  <leader>e <Plug>(easymotion-bd-f)
nmap <leader>e <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" alias Bdelete to Bclose
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" map 'bc' to 'Bc' for ease of typing
cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bc'):('bc'))

" disable vim's own mode indicator
set noshowmode

" uses menlo for powerline from
" https://gist.github.com/justinmayer/7537418#file-menlo-for-powerline-zip
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

" easytags config
let g:easytags_async = 1

" disable using tags files for syntax highlighting
" it was slaughtering render performance
let g:easytags_auto_highlight = 0

let g:easytags_cmd = '/usr/local/bin/ctags'

" force vim to use a tags file at the root of CWD only
set tags=./tags;
let &cpoptions .= 'd'

" force creating a project specific tags file
let g:easytags_dynamic_files = 2

" turn off easytags messages
" let g:easytags_suppress_report = 1

let g:easytags_languages = {
	\ 'python': {
    \	'args': ['--python-kinds=-iv', '-R']
	\ }
\}

" command to run tags on the entire project
command! InitTags :silent execute "!ctags -R --fields=+l --languages=python --python-kinds=-iv -f tags .\n" | redraw!

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetypes": [] }

" :SyntasticCheck to check
" :SyntasticToggleMode to toggle active/passive

let g:ale_linters = {
\   'python': ['pylint'],
\}

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" let g:ale_sign_error = '\uE0D6'
" let g:ale_sign_warning = '\uE0C8'

" disabled until performance is evaluated
" let g:indentLine_char = '⎸'

" add easymotion like arbitrary key for global movement to sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1
let g:sneak#absolute_dir = 1

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

if has('nvim')
	" ctrl-h == backspace in basic shell.
	" override this in nvim's case to get correct split navigation back
	" nmap <BS> <C-W>h
	nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

	" map esc to switch-to-normal-mode in a terminal
	tnoremap <Esc> <C-\><C-n>
endif

set guifont=Menlo\ Regular\ for\ Powerline:h11

" turn on line numbers
set number

" turn on relative line numbers
set relativenumber

" set ruler at 81 chars
set colorcolumn=81

" highlight the line the cursor is on
set cursorline

" only enable cursorline in the active buffer
" TODO: add relativenumber to this, but make it smart enough to not set
" relativenumber on help windows
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" enable lazyredraw to not slaughter performance
set lazyredraw

" open new splits to the right or below
" like a non sociopath
set splitbelow
set splitright

" allows you to have multiple buffers open
set hidden

" lines of code will not wrap to the next line
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

" change the default register to the system clipboard
set clipboard^=unnamed

" enable syntax highlighting
syntax enable

colors molokai
" update the matched search background to not obscure the cursor
highlight Search guibg=#af005f ctermbg=125

" autocmd ColorScheme janah highlight Normal ctermbg=235
" colors janah

" disable fucking folding
augroup fuck_folding
	autocmd!
	autocmd BufEnter * set nofoldenable
	" au BufLeave * set nofoldenable
augroup END

"""""""
" MAPS
"""""""

" vim-tmux-navigator adds ctrl-hjkl and / for pane navigation

" buffer navigation
" I'm basically never using these. Find a better use for tab.
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprev<cr>

" jump to mru buffer
nnoremap <leader><tab> :b#<cr>

" clear highlight with <esc> after a search
nnoremap <esc><esc> :noh<return><esc>

" disable arrow keys in normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" if i hit c-j/k in insert mode dump out and do what i wanted
inoremap <C-j> <esc><c-w><c-j>
inoremap <C-k> <esc><c-w><c-k>

" edit vimrc in place
nnoremap <leader>v :edit $MYVIMRC<cr>

" edit vimrc in a vsplit
nnoremap <leader>vv :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>r :source $MYVIMRC<cr>

" map jk to esc when in insert mode
inoremap jk <esc>l

" Keep search movements at the center of screen
" nnoremap n nzz
" nnoremap N Nzz
nnoremap n n:call <SID>CenterView()<cr>
nnoremap N N:call <SID>CenterView()<cr>
nnoremap * *:call <SID>CenterView()<cr>
nnoremap # #:call <SID>CenterView()<cr>
nnoremap g* g*:call <SID>CenterView()<cr>
nnoremap g# g#:call <SID>CenterView()<cr>

" does not seem to be working...
nnoremap ]m ]m:call <SID>CenterView()<cr>
nnoremap [m [m:call <SID>CenterView()<cr>
nnoremap ]] ]]:call <SID>CenterView()<cr>
nnoremap [[ [[:call <SID>CenterView()<cr>

" scroll current line to middle if it is within two of the window edge
function! s:CenterView()
	if winline() <= 2  || winline() >= winheight(0) - 1
		normal! zz
	endif
endfunction

" easyclip provides Y - yank to end of line to match D and C

" toggle key for cursorline and relativenumber
" both of which slow down screen renders horribly on occasion
map <f5> :setlocal cursorline! relativenumber!<cr>

" get help on word under cursor
nnoremap K :help <cword><cr>

" disable command history window
" really tired of triggering it instead of :q
noremap q: <NOP>

" switch ' and ` for marks.
" ' defaults to begining of line on the marked line
" ` defaults to the exact marked spot
nnoremap ' `
nnoremap ` '

"""""""""""""
" OTHER STUFF
"""""""""""""

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" auto source vimrc on write
augroup reload_vimrc
	autocmd!
	autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

" customizations for filetypes
augroup filetypes
	autocmd!
	autocmd FileType vim set tabstop=4 shiftwidth=4
	autocmd FileType html,javascript set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType mako set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType dosini set commentstring=#%s
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" change the comment character for .ini files
call tcomment#DefineType('dosini', '#%s')

" files to hide from netrw
let g:netrw_list_hide = '.*\.pyc$,'
let g:netrw_list_hide.='\.DS_Store,'
let g:netrw_list_hide.= '\.git,'
let g:netrw_list_hide.= '\__pycache__,'

" sane files to ignore
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/*.pyc,*/__pycache__

" fish doesn't play posix
" tell vim to use a regular shell
if &shell =~# 'fish$'
    " disable all zsh files while we're at it
    set shell=zsh
endif

" let's do some whitspace highlighting
" set listchars=tab:▶ ,space:.,trail:.

set nobackup
set nowritebackup
set noswapfile

if !has('nvim')
" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif

function! SwapTest()
	" TODO: figure out why this doesn't work for test->impl
	" for training/contact_roles
	" Searches for test or implementation files and swaps
	" the current buffer to the alternate.

	let l:filename = tolower(expand('%:t'))
	let l:cwd = getcwd()

	" if currently in a test file
	" we'll look for the implementation file
	if filename =~ "^test_"
		" chop that off before searching
		let l:filename = join(split(l:filename, '_')[1:], '_')
		let l:pattern = '**/' . l:filename
	else
		" otherwise look for the test file
		let l:pattern = '**/test_' . l:filename
	endif

	" recursively search CWD for files matching the pattern
	" 0 is leaves wildingore and suffixes enabled
	" 1 specifies to return results as a list
	let l:matches = globpath(l:cwd, l:pattern, 0, 1)

	if len(l:matches) == 1
		execute 'edit ' . l:matches[0]
	endif
endfunction

command! SwapTest call SwapTest()

nnoremap <silent> <leader>t :SwapTest<cr>
