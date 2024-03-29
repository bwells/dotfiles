" change leader to space
" required before plugin loads to ensure they configure correctly
let mapleader=" "

""""""""""
" PLUGINS
""""""""""
call plug#begin()

" basic setup for all vim
Plug 'tpope/vim-sensible'

" extend the power of . to more complex objects
Plug 'tpope/vim-repeat'

" git integration. seems to have the most mindshare
Plug 'tpope/vim-fugitive'

" disabled for now for performance reasons
" Plug 'jreybert/vimagit'

" github support for fugative
Plug 'tpope/vim-rhubarb'

" map s so that vim-cutlass doesn't override it
nmap s <nop>

" sanity to copy/paste
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
" Plug 'svermeulen/vim-subversive'

" unmap s so that lightspeed now WILL override it
unmap s

" sneek - simpler alternative to easymotion or a better f
" Plug 'justinmk/vim-sneak'
Plug 'ggandor/lightspeed.nvim'

nmap s <Plug>Lightspeed_s
nmap S <Plug>Lightspeed_S

" git gutter. []c to navigate change hunks
" <leader>hs to stage hunk
Plug 'airblade/vim-gitgutter'

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

" plugin management QOL from tpope
" zS to show active syntax highlight group
Plug 'tpope/vim-scriptease'

" provides mixed case abbreviations and searches
Plug 'tpope/vim-abolish'

" wrapper around ag for project wide search
Plug 'mileszs/ack.vim'

" allow vim<->tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'

Plug 'ludovicchabant/vim-gutentags'

" better bdelete
Plug 'moll/vim-bbye'

" gave in and using nerdtree rather than netrw
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" consider this as a replacement for NERDTree
" Plug 'kyazdani42/nvim-tree.lua'

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
" Plug 'jeetsukumaran/vim-pythonsense'

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
Plug 'Zaptic/elm-vim'

" color scheme

" Plug 'TroyFletcher/vim-colors-synthwave'

" Plug 'shaunsingh/moonlight.nvim'

Plug 'marko-cerovac/material.nvim'
" Plug 'rafamadriz/neon'
" Plug 'ful1e5/onedark.nvim'
" Plug 'yashguptaz/calvera-dark.nvim'
" Plug 'folke/tokyonight.nvim'
" Plug 'seanjbl/tonight.nvim'
Plug 'wuelnerdotexe/vim-enfocado'

" Async lint runner
Plug 'w0rp/ale'

" adds gS and gJ to syntactically aware split/join constructs
Plug 'AndrewRadev/splitjoin.vim'

" :s live feedback
Plug 'osyo-manga/vim-over'

" fzf fuzzy finder and wrapper
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'hynek/vim-python-pep8-indent'

" Plug 'bwells/vim-named-sessions'

" Plug 'bwells/simplysublime'

Plug 'FooSoft/vim-argwrap'

" defines a sort motion
Plug 'christoomey/vim-sort-motion'

Plug 'machakann/vim-highlightedyank'

" improves terminal support - adds insert mode cursor
Plug 'wincent/terminus'

" integrated test running
Plug 'janko-m/vim-test'

Plug 'stevearc/vim-arduino'

" quickfix list helpers
Plug 'romainl/vim-qf'

" base64 encoding
" <leader>btoa and <leader>atob in visual
Plug 'christianrondeau/vim-base64'

if has('nvim')
	" Treesitter configs and parsers
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

	" LSP configs and servers
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/nvim-lsp-installer'

	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'kyazdani42/nvim-web-devicons'

	" alternative file finder to Telescope.
	" Plug 'camspiers/snap'

	" completion and snippets
	" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
	" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'

	Plug 'onsails/lspkind-nvim'

	" build system, still not mapped
    Plug 'pianocomposer321/yabs.nvim'

    Plug 'numToStr/Comment.nvim'

    " colorscheme switcher
	Plug 'metalelf0/witch-nvim'
else
    " gcc to toggle comment current line
    " gc to toggle comment selected line(s)
	Plug 'tomtom/tcomment_vim'
endif

" Add plugins to &runtimepath
call plug#end()

" tell vim that your terminal supports 256 colors
let base16colorspace=256
" set t_8f=^[[38;2;%lu;%lu;%lum
" set t_8b=^[[48;2;%lu;%lu;%lum
set t_Co=256

