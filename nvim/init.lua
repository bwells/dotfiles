-- TODO: consider making this a command like :InstallPacker instead of checking on every startup
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

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
-- TODO: sort-motion isn't working, try setting up earlier or later, mapping conflict?


-- local Plug = vim.fn['plug#']

-- vim.call('plug#begin', '~/.config/nvim/plugged')

require('packer').startup(function(use)

-- Packer itself
use 'wbthomason/packer.nvim'

---------------------------
-- Motions and Text Objects
---------------------------

-- adds . repeat to more commands
use 'tpope/vim-repeat'

-- more sanity to yanking
use 'svermeulen/vim-cutlass'
use 'svermeulen/vim-yoink'

-- best of easymotion and sneak
-- smarter s/S and f/F
use {
  'ggandor/lightspeed.nvim',
  config = function()
    require('lightspeed').setup {}
  end
}

-- add motions for word hunks in camel or underscore case
use 'chaoren/vim-wordmotion'

-- lots of targets
-- separators, args, etc
use 'wellle/targets.vim'

-- motions/text objects for surrounding selections with chars
use 'tpope/vim-surround'

-- defines a sort motion
use 'christoomey/vim-sort-motion'
use 'sQVe/sort.nvim'

-- base64 conversion word motion
use 'christianrondeau/vim-base64'

-----------
-- Commands
-----------

-- gcc to toggle comment current line
-- gc to toggle comment selected line(s)
use 'numToStr/Comment.nvim'

-- auto quote/bracket/paren matching
-- Plug 'Raimondi/delimitMate'
-- Plug 'tmsvg/pear-tree'
use 'windwp/nvim-autopairs'

-- provides mixed case abbreviations and searches
use 'tpope/vim-abolish'

-- <leader>a converts arg lists inline<>multiline
use 'FooSoft/vim-argwrap'

-- Build system
use { 'pianocomposer321/yabs.nvim', tag = 'v1.0' }

-- Install the builtin but not on by default CFilter/LFilter plugin
-- allows filtering quickfix/llist windows via //
vim.cmd([[packadd cfilter]])

-- quickfix quality of life improvements
-- Plug 'kevinhwang91/nvim-bqf'


-------------
-- Navigation
-------------

-- better bdelete
-- :bc to close a buffer without also closing the split
use 'moll/vim-bbye'

-- use 'nvim-lua/plenary.nvim'

-- git changes in the number column
-- also provides hs to stage changes and ]c,[c to navigate to changes
use { 'lewis6991/gitsigns.nvim', tag = 'v0.4' }

-- Telescope
use 'nvim-lua/popup.nvim'
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    {'nvim-lua/plenary.nvim'},
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'kyazdani42/nvim-web-devicons' }
  }
}

-- nvim-tree
use 'kyazdani42/nvim-tree.lua'

-- nvim-cmp
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'onsails/lspkind-nvim'

-- Harpoon
use 'ThePrimeagen/harpoon'


------
-- LSP
------
use 'neovim/nvim-lspconfig'
use 'williamboman/nvim-lsp-installer'

-- null-lsp
use 'jose-elias-alvarez/null-ls.nvim'


------------------------------
-- Display
------------------------------
-- Treesitter and friends
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'nvim-treesitter/playground'
use 'romgrk/nvim-treesitter-context'

-- statusline
use 'nvim-lualine/lualine.nvim'

-- line for color column
use 'lukas-reineke/virt-column.nvim'

-- highlights color codes with that color as the background
use 'norcalli/nvim-colorizer.lua'

-- material colorscheme
use 'marko-cerovac/material.nvim'

use { 'folke/tokyonight.nvim', branch = 'main' }

use 'rcarriga/nvim-notify'

use 'nvim-neorg/neorg'


-----------------
-- Language Packs
-----------------

-- needed for correct indentation on new lines
use 'hynek/vim-python-pep8-indent'

-- Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
use 'Zaptic/elm-vim'
-- Plug 'dag/vim-fish', { 'for': 'fish' }
-- Plug 'fatih/vim-go', { 'for': 'go' }
use 'sophacles/vim-bundle-mako'
use 'Glench/Vim-Jinja2-Syntax'
-- Plug 'rust-lang/rust.vim'

-- vim.call('plug#end')

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
  require('packer').sync()
end

end)

-- setup plugin configurations
require('plugins')

-- setup colorschemes
require('colors')

-- update packer anytime plugins may have changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
