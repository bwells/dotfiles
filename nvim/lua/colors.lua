-----------
-- Material
-----------
vim.g.material_style = "deep ocean"

local material = require('material')
material.setup{
  styles = {
		comments = { italic = false },
    keywords = { italic = false },
		functions = { italic = false },
		strings = { italic = false },
		variables = { italic = false },
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    -- "dap",
    -- "dashboard",
    "gitsigns",
    -- "hop",
    -- "indent-blankline",
    -- "lspsaga",
    -- "mini",
    "neogit",
    "nvim-cmp",
    -- "nvim-navic",
    "nvim-tree",
    -- "sneak",
    "telescope",
    "trouble",
    -- "which-key",
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
    theme = 'material'
  },
  sections = {
    lualine_a = {'mode'},
    -- branch, changes, diagnostics and all the rest is too wide for a 100 col split
    -- lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp'}}},
    -- lualine_b = { {'branch', icon='שׂ'}, {'diagnostics', sources={'nvim_diagnostic'}}},
    lualine_b = { {'branch'}, {'diagnostics', sources={'nvim_diagnostic'}}},
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

-------------------
-- indent-blankline
-------------------
-- Disabled for now because the column highlighting overrides cursorline
-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#0F111A gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#16171A gui=nocombine]]
--
-- require("indent_blankline").setup {
--     char = "",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- }


---------
-- Notify
---------
vim.notify = require("notify")
