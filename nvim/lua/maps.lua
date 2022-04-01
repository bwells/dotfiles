local map = vim.api.nvim_set_keymap
local defaults = { noremap = true, silent = true }

-- disable arrow keys in normal mode
map("", "<Up>", "<NOP>", defaults)
map("", "<Down>", "<NOP>", defaults)
map("", "<Left>", "<NOP>", defaults)
map("", "<Right>", "<NOP>", defaults)


-----------
--  Editing
-----------

-- jk for esc
map("i", "jk", "<esc>l", defaults)

-- add a blank linke below (o) or above(O) the current line
-- and remain in normal mode
map("n", "<leader>o", "mzo<esc>`z", defaults)
map("n", "<leader>O", "mzO<esc>`z", defaults)

map("n", "do", "mzjdd`z", defaults)
map("n", "dO", "mzkdd`z", defaults)

-- clear highlight with <esc><esc> after a search
map("n", "<esc><esc>", ":noh<return><esc>", defaults)


-------------
-- Navigation
-------------

-- Keep search movements at the center of screen
map("n", "n", "n:lua CenterView()<cr>", defaults)
map("n", "N", "N:lua CenterView()<cr>", defaults)
map("n", "*", "*:lua CenterView()<cr>", defaults)
map("n", "#", "#:lua CenterView()<cr>", defaults)
map("n", "g*", "g*:lua CenterView()<cr>", defaults)
map("n", "g#", "g#:lua CenterView()<cr>", defaults)

-- scroll the screen faster while keeping the cursor line in the same visual spot
map("n", "<C-e>", "2j2<C-e>", defaults)
map("n", "<C-y>", "2k2<C-y>", defaults)

-- buffer navigation
-- I'm basically never using these. Find a better use for tab.
-- map("n", "<tab>", ":bnext<cr>", defaults)
-- map("n", "<s-tab>", ":bprev<cr>", defaults)

-- jump to mru buffer
map("n", "<leader><tab>", ":b#<cr>", defaults)

-- if i hit c-j/k in insert mode dump out and do what i wanted
-- map("i", "<C-j>", "<esc><c-w><c-j>", defaults)
-- map("i", "<C-k>", "<esc><c-w><c-k>", defaults)

-- next and previous diagnostics
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', defaults)
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', defaults)

map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', defaults)
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', defaults)

-- get to normal mode in a terminal with all the usual inputs
vim.cmd([[
tnoremap jk <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
]])

-- rezise splits left/right
map("n", "<C-w>,", "<C-w>>", defaults)
map("n", "<C-w>.", "<C-w><", defaults)


--------------------
-- Global Management
--------------------

-- edit config files
function GetConfigPath(configFile)
    local configPath = vim.fn.expand("~") .. "/.config/nvim/lua/" .. configFile
    print(configPath)
    return configPath
end

map("n", "<leader>v", ":edit $MYVIMRC<cr>", defaults)
map("n", "<leader>vp", ":lua vim.cmd(':edit ' .. GetConfigPath('plugins.lua'))<cr>" , defaults)
map("n", "<leader>vm", ":lua vim.cmd(':edit ' .. GetConfigPath('maps.lua'))<cr>" , defaults)
map("n", "<leader>vo", ":lua vim.cmd(':edit ' .. GetConfigPath('opts.lua'))<cr>" , defaults)
map("n", "<leader>vc", ":lua vim.cmd(':edit ' .. GetConfigPath('colors.lua'))<cr>" , defaults)


function ReloadConfig()
  local reload = require('plenary.reload')

  reload.reload_module('opts', true)
  reload.reload_module('maps', true)
  reload.reload_module('plugins', true)
  reload.reload_module('colors', true)

  require('opts')
  require('maps')
  require('plugins')
  require('colors')
end

map("n", "<leader>vr", ":lua ReloadConfig()<cr>", defaults)


-- TODO: put this somewhere?
-- scroll current line to middle if it is within two of the window edge
function CenterView ()
    if vim.fn.winline() <= 2 or vim.fn.winline() >= vim.fn.winheight(0) - 1 then
        vim.cmd([[normal! zz]])
    end
end