"""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""

if has('nvim')

" configure treesitter
"   installs all parsers and enables treesitter for all of those
lua << EOF

--
-- TreeSitter
--

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
	enable = true, -- false will disable the whole extension
	disable = {},  -- list of language that will be disabled
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        -- ["ac"] = "@class.outer",
        -- ["ic"] = "@class.inner",
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.outer",
		["al"] = "@loop.outer",
		["il"] = "@loop.inner",

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --   python = "(function_definition) @function",
        --   cpp = "(function_definition) @function",
        --   c = "(function_definition) @function",
        --   java = "(method_declaration) @function",
        -- },
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    --   goto_next_start = {
    --     ["]m"] = "@function.outer",
    --     ["]]"] = "@class.outer",
    --   },
    --   goto_next_end = {
    --     ["]M"] = "@function.outer",
    --     ["]["] = "@class.outer",
    --   },
    --   goto_previous_start = {
    --     ["[m"] = "@function.outer",
    --     ["[["] = "@class.outer",
    --   },
    --   goto_previous_end = {
    --     ["[M"] = "@function.outer",
    --     ["[]"] = "@class.outer",
    --   },
    -- },
  },
}

--
-- LSP
--

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {}

  -- disable python diagnostics for now
  if server.name == "pylsp" then
     opts.handlers = {
         ["textDocument/publishDiagnostics"] = function() end
     }
  end

  if server.name == 'elmls' then
    opts['capabilities'] = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  end

  opts.on_attach = on_attach

  nvim_lsp[server.name].setup(opts)
end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      severity_limit = "Hint",
    },
    virtual_text = {
      severity_limit = "Warning",
    },
  }
)


--
-- Telescope
--

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
    }
  }
}

require('telescope').load_extension('fzf')

require("yabs"):setup {
    languages = {  -- List of languages in vim `filetype` format
        elm = {
            default_task = "build_and_run",
            tasks = {
                build = {
                    command = "cd elm; find src/Entry -name '*.elm'  | xargs elm make --output ../portal/public/scripts/elm.js --debug",
                    output = "echo",
                }
            }
        }
    }
}

vim.api.nvim_set_keymap('n', '<Leader>y', '<cmd>Telescope yabs tasks<cr>', {noremap = true})

-- colorscheme material
vim.g.material_style = "deep ocean"
vim.g.material_terminal_italics = false
vim.g.material_italic_comments = false
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false

EOF

endif

""" netrw
let g:netrw_liststyle = 3
let g:netrw_altv = 1

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

""" cutlass.vim
nnoremap m d
xnoremap m d
nnoremap gm m

nnoremap mm dd
nnoremap M D

""" yoink.vim
let g:yoinkIncludeDeleteOperations = 1

nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

nnoremap Y y$

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
if exists("tcomment")
	call tcomment#type#Define('dosini', '#%s')
endif

""" Comment.nvim
if has('nvim')
lua << EOF
	require('Comment').setup()
	local ft = require('Comment.ft')
	ft.text = '# %s'
EOF
endif

""" vim-wordmotion
let g:wordmotion_prefix = "<leader>"

" override the default 'b' mapping to avoid conflicting
" with <leader>b to open FZF buffer search
let g:wordmotion_mappings = { 'b': '<M-b>' }

""" ale
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\   'elm': []
\}

" let g:ale_fixers = {
" \   'python': ['black', 'isort']
" \}

" let g:ale_fix_on_save = 1

let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_python_pylint_use_global = 0

nmap <silent> [E <Plug>(ale_previous_wrap)
nmap <silent> ]E <Plug>(ale_next_wrap)

""" vim-sneak
" add easymotion like arbitrary key for global movement to sneak
" let g:sneak#streak = 1
" let g:sneak#s_next = 1
" let g:sneak#absolute_dir = 1

""" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

""" ack.vim
if executable('rg')
    let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

function! GetFileType()
	" map vim filetype values to those accepted by rg's -t option
	let l:type_remaps = {
        \ 'javascript': 'js',
		\ 'mako': 'html',
		\ 'python': 'py',
		\}

	" fetch filetype overrides, defaulting to vim's filetype value
	return get(l:type_remaps, &filetype, &filetype)
endfunction

" <left> leaves the cursor position in between the quotes
nnoremap <leader>/ :Ack!<space>-F<space>""<left>
nnoremap <expr> <leader>l ':Ack! -F -t ' . GetFileType() . ' ""<left>'

" xnoremap <leader>/ y:Ack -F "<c-r>""
xnoremap <leader>/ :<c-u>Ack -F "<c-r>=<SID>GetVisualSelection()<cr>"

function! s:GetVisualSelection()
  try
    let a_save = @a

	" select the last visual selection again
	" and then yank it to register a
    normal! gv"ay

    return @a
  finally
    let @a = a_save
  endtry
endfunction

""" lightspeed
lua << EOF
require'lightspeed'.setup {
  grey_out_search_area = true
}
EOF

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
if has('nvim')
	" nnoremap <leader>fb <cmd>Telescope file_browser<cr>
	nnoremap <leader>gs <cmd>Telescope grep_string<cr>
	nnoremap <leader>lg <cmd>Telescope live_grep<cr>
	nnoremap <leader>/ <cmd>Telescope live_grep<cr>

	nnoremap <leader>ts <cmd>Telescope treesitter<cr>

	nnoremap <Leader>f <cmd>Telescope find_files<cr>
	nnoremap <Leader>b <cmd>Telescope buffers<cr>
	nnoremap <Leader>t <cmd>Telescope tags<cr>
	nnoremap <Leader>q <cmd>Telescope quickfix<cr>

	" imap c-/ to see picker actions help
	" map ? to see picker actions help
else
	nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
	nnoremap <Leader>b :Buffers<cr>
	nnoremap <Leader>t :Tags<cr>
endif
" nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
" nnoremap <Leader>b :Buffers<cr>
" nnoremap <Leader>t :Tags<cr>

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

""" coq
" set completeopt=menuone,noselect,noinsert
" set shortmess+=c
"
" let g:coq_settings = { 'auto_start': v:true }

""" nvim-cmp
set completeopt=menu,menuone,noselect

lua << EOF
  -- Setup nvim-cmp.
  local lspkind = require'lspkind'
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = "buffer", keyword_length = 5 },
    }),

    -- ganked from tj's settings
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
          gh_issues = "[issues]",
          tn = "[TabNine]",
        },
      },
    },

    experimental = {
      -- I like the new menu better! Nice work hrsh7th
      native_menu = false,

      -- Let's play with this for a day or two
      ghost_text = true,
    },

  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['elmls'].setup {
  --   capabilities = capabilities
  -- }
EOF


""""""""""""""""
" IT'S NOT 1970
""""""""""""""""

" " tell vim that your terminal supports 256 colors
" let base16colorspace=256
" " set t_8f=^[[38;2;%lu;%lu;%lum
" " set t_8b=^[[48;2;%lu;%lu;%lum
" set t_Co=256

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
if (has('termguicolors'))
  set termguicolors
endif

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

" colors synthwave
" hi ColorColumn guifg=NONE guibg=#536991 guisp=NONE ctermfg=NONE ctermbg=60 cterm=NONE
" hi Function guifg=#ff00bb guibg=NONE guisp=NONE gui=NONE ctermfg=199 ctermbg=NONE cterm=bold
" hi String guifg=#dd00ff guibg=#181615 guisp=#000000 gui=NONE ctermfg=165 ctermbg=NONE cterm=NONE
" hi Comment guifg=#9c38bd guibg=#181615 guisp=NONE gui=italic ctermfg=5 ctermbg=0 cterm=NONE
" hi Exception guifg=#bd0065 guibg=#181615 guisp=#000000 gui=bold ctermfg=5 ctermbg=NONE cterm=bold
" hi Normal guifg=#f9fcfc guibg=#181615 guisp=#181615 gui=NONE ctermfg=15 ctermbg=234 cterm=NONE
" hi SignColumn guifg=#f9fcfc guibg=#181615 guisp=#181615 gui=NONE ctermfg=15 ctermbg=234 cterm=NONE

" hi ColorColumn guifg=NONE guibg=#db93c8 guisp=#db93c8 ctermfg=235 ctermbg=248 cterm=NONE
" hi ColorColumn guifg=NONE guibg=#6cddf1 guisp=#db93c8 ctermfg=235 ctermbg=248 cterm=NONE
" hi ColorColumn guifg=NONE guibg=#bd0065 guisp=NONE ctermfg=NONE ctermbg=248 cterm=NONE


" original material dark CursorColumn
" highlight cterm=underline guibg=#1A1C25
" highlight CursorLine cterm=underline guibg=#30323A
" highlight CursorLine cterm=underline guibg=#262830
highlight CursorLine cterm=underline guibg=#1B1D25

" 0F111A is normal material dark background
" 262830 bump lighter


let g:enfocado_style = "neon"

let s:mycolors = ['material', 'enfocado']

nnoremap <leader>c :call NextColor(1)<CR>

colorscheme material

" disable fucking folding
augroup fuck_folding
    autocmd!
    autocmd BufEnter * set nofoldenable
augroup END

" use rg for grep
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

set timeoutlen=500

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
nnoremap <silent> n n:call <SID>CenterView()<cr>
nnoremap <silent> N N:call <SID>CenterView()<cr>
nnoremap <silent> * *:call <SID>CenterView()<cr>
nnoremap <silent> # #:call <SID>CenterView()<cr>
nnoremap <silent> g* g*:call <SID>CenterView()<cr>
nnoremap <silent> g# g#:call <SID>CenterView()<cr>

" does not seem to be working...
nnoremap <silent> ]m ]m:call <SID>CenterView()<cr>
nnoremap <silent> [m [m:call <SID>CenterView()<cr>
nnoremap <silent> ]] ]]:call <SID>CenterView()<cr>
nnoremap <silent> [[ [[:call <SID>CenterView()<cr>

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

" causing issues with LSP setup!?
" " auto source vimrc on write
" augroup reload_vimrc
"     autocmd!
"     autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
" augroup END

" customizations for filetypes
augroup filetypes
    autocmd!
    autocmd FileType vim set tabstop=4 shiftwidth=4
    autocmd FileType html,javascript set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType mako set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType dosini set commentstring=#%s
	autocmd Filetype elm set tabstop=4 shiftwidth=4 expandtab
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

" nnoremap <leader>s :call SetupBuffer()<cr>

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    return
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

" nnoremap <F8> :call NextColor(1)<CR>
" nnoremap <S-F8> :call NextColor(-1)<CR>
" nnoremap <A-F8> :call NextColor(0)<CR>

nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

