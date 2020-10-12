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

" disabled for now for performance reasons
" Plug 'jreybert/vimagit'

" github support for fugative
Plug 'tpope/vim-rhubarb'

" git branch viewer
" Plug 'rbong/vim-flog'

" sneek - simpler alternative to easymotion
" or a better f
Plug 'justinmk/vim-sneak'

" sanity to copy/paste
Plug 'svermeulen/vim-easyclip'

" git gutter. []c to navigate change hunks
" <leader>hs to stage hunk
Plug 'airblade/vim-gitgutter'

" gcc to toggle comment current line
" gc to toggle comment selected line(s)
Plug 'tomtom/tcomment_vim'

" lightweight and independent statusline plugin
Plug 'itchyny/lightline.vim'

" auto quote/bracket/paren matching
" Plug 'jiangmiao/auto-pairs'
" Plug 'Townk/vim-autoclose'
Plug 'Raimondi/delimitMate'

" modernize %
Plug 'andymass/vim-matchup'

" motions/text objects for surrounding selections with chars
Plug 'tpope/vim-surround'

" extend the power of . to more complex objects
Plug 'tpope/vim-repeat'

" plugin management QOL from tpope
" zS to show active syntax highlight group
Plug 'tpope/vim-scriptease'

" provides mixed case abbreviations and searches
Plug 'tpope/vim-abolish'

" wrapper around ag for project wide search
Plug 'mileszs/ack.vim'

" Plug 'tpope/vim-unimpaired'

" allow vim<->tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'

Plug 'ludovicchabant/vim-gutentags'

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

" Plug 'kana/vim-textobj-user'
" Plug 'bps/vim-textobj-python'

" adds text objects for class (ac/ic), function (af/if), and docstring (ad/id)
" also adds g: normal mode map to specify context of cursor location
Plug 'jeetsukumaran/vim-pythonsense'

" IDE level vim/go integration
Plug 'fatih/vim-go', { 'for': 'go' }

" Comprehensive Rust plugin
Plug 'rust-lang/rust.vim'

" fish shell syntax etc
Plug 'dag/vim-fish', { 'for': 'fish' }

" dockerfile support
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }

" mako support
Plug 'sophacles/vim-bundle-mako'

" elm support
Plug 'ElmCast/elm-vim'

" color scheme
Plug 'tomasr/molokai'

Plug 'TroyFletcher/vim-colors-synthwave'

" Plug 'jaredgorski/SpaceCamp'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" required before ale is loaded
" let g:ale_completion_enabled = 1

" Async lint runner and LSP client
Plug 'w0rp/ale'

" adds gS and gJ to syntactically aware split/join constructs
Plug 'AndrewRadev/splitjoin.vim'

" :s live feedback
Plug 'osyo-manga/vim-over'

" fzf fuzzy finder and wrapper
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" finally something to give vertical spacing alignment bars?
" Disabling for now. Kills scroll performance once the viewport is moving
" Plug 'Yggdroot/indentLine'

Plug 'hynek/vim-python-pep8-indent'

" Plug 'bwells/vim-named-sessions'

" Plug 'bwells/simplysublime'

" punish yourself for repeating hjkl too much
" Plug 'takac/vim-hardtime'

Plug 'FooSoft/vim-argwrap'

" defines a sort motion
Plug 'christoomey/vim-sort-motion'

Plug 'neoclide/vim-jsx-improve'

Plug 'machakann/vim-highlightedyank'

" improves terminal support - adds insert mode cursor
Plug 'wincent/terminus'

" integrated test running
Plug 'janko-m/vim-test'

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'ryanolsonx/vim-lsp-python'

Plug 'stevearc/vim-arduino'

" quickfix list helpers
Plug 'romainl/vim-qf'

" base64 encoding
Plug 'christianrondeau/vim-base64'

" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""

""" netrw
let g:netrw_liststyle = 3
let g:netrw_altv = 1

""" molokai
" instruct the molokai colorscheme to use the new fancy version
let g:rehash256=1

""" vim-hardtime
" let g:hardtime_default_on = 1
" let g:list_of_normal_keys = ["h", "j", "k", "l"]
" let g:list_of_visual_keys = ["h", "j", "k", "l"]
" let g:list_of_insert_keys = []
" let g:list_of_disabled_keys = []
" let g:hardtime_timeout = 1000
" let g:hardtime_maxcount = 8
" let g:hardtime_ignore_buffer_patterns = ["NERD.*", ".*Location List.*"]
" let g:hardtime_ignore_quickfix = 1

" TODO: idea: add command for jumping up or down when you meant the opposite
" -> 10j, shit i meant to 10k. rather than have to hit 20k, hit K and it
" calculates that your last jump was 10 down, so go up 20.

""" vim-named-sessions
" don't save hidden buffers
" set sessionoptions-=buffers
set sessionoptions-=options

""" nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeRespectWildIgnore = 1

""" vim-go
" use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"

""" vim-easyclip
" remap mark to gm as easyclip adds Move operator on m
nnoremap gm m

" enable auto reformating on paste
" leader-p to paste w/ disabled
let g:EasyClipAutoFormat = 1

""" vim-bbye
" alias Bdelete to Bclose
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" map 'bc' to 'Bc' for ease of typing
cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bc'):('bc'))

""" lightline.vim
" disable vim's own mode indicator
set noshowmode

" uses menlo for powerline from
" https://gist.github.com/justinmayer/7537418#file-menlo-for-powerline-zip
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive' ],
    \         [ 'readonly', 'filename', 'modified' ] ],
    \    'right': [ [ 'lineinfo' ],
    \                   [ 'percent' ],
    \                   [ 'filetype', 'fileformat', 'fileencoding' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'component': {
    \  'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
    \  'modified': '%{&filetype=="help"?"":&modified?"[+]":&modifiable?"":"-"}',
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

function! LightLineFilename()
    return expand('%')
endfunction

set statusline=
set statusline+=%#warningmsg#
set statusline+=%*

""" vim-gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

""" tcomment_vim
" change the comment character for .ini files
call tcomment#type#Define('dosini', '#%s')

""" vim-wordmotion
let g:wordmotion_prefix = "<leader>"

" override the default 'b' mapping to avoid conflicting
" with <leader>b to open FZF buffer search
let g:wordmotion_mappings = { 'b': '<M-b>' }

""" ale
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\}

" let g:ale_fixers = {
" \   'python': ['black', 'isort']
" \}

" let g:ale_fix_on_save = 1

let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_python_pylint_use_global = 0

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

""" vim-sneak
" add easymotion like arbitrary key for global movement to sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1
let g:sneak#absolute_dir = 1

""" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

""" ack.vim
if executable('rg')
    let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" <left> leaves the cursor position in between the quotes
nnoremap <Leader>/ :Ack!<space>-F<space>""<left>
" xnoremap <leader>/ y:Ack -F "<c-r>""
xnoremap <leader>/ :<c-u>Ack -F "<c-r>=<SID>GetVisualSelection()<cr>"

function! s:GetVisualSelection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

""" vim-sort-motion
let g:sort_motion_flags = "ui"

""" fzf.vim
" set the default FZF default feed command here because it's
" not set in zsh, which is the shell vim actually uses.
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files'
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
endif

" switch to a different panel if running fzf from within nerdtree
nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>t :Tags<cr>

" jump to existing buffers rather than open a new one
let g:fzf_buffers_jump = 1
let g:fzf_layout = {
    \ 'down': '~25%',
\}

" Using floating windows of Neovim to start fzf
if has('nvim')
  function! FloatingFZF(width, height, border_highlight)
    function! s:create_float(hl, opts)
      let buf = nvim_create_buf(v:false, v:true)
      let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
      let win = nvim_open_win(buf, v:true, opts)
      call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
      call setwinvar(win, '&colorcolumn', '')
      return buf
    endfunction

    " Size and position
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 1.5)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF(0.93, 0.5, "Comment")' }
endif

""" vim-highlightedyank
" number of miliseconds to highlight the yank
let g:highlightedyank_highlight_duration = 200

" update the highlight to a color that does not obscure the cursor
" highlight HighlightedyankRegion guibg=#af005f cterm=125

""" vim-qf
let g:qf_shorten_path = 0

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

if exists('&guifont')
    set guifont=Menlo\ Regular\ for\ Powerline:h11
endif

" turn on line numbers
set number

" turn on relative line numbers
set relativenumber

" set ruler at 81 chars
set colorcolumn=81,101

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

" change the default register to the system clipboard
set clipboard^=unnamed

" enable syntax highlighting
syntax enable

" colors molokai
" update the matched search background to a color that does not obscure the cursor
" highlight Search guibg=#af005f ctermbg=125

