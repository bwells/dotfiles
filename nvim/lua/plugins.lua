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
-- require'lightspeed'.setup {}

------------
-- leap.nvim
------------
require('leap').add_default_mappings()
require('flit').setup()

---------------
-- Comment.nvim
---------------
require('Comment').setup()

-- set the comment string for .txt to "# "
local ft = require('Comment.ft')
ft.text = '# %s'


-- Optional setup for overriding defaults.
require("sort").setup({
  -- Input configuration here.
  -- Refer to the configuration section below for options.
})

-- map("n", "go", "<Cmd>Sort<CR>", defaults)
map("v", "go", "<Esc><Cmd>Sort<CR>", defaults)
map("n", "go", ":sort", defaults)
map("v", "go", ":sort", defaults)

-- vim.cmd([[
--   nnoremap <silent> go <Cmd>Sort<CR>
--   vnoremap <silent> go <Esc><Cmd>Sort<CR>
-- ]])

------------
-- Pear Tree
------------
vim.g.pear_tree_smart_openers = 1
vim.g.pear_tree_smart_closers = 1
vim.g.pear_tree_smart_backspace =1


-----------------
-- nvim-autopairs
-----------------
require('nvim-autopairs').setup{}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '', elm = '' } }))


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
                    command = "cd elm; find src/Entry -name '*.elm' | xargs elm make --output ../portal/public/scripts/elm.js --debug",
                    output = "terminal",
                }
            }
        }
    }
}

map("n", "<Leader>y", "<cmd>Telescope yabs tasks<cr>", defaults)

-----------
-- nvim-bqf
-----------
-- require('bqf').setup({
--   magic_window = false
-- })


----------------
-- vim-wordmotion
----------------
vim.g.wordmotion_prefix = "<leader>"

-- override the default 'b' mapping to avoid conflicting
-- with <leader>b to open buffer search
vim.cmd([[let g:wordmotion_mappings = { 'b': '<M-b>' }]])


--------------
-- targets.vim
--------------
vim.cmd([[
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'a': {},
    \ })
]])


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
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}


-------------
-- Treesitter
-------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", or a list of languages
  ignore_install = { "phpdoc" },
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
        ["atc"] = "@conditional.outer",
        ["itc"] = "@conditional.inner",
        ["atb"] = "@block.outer",
        ["itb"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

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
      -- TODO: reenable, but explore if this is causing problems with normal df functionality
      -- peek_definition_code = {
      --   ["df"] = "@function.outer",
      --   ["dF"] = "@class.outer",
      -- },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
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


---------------------
-- Treesitter Context
---------------------
require'treesitter-context'.setup{
    enable = false -- disabled by default
}

map("n", "<Leader>c", "<cmd>TSContextToggle<cr>", defaults)

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
map("n", "<leader>gs", "<cmd>Telescope grep_string<cr>", defaults)
map("n", "<leader>/", "<cmd>lua require('telescope.builtin').live_grep({search_all = true})<cr>", defaults)
map("n", "<leader>t", "<cmd>lua require('telescope.builtin').live_grep()<cr>", defaults)
map("n", "<leader>ts", "<cmd>Telescope treesitter<cr>", defaults)
map("n", "<Leader>f", "<cmd>Telescope find_files<cr>", defaults)
map("n", "<Leader>b", "<cmd>Telescope buffers<cr>", defaults)
map("n", "<Leader>q", "<cmd>Telescope quickfix<cr>", defaults)
map("n", "<Leader>r", "<cmd>Telescope resume<cr>", defaults)


-- TODO: map for git_bcommit - commit history of current buffer

------------
-- nvim-tree
------------
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = true,
  update_cwd          = false,
  git = {
    ignore = true
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
    hide_root_folder = false,
    side = 'left',
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

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

-- require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- enable debug verbosity
-- vim.lsp.set_log_level("debug")

local lsp_default_options = { on_attach = on_attach }

lspconfig.cssls.setup(lsp_default_options)
lspconfig.dockerls.setup(lsp_default_options)

-- lspconfig.elmls.setup({
--   on_attach = on_attach,
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- })

lspconfig.elmls.setup(lsp_default_options)
lspconfig.eslint.setup(lsp_default_options)
lspconfig.html.setup(lsp_default_options)
lspconfig.jsonls.setup(lsp_default_options)
lspconfig.sqls.setup(lsp_default_options)
lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})
lspconfig.vimls.setup(lsp_default_options)
lspconfig.yamlls.setup(lsp_default_options)

lspconfig.pyright.setup {
  on_attach = on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end
  }
}

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
null_ls.setup({
    -- debug = true,
    sources = {
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.gitsigns,
    },
})


-- require("lspconfig")["null-ls"].setup({
--     on_attach = on_attach
-- })


----------
-- Harpoon
----------
map('n', '<leader>hm', '<cmd>lua require("harpoon.mark").add_file(); print("Added Mark")<cr>', { noremap = true})
map('n', '<leader>hh', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', defaults)
map('n', '<leader>hj', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', defaults)
map('n', '<leader>hk', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', defaults)
map('n', '<leader>hl', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', defaults)

map('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', defaults)

require("telescope").load_extension('harpoon')

--------
-- neorg
--------
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          home = "~/notes/home",
        }
      }
    },
    ["core.norg.concealer"] = { },
    ["core.gtd.base"] = {}
  }
}


-----------------
-- Language Packs
-----------------


--
-- vim.cmd([[
-- nnoremap <silent> <Plug>SortMotion :<C-U>set opfunc=sort_motion#sort_motion<CR>g@
-- xnoremap <silent> <Plug>SortMotionVisual :<C-U>call sort_motion#sort_motion(visualmode())<CR>
-- nnoremap <silent> <Plug>SortLines :<C-U>call sort_motion#sort_lines()<CR>
--
-- nmap gs <Plug>SortMotion
-- xmap gs <Plug>SortMotionVisual
-- nmap gss <Plug>SortLines
-- ]])
