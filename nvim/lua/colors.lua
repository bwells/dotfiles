-----------
-- Material
-----------
vim.g.material_style = "deep ocean"
vim.g.material_terminal_italics = false
vim.g.material_italic_comments = false
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false

-- original material dark CursorColumn
-- highlight cterm=underline guibg=#1A1C25
-- highlight CursorLine cterm=underline guibg=#30323A
-- highlight CursorLine cterm=underline guibg=#262830
vim.cmd([[highlight CursorLine cterm=underline guibg=#1B1D25]])

-- 0F111A is normal material dark background
-- 262830 bump lighter

vim.cmd([[colorscheme material]])

----------
-- Lualine
----------

-- disable showing the builtin mode indicator
vim.o.showmode = false

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'material-nvim'
    theme = 'material'
  },
  sections = {
    lualine_a = {'mode'},
    -- branch, changes, diagnostics and all the rest is too wide for a 100 col split
    -- lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp'}}},
    lualine_b = {'branch', {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'filename'},
    lualine_x = {'filetype', 'fileformat', 'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'quickfix', 'nvim-tree'}
}