colors synthwave
" hi ColorColumn guifg=NONE guibg=#db93c8 guisp=#db93c8 ctermfg=235 ctermbg=248 cterm=NONE
" hi ColorColumn guifg=NONE guibg=#6cddf1 guisp=#db93c8 ctermfg=235 ctermbg=248 cterm=NONE
" hi ColorColumn guifg=NONE guibg=#bd0065 guisp=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi ColorColumn guifg=NONE guibg=#536991 guisp=NONE ctermfg=NONE ctermbg=60 cterm=NONE
hi Function guifg=#ff00bb guibg=NONE guisp=NONE gui=NONE ctermfg=199 ctermbg=NONE cterm=bold
hi String guifg=#dd00ff guibg=#181615 guisp=#000000 gui=NONE ctermfg=165 ctermbg=NONE cterm=NONE
hi Comment guifg=#9c38bd guibg=#181615 guisp=NONE gui=italic ctermfg=5 ctermbg=0 cterm=NONE
hi Exception guifg=#bd0065 guibg=#181615 guisp=#000000 gui=bold ctermfg=5 ctermbg=NONE cterm=bold
hi Normal guifg=#f9fcfc guibg=#181615 guisp=#181615 gui=NONE ctermfg=15 ctermbg=234 cterm=NONE
hi SignColumn guifg=#f9fcfc guibg=#181615 guisp=#181615 gui=NONE ctermfg=15 ctermbg=234 cterm=NONE

" disable fucking folding
augroup fuck_folding
    autocmd!
    autocmd BufEnter * set nofoldenable
augroup END

" use rg for grep
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" set completeopt=menuone,noinsert,noselect

"""""""
" MAPS
"""""""

" Skip any internal matching pairs and jump to the match of the line end match
" works well, but the delay in single % use is too annoying
nnoremap <leader>% $%

" vim-tmux-navigator adds ctrl-hjkl and / for pane navigation

" buffer navigation
" I'm basically never using these. Find a better use for tab.
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprev<cr>

" jump to mru buffer
nnoremap <leader><tab> :b#<cr>

" clear highlight with <esc><esc> after a search
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

" resize vertical column into current window takes 1/2, 1/3, 1/4 of available
" height
" Kinda buggy, sometimes repeated calls to 3 or 4 are necessary - buggy when
" splits were not already evenly sized. Reproduce by setting 3 split layout
" to .25, .5, .25, then c-w3 on the bottom split.
" try adding set windows equal at some point? <c-w>=
nnoremap <c-w>2 :call <SID>ResizeActive(0.5)<cr>
nnoremap <c-w>3 :call <SID>ResizeActive(0.67)<cr>
nnoremap <c-w>4 :call <SID>ResizeActive(0.75)<cr>

function! s:ResizeActive(percentage)
    let l:data = s:find_parallel_windows(winnr())
    let l:current_window = winnr()

    let l:height_remainder = &lines * (1 - a:percentage)
    let l:leftover_per_window = l:height_remainder / len(l:data.height)

    exec printf("resize %f", l:height_remainder)

    for window in l:data.height
        " set active window to <window>
        exec window . "wincmd w"

        exec printf("resize %f", l:leftover_per_window)
    endfor

    " restore the active window
    exec l:current_window . "wincmd w"
endfunction

" copied from github.com/roman/golden-ratio
" returns separate lists of windows that are parallel to the argument window
" on the horizontal plane and on the vertical plane
function! s:find_parallel_windows(current_window)
    return {
        \ 'width' : filter(reverse(range(1, winnr('$'))),
        \                  'winheight(v:val) == winheight(a:current_window) ' . '&& v:val != a:current_window'),
        \ 'height': filter(reverse(range(1, winnr('$'))),
        \                  'winwidth(v:val) == winwidth(a:current_window) ' . '&& v:val != a:current_window')
        \}
endfunction

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
" TODO: figure out how to set keywordprg on vim source if necessary
" presumably that is why i had this
" nnoremap K :help <cword><cr>

" disable command history window
" really tired of triggering it instead of :q
noremap q: <NOP>

" switch ' and ` for marks.
" ' defaults to begining of line on the marked line
" ` defaults to the exact marked spot
" nnoremap ' `
" nnoremap ` '

" map tab and shift-tab to completion menu navigation
" map return to exit popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" map ctrl-j/k to completion menu navigation
" if not in a completion menu, then dump out of insert mode
" and navigiate down/up between panes
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<esc><c-w><c-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<esc><c-w><c-k>"

