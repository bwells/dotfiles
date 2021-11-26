-----------
-- Material
-----------
vim.g.material_style = "deep ocean"

local material = require('material')
material.setup{
	italics = {
		comments = false,
    keywords = false,
		functions = false,
		strings = false,
		variables = false
	},
  custom_highlights = {
    CursorLine = { fg = material.none, bg = '#1B1D25' },
    Selection = { fg = material.none, bg = '#8E97C4' }
  }
}

vim.cmd([[colorscheme material]])


------------
-- Colorizer
------------
require'colorizer'.setup()


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

--------------
-- virt-column
--------------
require("virt-column").setup()
vim.cmd([[highlight clear ColorColumn]])
