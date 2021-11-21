local map = vim.api.nvim_set_keymap
local defaults = { noremap = true, silent = true }

--------------
-- cutlass.vim
--------------
map("n", "m", "d", defaults)
map("x", "m", "d", defaults)
map("n", "gm", "m", defaults)

map("n", "mm", "dd", defaults)
map("n", "M", "D", defaults)

------------
-- yoink.vim
------------
vim.g.yoinkIncludeDeleteOperations = 1

-- map p and P to paste from yoink
map("n", "p", "<plug>(YoinkPaste_p)", { silent = true })
map("n", "P", "<plug>(YoinkPaste_P)", { silent = true })

-- Also replace the default gp with yoink paste so we can toggle paste in this case too
map("n", "gp", "<plug>(YoinkPaste_gp)", { silent = true })
map("n", "gP", "<plug>(YoinkPaste_gP)", { silent = true })

-- setup ctrl-p and ctrl-n to cycle through paste history like a kill ring
map("n", "<c-p>", "<plug>(YoinkPostPasteSwapBack)", { silent = true })
map("n", "<c-n>", "<plug>(YoinkPostPasteSwapForward)", { silent = true })

-- TODO: move this to general maps or leave this with copy/paste setup?
map('n', 'Y', 'y$', defaults)


-------------
-- lightpseed
-------------
--nvim_del_keymap
require'lightspeed'.setup {
  grey_out_search_area = true
}


---------------
-- Comment.nvim
---------------
require('Comment').setup()

-- set the comment string for .txt to "# "
local ft = require('Comment.ft')
ft.text = '# %s'

--------------
-- vim-argwrap
--------------
map("n", "<leader>a", ":ArgWrap<cr>", defaults)

-------
-- yabs
-------
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

map("n", "<Leader>y", "<cmd>Telescope yabs tasks<cr>", defaults)


----------------
-- vim-wordmotion
----------------
vim.g.wordmotion_prefix = "<leader>"

-- override the default 'b' mapping to avoid conflicting
-- with <leader>b to open buffer search
vim.cmd([[let g:wordmotion_mappings = { 'b': '<M-b>' }]])


-----------
-- vim-bbye
-----------
-- alias Bdelete to Bclose
vim.cmd([[command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>]])

-- map 'bc' to 'Bc' for ease of typing
vim.cmd([[cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bc'):('bc'))]])


-----------
-- gitsigns
-----------
require('gitsigns').setup()


-------------
-- Treesitter
-------------
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

------------
-- Telescope
------------
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
  pickers = {
    live_grep = {
      additional_args = function(opts)
        if opts.search_all == true then
          return {}
        end
        local args_for_ext = {
          ["rs"]     = "-trust",
          ["lua"]    = "-tlua",
          ["python"] = "-tpy",
          ["elm"]    = "-telm"
        }
        if args_for_ext[vim.bo.filetype] ~= nil then
            return { args_for_ext[vim.bo.filetype] }
        else
            return { "-t" .. vim.bo.filetype }
        end
      end
    }
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
    }
  }
}

require('telescope').load_extension('fzf')

-- map("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", defaults)
map("n", "<leader>gs", "<<cmd>Telescope grep_string<cr>", defaults)
map("n", "<leader>/", "<cmd>lua require('telescope.builtin').live_grep({search_all = true})<cr>", defaults)
map("n", "<leader>t", "<cmd>lua require('telescope.builtin').live_grep()<cr>", defaults)
map("n", "<leader>ts", "<cmd>Telescope treesitter<cr>", defaults)
map("n", "<Leader>f", "<cmd>Telescope find_files<cr>", defaults)
map("n", "<Leader>b", "<cmd>Telescope buffers<cr>", defaults)
map("n", "<Leader>q", "<cmd>Telescope quickfix<cr>", defaults)

------------
-- nvim-tree
------------
vim.g.nvim_tree_gitignore = 1

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = true,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = false,
    auto_open = false,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

map("n", "<c-g>", ":NvimTreeToggle<CR>", defaults)


-----------
-- nvim-cmp
-----------
vim.o.completeopt = 'menu,menuone,noselect'

local lspkind = require'lspkind'
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end
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
        { name = "buffer", keyword_length = 4 },
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
        { name = 'cmdline',  keyword_length = 2 }
    })
})


------
-- LSP
------
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

  -- TODO expand beyond elmls
  if server.name == 'elmls' then
      opts['capabilities'] = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  end

  if server.name == "sumneko_lua" then
      opts.cmd = { "/Users/kremlan/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/macOS/lua-language-server" }
      opts.settings = {
          Lua = {
              diagnostics = {
                  globals = { 'vim' }
              }
          }
      }
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

-- null-ls
local null_ls = require("null-ls")
null_ls.config({
    -- debug = true,
    sources = {
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.hadolint
    },
})

require("lspconfig")["null-ls"].setup({
    on_attach = on_attach
})


-----------------
-- Language Packs
-----------------