" change next mapping from
" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nnoremap cn *``cgn

" delete the line below (o) and above(O) the current line
" without moving the current cursor position
nnoremap do mzjdd`z
nnoremap dO mzkdd`z

" add a blank linke below (o) or above(O) the current line
" and remain in normal mode
nnoremap <leader>o mzo<esc>`z
nnoremap <leader>O mzO<esc>`z

" scroll the screen faster while keeping the cursor line in the same visual spot
nnoremap <C-e> 2j2<C-e>
nnoremap <C-y> 2k2<C-y>

" shortcut for reviewing staged git changes
" command Greview :Git! diff --staged
" nnoremap <leader>gr :Greview<cr>

onoremap ge :!rev<cr>

" so much TODO:
" make detection of submodules automatic and include changed files within the
" submodules.
nnoremap <silent>gtd :lgetexpr system('rg --vimgrep -g "\!*/model/*" -g "\!*/utilities/*" -g "\!*/altaUtils/*" -g "\!*/reports/*" "TODO" (git diff --name-only --diff-filter=d)')<CR>:bot lopen<CR>

" replace the current buffer's content converted from raw markdown to parsed markdown
" mostly useful for populating numbered lists et al.
" augroup markdown
" 	autocmd!
" 	autocmd FileType markdown nnoremap <silent><leader>md :%!pandoc -r markdown -w markdown<cr>
" 	autocmd FileType markdown nnoremap <silent><leader>gfm :%!pandoc -r markdown -w gfm<cr>
" augroup END
nnoremap <silent><leader>md :%!pandoc -r markdown -w markdown<cr>
nnoremap <silent><leader>gfm :%!pandoc -r markdown -w gfm<cr>

" run the most recent macro
nnoremap Q @@

nnoremap <leader>e :exe getline(line('.'))<cr>

" Arduino development
nnoremap <buffer> <leader>am :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

" d= to delete from here to the end of whitespace after a '=' character
" intended for removing the assignemnt before an expression
nnoremap d= df=dw
nnoremap c= df=cw

" grep project for word under cursor
nnoremap GR :Ack! -F "<c-r><c-w>"<CR>

" relies on python module sqlformat
vnoremap <leader>q :'<'>!sqlformat --reindent --keywords upper --identifiers lower - <CR>

"""""""""""""
" OTHER STUFF
"""""""""""""

function! TrimTrailingWhitespace()
    " save cursor position and last search
    let pos = getpos(".")
    let _s = @/

    " trim trailling whitespace
    %s/\s\+$//e

    " restore cursor position and last search
    call setpos(".", pos)
    let @/ = _s
endfunction

" remove trailing whitespace on save
augroup trim_whitespace
    autocmd!
    " trims whitespace and restores cursor position
    autocmd BufWritePre * call TrimTrailingWhitespace()
augroup END

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
    autocmd Filetype gitcommit setlocal spell
    autocmd Filetype Dockerfile set tabstop=4 shiftwidth=4 expandtab
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" files to hide from netrw
let g:netrw_list_hide = '.*\.pyc$,'
let g:netrw_list_hide.= '__pycache__/,'
let g:netrw_list_hide.='\.DS_Store,'
let g:netrw_list_hide.= '\.git,'
let g:netrw_list_hide.= 'tags,'
let g:netrw_list_hide.= 'test.db,'
let g:netrw_list_hide.= '\.pytest_cache,'

" sane files to ignore
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/*.pyc,__pycache__,*/tags,*/tags.lock,*/tags.temp,*/node_modules,*/tests.db*,

" fish doesn't play posix
" tell vim to use a regular shell
" if &shell =~# 'fish$'
"     " disable all zsh files while we're at it
"     set shell=zsh
" endif

" let's do some whitspace highlighting
" set listchars=tab:▶ ,space:.,trail:.

" because fuck vim turds are annoying
set nobackup
set nowritebackup
set noswapfile

" decrease CursorHold
set updatetime=10

" TODO: add setup of this in bootstrap.sh
if filereadable(expand('~') . '/environments/nvim_python/bin/python')
    let g:python_host_prog = expand('~') . '/environments/nvim_python/bin/python'
endif
if filereadable(expand('~') . '/environments/nvim_python3/bin/python')
    let g:python3_host_prog = expand('~') . '/environments/nvim_python3/bin/python'
endif

