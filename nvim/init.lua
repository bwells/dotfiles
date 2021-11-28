-- load basic vim options
require('opts')

-- load keymaps
require('maps')

-- TODO: explore different auto pairs plugins, nvim-autopairs so far, but seems to have the same problems
-- TODO: tags managment via LSP? maybe working?
-- TODO: get elm formatting on save without elm-vim package
-- TODO: check on mhartington video usage of treesitter? + comments to comment per local language correctly.
-- TODO: fix default comments for text file types that aren't working (requirements files?)
-- TODO: check that one youtube video for how to search -> Telescope -> refine
--
-- TODO: check out harpoon for buffer management workflow improvements
-- TODO: check out neogit, ala magit
-- TODO: explore diffview.nvim
-- TODO: explore orgmode.nvim or nvim-neorg
-- TODO: move plugin install to separate files
-- TODO: check out this dudes python testing workflow. https://www.reddit.com/r/neovim/comments/r312nn/whats_the_best_tool_for_testing/hm9dvmj/


local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

---------------------------
-- Motions and Text Objects
---------------------------

-- adds . repeat to more commands
Plug 'tpope/vim-repeat'

-- more sanity to yanking
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'

-- best of easymotion and sneak
-- smarter s/S and f/F
Plug 'ggandor/lightspeed.nvim'

-- add motions for word hunks in camel or underscore case
Plug 'chaoren/vim-wordmotion'

-- lots of targets
-- separators, args, etc
Plug 'wellle/targets.vim'

-- motions/text objects for surrounding selections with chars
Plug 'tpope/vim-surround'

-- defines a sort motion
Plug 'christoomey/vim-sort-motion'

-- base64 conversion word motion
Plug 'christianrondeau/vim-base64'

-----------
-- Commands
-----------

-- gcc to toggle comment current line
-- gc to toggle comment selected line(s)
Plug 'numToStr/Comment.nvim'

-- auto quote/bracket/paren matching
-- Plug 'Raimondi/delimitMate'
-- Plug 'tmsvg/pear-tree'
Plug 'windwp/nvim-autopairs'

-- provides mixed case abbreviations and searches
Plug 'tpope/vim-abolish'

-- <leader>a converts arg lists inline<>multiline
Plug 'FooSoft/vim-argwrap'

-- Build system
Plug 'pianocomposer321/yabs.nvim'


-------------
-- Navigation
-------------

-- better bdelete
-- :bc to close a buffer without also closing the split
Plug 'moll/vim-bbye'

-- git changes in the number column
-- also provides hs to stage changes and ]c,[c to navigate to changes
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

-- Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'kyazdani42/nvim-web-devicons'

-- nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

-- nvim-cmp
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'

-- harpoon
Plug 'ThePrimeagen/harpoon'


------
-- LSP
------
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

-- null-lsp
Plug 'jose-elias-alvarez/null-ls.nvim'

------------------------------
-- Display
------------------------------
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug 'nvim-treesitter/playground'

-- statusline
Plug 'nvim-lualine/lualine.nvim'

-- line for color column
Plug 'lukas-reineke/virt-column.nvim'

-- highlights color codes with that color as the background
Plug 'norcalli/nvim-colorizer.lua'

-- material colorscheme
Plug 'marko-cerovac/material.nvim'
Plug('folke/tokyonight.nvim', {['branch'] = 'main' })


-----------------
-- Language Packs
-----------------

-- needed for correct indentation on new lines
Plug 'hynek/vim-python-pep8-indent'

-- Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'Zaptic/elm-vim'
-- Plug 'dag/vim-fish', { 'for': 'fish' }
-- Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'sophacles/vim-bundle-mako'
-- Plug 'rust-lang/rust.vim'

vim.call('plug#end')

-- setup plugin configurations
require('plugins')

-- setup colorschemes
require('colors')