" TODO: activating a virutal env does not change PATH and thus currently
" requires setting an explicit path for pylint. otoh we finally have pylint
" working correctly in each of multiple projects open at once.
" TODO: try modifying os.environ from within python to add venv/bin python
" path so pylint et al can be found
"
if has('nvim') && !empty($WORKON_HOME)
    if has('python')
py << EOS
import os, vim
env_base_dir = None
#if 'VIRTUAL_ENV' in os.environ:
#     env_base_dir = os.environ['VIRTUAL_ENV']
if '.git' in os.listdir(os.curdir):
    workon_home = os.environ['WORKON_HOME']
    env = os.path.join(workon_home, os.path.basename(os.path.abspath(os.curdir)))
    if os.path.exists(env):
        env_base_dir = env
if env_base_dir:
    # TODO: try not using the python version of activate
    # our problem seems to be that the shell enviornments of `echo $PATH`
    # and `:!echo $PATH` are not the same
    activate_this = os.path.join(env_base_dir, 'bin', 'activate_this.py')
    exec(open(activate_this).read(), dict(__file__=activate_this))

    # set path
    bin_path = os.path.join(env_base_dir, 'bin')
    #os.environ['PATH'] = bin_path + ':' + os.environ['PATH']

    # setup an explicit pylint executable location
    pylint_path = os.path.join(bin_path, 'pylint')
    cmd = "let g:ale_python_pylint_executable='{}'".format(pylint_path)
    vim.command(cmd)

    flake8_path = os.path.join(bin_path, 'flake8')
    cmd = "let g:ale_python_flake8_executable='{}'".format(flake8_path)
    vim.command(cmd)
EOS
    endif
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

" nnoremap <silent> <leader>t :SwapTest<cr>

function! SetupBuffer()
    syn match WinNormal /  .*/
    syn match WinSelected /> .*/hs=s+1

    hi def link WinNormal   PMenu
    hi def link WinSelected PMenuSel

    " noautocmd botright pedit __Potion_Bytecode__
    split __mybuff__

    " select previous window
    " noautocmd wincmd P

    setlocal nomodifiable

    setlocal nobuflisted
    setlocal nowrap
    setlocal nonumber
    if exists('+relativenumber')
        setlocal norelativenumber
    endif
    setlocal nocursorcolumn
    setlocal colorcolumn=0
    " setlocal nocursorline
    setlocal cursorline
    setlocal nospell
    setlocal nolist

    " setlocal noshowmode
    " setlocal noruler
    " setlocal laststatus=0
    " setlocal noshowcmd

    set modifiable
    " clear the buffer
    normal! ggdG

    setlocal buftype=nofile

    setlocal winfixheight

    resize 5

    " map a-z and A-Z to our key echo loop
    let ranges = range(65, 90) + range(97, 122)
    for n in ranges
        execute 'nnoremap <buffer> ' . nr2char(n) . ' :call MyLoop("' . nr2char(n) . '")<cr>'
    endfor
    execute 'nnoremap <buffer> <space> :call MyLoop(" ")<cr>'

    " map keys to navigate the results list
    nnoremap <silent> <buffer> <down> :normal! j<cr>
    nnoremap <silent> <buffer> <up> :normal! k<cr>
    nnoremap <silent> <buffer> <c-j> :normal! j<cr>
    nnoremap <silent> <buffer> <c-k> :normal! k<cr>

    nnoremap <esc> normal! <c-w><c-k><cr>

    let s:input_so_far = ''
    set nomodifiable
    call MyLoop('')
endfunction

function! MyLoop(char)

    setlocal modifiable

    let s:input_so_far .= a:char
    echom "so far: '" . s:input_so_far "'"

    if a:char ==# " "
        echom "got a space"
    endif

    " draw main content
    let content = ["  result 1", "  result 2", "> result 3", "  result 4"]

    silent! normal! ggdG

    " add content to the window
    silent! call append(0, content)

    " silent! call cursor(3, 1)

    " draw statusline
    setlocal statusline=""

    redraw

    " draw prompt
    echon '> ' . s:input_so_far . '_'

    setlocal nomodifiable

    " general pattern for drawing a prompt
    " 1. draw your actaul content
    " 2. set setatusline
    " 3. map all valid keys to a custom handliner including a-zA-Z0-9
    " 4. echoh out a prompt + saved previous input
    " 5. in that handler add your new input and
    " 6. redraw everything

endfunction

nnoremap <leader>s :call SetupBuffer()<cr>
