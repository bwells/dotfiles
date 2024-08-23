-- load basic vim config
require('opts')

-- load custom vim specific keymaps
require('maps')

-- disable showing the builtin mode indicator
vim.o.showmode = false

vim.o.completeopt = 'menu,menuone,noselect'

-- Set some wordmotion global options before import
-- so that they're read in in the correct order
vim.g.wordmotion_prefix = "<leader>"
-- override the default 'b' mapping to avoid conflicting
-- with <leader>b to open buffer search
vim.cmd([[let g:wordmotion_mappings = { 'b': '<M-b>' }]])

-- vim.cmd([[colorscheme lunaperche]])

-- vim.cmd([[set background=dark]])
-- vim.o.background = 'dark'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local map = vim.api.nvim_set_keymap
local defaults = { noremap = true, silent = true }

require("lazy").setup({
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.material_style = "deep ocean"
      local material = require("material")
      material.setup {
        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = false },
          strings = { italic = false },
          keywords = { italic = false },
          functions = { italic = false },
          variables = { italic = false },
          operators = { italic = false },
          types = {},
        },

        contrast = {
          terminal = false,           -- Enable contrast for the built-in terminal
          sidebars = true,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = true,    -- Enable contrast for floating windows
          cursor_line = false,        -- Enable darker background for the cursor line
          lsp_virtual_text = true,    -- Enable contrasted background for lsp virtual text
          non_current_windows = true, -- Enable darker background for non-current windows
          filetypes = {},             -- Specify which filetypes get the contrasted (darker) background
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "coc",
          -- "colorful-winsep",
          -- "dap",
          -- "dashboard",
          -- "eyeliner",
          -- "fidget",
          -- "flash",
          "gitsigns",
          "harpoon",
          -- "hop",
          -- "illuminate",
          -- "indent-blankline",
          -- "lspsaga",
          -- "mini",
          -- "neogit",
          -- "neotest",
          -- "neo-tree",
          -- "neorg",
          -- "noice",
          "nvim-cmp",
          -- "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          -- "rainbow-delimiters",
          -- "sneak",
          "telescope",
          "trouble",
          -- "which-key",
          "nvim-notify",
        },

        disable = {
          colored_cursor = true, -- Disable the colored cursor
          borders = false,       -- Disable borders between verticaly split windows
          background = false,    -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,   -- Prevent the theme from setting terminal colors
          eob_lines = false      -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false   -- Enable higher contrast text for darker style
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil,       -- If you want to override the default colors, set this to a function

        custom_highlights = {},    -- Overwrite highlights with your own

        -- custom_highlights = {
        --   -- CursorLine = { fg = material.none, bg = '#1B1D25' },
        --   -- Selection = { fg = material.none, bg = '#8E97C4' }
        -- }
      }
      -- vim.cmd([[colorscheme material]])
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { "jim-at-jibba/ariake.nvim" },

  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- vim.o.background = 'dark'
  --     require('tokyonight').setup({
  --       style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  --       light_style = "night",
  --     })
  --     -- vim.o.background = 'dark'
  --     vim.cmd([[colorscheme tokyonight-night]])
  --   end
  -- },

  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   config = function ()
  --     require('rose-pine').setup({
  --       styles = {
  --           bold = true,
  --           italic = false,
  --           transparency = false,
  --       }
  --     })
  --   end
  -- },

  'tpope/vim-repeat',

  -- more sanity to yanking
  -- {
  --   'svermeulen/vim-cutlass',
  --   lazy = false,
  --   keys = {
  --     -- { "m", "d", defaults },
  --     -- { "x", "m", "d", defaults },
  --     -- { "gm", "m", default },
  --     -- { "mm", "dd", defaults },
  --     -- { "M", "D", defaults }
  --   },
  --   config = function ()
  --     map("n", "m", "d", defaults)
  --     map("x", "m", "d", defaults)
  --     map("n", "gm", "m", defaults)
  --
  --     map("n", "mm", "dd", defaults)
  --     map("n", "M", "D", defaults)
  --   end
  -- },
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    opts = {
      cut_key = 'm'
    },
    keys = {
      { "gm", "m", defaults },
    }
  },
  {
    'svermeulen/vim-yoink',
    lazy = false,
    config = function()
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
    end
  },

  -- sneak like motions, smarter s/S and f/F
  {
    'ggandor/leap.nvim',
    priority = 999,
    dependencies = {
      {
        'ggandor/flit.nvim',
        config = function()
          require('flit').setup({
            multiline = false
          })
        end
      }
    },
    config = function()
      require('leap').add_default_mappings()
      -- require('leap').setup({
      --   max_aot_targets = nil
      -- })
      vim.cmd([[xunmap x]])
      vim.cmd([[xunmap X]])
    end
  },

  -- add motions for word hunks in camel or underscore case
  {
    'chaoren/vim-wordmotion',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { "w", mode = "n" },
      -- { "b", mode = "n" },
      { "W", mode = "n" },
      { "B", mode = "n" },
      { "w", mode = "o" },
      { "W", mode = "o" },
    },
    config = function()
      -- vim.g.wordmotion_prefix = "<leader>"
      -- override the default 'b' mapping to avoid conflicting
      -- with <leader>b to open buffer search
      -- vim.cmd([[let g:wordmotion_mappings = { 'b': '<M-b>' }]])
    end
  },

  -- lots of targets
  -- separators, args, etc
  {
    'wellle/targets.vim',
    config = function()
      vim.cmd([[
      autocmd User targets#mappings#user call targets#mappings#extend({
          \ 'a': {},
          \ })
      ]])
    end
  },

  -- motions/text objects for surrounding selections with chars
  { 'tpope/vim-surround' },

  -- hacked in sort motions
  {
    'sQVe/sort.nvim',
    keys = {
      { "gsp", "vip<Esc><Cmd>Sort<CR>", defaults },
      { "gs$", "v$<Esc><Cmd>Sort<CR>",  defaults }
    }
  },

  -- gcc to toggle comment current line
  -- gc to toggle comment selected line(s)
  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = {
      { 'gc' },
      { "gc", mode = "x" },
    },
    config = function()
      require('Comment').setup()

      -- set the comment string for .txt to "# "
      local ft = require('Comment.ft')
      ft.text = '# %s'
    end
  },

  -- {
  --   'windwp/nvim-autopairs',
  --   lazy = true,
  --   event = {'BufReadPre', 'BufNewFile'},
  --   config = function ()
  --     require('nvim-autopairs').setup({})
  --
  --     -- TODO: fix after cmp is installed
  --     -- If you want insert `(` after select function or method item
  --     local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  --     local cmp = require('cmp')
  --     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '', elm = '' } }))
  --   end
  -- },

  -- {
  --   'echasnovski/mini.pairs',
  --   version = false,
  --   config = function ()
  --     require('mini.pairs').setup()
  --   end
  -- },

  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {
      cmap = false
    },
  },

  -- {
  --   "chrisgrieser/nvim-puppeteer",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   lazy = false, -- plugin lazy-loads itself
  -- },

  { -- TODO: fix lazy loading to actually load this ever
    'tpope/vim-abolish',
    lazy = true,
    cmd = 'Subvert'
  },

  -- <leader>a converts arg lists inline<>multiline
  {
    'FooSoft/vim-argwrap',
    lazy = true,
    keys = {
      { "<leader>a", ":ArgWrap<cr>", defaults }
    }
  },

  -- better bdelete
  -- :bc to close a buffer without also closing the split
  {
    'moll/vim-bbye',
    -- lazy = true,
    -- keys = {
    --   { ":bc", ":bc"  }
    -- },
    config = function()
      -- alias Bdelete to Bclose
      vim.cmd([[command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>]])

      -- map 'bc' to 'Bc' for ease of typing
      vim.cmd([[cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bc'):('bc'))]])
    end
  },

  'asiryk/auto-hlsearch.nvim',

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {},
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
      require('telescope').load_extension('ghn')
    end,
    keys = {
      { "<leader>gs", "<cmd>Telescope grep_string<cr>",                                           defaults },
      { "<leader>/",  "<cmd>lua require('telescope.builtin').live_grep({search_all = true})<cr>", defaults },
      { "<leader>t",  "<cmd>lua require('telescope.builtin').live_grep()<cr>",                    defaults },
      { "<leader>ts", "<cmd>Telescope treesitter<cr>",                                            defaults },
      { "<leader>f",  "<cmd>Telescope find_files<cr>",                                            defaults },
      { "<Leader>b",  "<cmd>Telescope buffers<cr>",                                               defaults },
      { "<Leader>q",  "<cmd>Telescope quickfix<cr>",                                              defaults },
      { "<Leader>r",  "<cmd>Telescope resume<cr>",                                                defaults },
      { "<Leader>gn", "<cmd>Telescope ghn<cr>",                                                   defaults }
    }
  },

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'material'
        },
        sections = {
          lualine_a = { 'mode' },
          -- branch, changes, diagnostics and all the rest is too wide for a 100 col split
          -- lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp'}}},
          -- lualine_b = { {'branch', icon='שׂ'}, {'diagnostics', sources={'nvim_diagnostic'}}},
          lualine_b = { { 'branch' }, require('github-notifications').statusline_notification_count, { 'diagnostics', sources = { 'nvim_diagnostic' } } },
          lualine_c = { 'filename' },
          lualine_x = { 'filetype', 'fileformat', 'encoding' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        -- winbar = {
        --   lualine_b = { require('github-notifications').statusline_notification_count },
        -- },
        extensions = { 'quickfix', 'nvim-tree' }
      }
    end
  },

  -- git changes in the number column
  -- also provides hs to stage changes and ]c,[c to navigate to changes
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function local_map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          local_map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          local_map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          local_map('n', '<leader>hs', gs.stage_hunk)
          local_map('n', '<leader>hr', gs.reset_hunk)
          local_map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          local_map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          local_map('n', '<leader>hS', gs.stage_buffer)
          local_map('n', '<leader>hu', gs.undo_stage_hunk)
          local_map('n', '<leader>hR', gs.reset_buffer)
          local_map('n', '<leader>hp', gs.preview_hunk)
          local_map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          local_map('n', '<leader>tb', gs.toggle_current_line_blame)
          local_map('n', '<leader>hd', gs.diffthis)
          local_map('n', '<leader>hD', function() gs.diffthis('~') end)
          local_map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          local_map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },

  {
    'FabijanZulj/blame.nvim',
    lazy = true,
    cmd = 'BlameToggle',
    keys = {
      { '<leader>gb', ':BlameToggle virtual<cr>', defaults }
    },
    config = function()
      require("blame").setup({
        date_format = "%d.%m.%Y",
        mappings = {
          commit_info = "i",
          stack_push = "<TAB>",
          stack_pop = "<BS>",
          show_commit = "<CR>",
          close = { "<esc>", "q" },
        }
      })
    end
  },

  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = 'LazyGit'
  },

  {
    'rlch/github-notifications.nvim',
    -- config = [[require('config.github-notifications')]],
    config = function()
      require('github-notifications').setup {}
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
  },

  {
    'Almo7aya/openingh.nvim',
    lazy = true,
    keys = {
      { mode = 'n', '<leader>gh', ":OpenInGHFile <CR>",      defaults },
      { mode = 'v', '<leader>gh', ":'<,'>OpenInGHFile <CR>", defaults }
    }
  },

  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
    keys = {
      { "<c-g>", "<Cmd>NvimTreeToggle<CR>", defaults }
    },
    config = function()
      require('nvim-tree').setup {
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_tab         = false,
        hijack_cursor       = true,
        update_cwd          = false,
        git                 = {
          ignore = true
        },
        diagnostics         = {
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
        system_open         = {
          cmd  = nil,
          args = {}
        },
        filters             = {
          dotfiles = false,
          custom = {}
        },
        view                = {
          width = 30,
          side = 'left',
          -- mappings = {
          --   custom_only = false,
          --   list = {}
          -- }
        }
      }
    end
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    lazy = true,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { mode = "n", "-", "<cmd>Oil<cr>", defaults }
    },
    config = function()
      require("oil").setup()
    end
  },

  'asiryk/auto-hlsearch.nvim',

  -- 'christianrondeau/vim-base64',

  {
    "taybart/b64.nvim",
    lazy = true,
    keys = {
      { mode = "x", "<leader>aa", "<cmd>lua require('b64').encode()<cr>", defaults },
      { mode = "x", "<leader>bb", "<cmd>lua require('b64').decode()<cr>", defaults },
    },
  },

  -- TOOD: see if this can be lazy and triggered on quickfix open
  { 'kevinhwang91/nvim-bqf' },
  {
    'romainl/vim-qf',
    config = function()
      -- local opts = { buffer = true, noremap = true, silent = true }
      -- vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.cmd([[
        augroup custom_qf_mapping
        autocmd!
        autocmd FileType qf nnoremap <buffer> dd :.Reject<CR>
        autocmd FileType qf xnoremap <buffer> d :'<,'>Reject<CR>
        autocmd FileType qf nnoremap <buffer> gk :.Keep<CR>
        autocmd FileType qf xnoremap <buffer> gk :'<,'>Keep<CR>
      ]])
    end
  },

  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- cookbook
        -- require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
        -- require('grug-far').grug_far({ prefills = { flags = vim.fn.expand("%") } })
      });
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },

  -- {
  --   'hrsh7th/nvim-cmp',
  --   lazy = true,
  --   event = 'InsertEnter',
  --   dependencies = {
  --     { 'hrsh7th/vim-vsnip' },
  --     { 'hrsh7th/cmp-vsnip' },
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'hrsh7th/cmp-buffer' },
  --     { 'hrsh7th/cmp-path' },
  --     { 'hrsh7th/cmp-cmdline' },
  --   },
  --   config = function()
  --     require('lsp-zero.cmp').extend()
  --
  --     local cmp = require('cmp')
  --     -- local cmp_action = require('lsp-zero.cmp').action()
  --     local lspkind = require('lspkind')
  --
  --     local has_words_before = function()
  --       if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  --     end
  --
  --     cmp.setup({
  --       mapping = {
  --         ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --           if cmp.visible() and has_words_before() then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --           else
  --             fallback()
  --           end
  --         end),
  --       },
  --     })
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --         end
  --       },
  --
  --       mapping = {
  --         ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --         ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  --         ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  --         ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  --         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  --         ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  --         ['<C-e>'] = cmp.mapping({
  --           i = cmp.mapping.abort(),
  --           c = cmp.mapping.close(),
  --         }),
  --         ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --         ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --           if cmp.visible() and has_words_before() then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --           else
  --             fallback()
  --           end
  --         end)
  --       },
  --
  --       sources = cmp.config.sources({
  --         -- { name = "copilot", group_index = 2 },
  --         { name = 'nvim_lsp' },
  --         -- { name = "copilot" },
  --         { name = "supermaven" },
  --         { name = 'vsnip' },
  --         { name = "buffer",    keyword_length = 4 },
  --       }),
  --
  --       -- ganked from tj's settings
  --       formatting = {
  --         format = lspkind.cmp_format {
  --           with_text = true,
  --           menu = {
  --             -- copilot = "",
  --             copilot = "[gh]",
  --             Supermaven = "",
  --             buffer = "[buf]",
  --             nvim_lsp = "[LSP]",
  --             nvim_lua = "[api]",
  --             path = "[path]",
  --             luasnip = "[snip]",
  --             gh_issues = "[issues]",
  --           }
  --         },
  --       },
  --
  --       experimental = {
  --         -- I like the new menu better! Nice work hrsh7th
  --         native_menu = false,
  --
  --         -- Let's play with this for a day or two
  --         ghost_text = true,
  --       },
  --
  --       sorting = {
  --         priority_weight = 2,
  --         comparators = {
  --           -- require("copilot_cmp.comparators").prioritize,
  --
  --           -- Below is the default comparitor list and order for nvim-cmp
  --           cmp.config.compare.offset,
  --           -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  --           cmp.config.compare.exact,
  --           cmp.config.compare.score,
  --           cmp.config.compare.recently_used,
  --           cmp.config.compare.locality,
  --           cmp.config.compare.kind,
  --           cmp.config.compare.sort_text,
  --           cmp.config.compare.length,
  --           cmp.config.compare.order,
  --         }
  --       }
  --
  --     })
  --
  --     -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline('/', {
  --       sources = {
  --         { name = 'buffer' }
  --       }
  --     })
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline(':', {
  --       sources = cmp.config.sources({
  --         { name = 'path' }
  --       }, {
  --         { name = 'cmdline', keyword_length = 2 }
  --       })
  --     })
  --   end
  --
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = {
  --     "zbirenbaum/copilot.lua",
  --     cmd = "Copilot",
  --     event = "InsertEnter",
  --     config = function()
  --       require("copilot").setup({
  --         suggestion = { enabled = false },
  --         panel = { enabled = false },
  --       })
  --     end,
  --   },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-f>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { },
        color = {
          suggestion_color = "#ffffff",
          cterm = 244,
        },
        log_level = "info",                  -- set to "off" to disable logging completely
        disable_inline_completion = false,   -- disables inline completion for use with cmp
        disable_keymaps = false              -- disables built in keymaps for more manual control
      })
    end,
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       openai_params = {
  --         model = "gpt-4",
  --       },
  --       openai_edit_params = {
  --         model = "gpt-4",
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },

  {
    "frankroeder/parrot.nvim",
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require("parrot").setup {
        providers = {
          -- pplx = {
          --   api_key = os.getenv "PERPLEXITY_API_KEY",
          --   -- OPTIONAL
          --   -- gpg command
          --   -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/pplx_api_key.txt.gpg"  },
          --   -- macOS security tool
          --   -- api_key = { "/usr/bin/security", "find-generic-password", "-s pplx-api-key", "-w" },
          -- },
          openai = {
            api_key = os.getenv "OPENAI_API_KEY",
          },
          anthropic = {
            api_key = os.getenv "ANTHROPIC_API_KEY",
          },
        },
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    lazy = true,
    -- ft = {
    --   "css",
    --   "dockerfile",
    --   "elm",
    --   "html",
    --   "javascript",
    --   "json",
    --   "lua",
    --   "python",
    --   "sql",
    --   "vim",
    --   "yaml"
    -- },
    cmd = { 'LspInfo', 'Mason' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- { 'hrsh7th/cmp-nvim-lsp' },
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        config = function()
          require("mason").setup()
        end
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require("mason-lspconfig").setup()
        end
      },
      { 'onsails/lspkind-nvim' },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- local on_attach = function(_, bufnr)
      --   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      --   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      --
      --   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
      --
      --   -- Mappings.
      --   local opts = { noremap=true, silent=true }
      --   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      --   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      --   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      --   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      --   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      --   buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      --   buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      --   buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      --   buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      --   buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      --   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      -- end

      -- enable debug verbosity
      -- vim.lsp.set_log_level("debug")

      -- local lsp_default_options = { on_attach = on_attach }

      -- lspconfig.cssls.setup(lsp_default_options)
      -- lspconfig.dockerls.setup(lsp_default_options)

      -- lspconfig.elmls.setup({
      --   on_attach = on_attach,
      --   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- })

      -- lspconfig.elmls.setup(lsp_default_options)
      -- lspconfig.eslint.setup(lsp_default_options)
      -- lspconfig.html.setup(lsp_default_options)
      -- lspconfig.jsonls.setup(lsp_default_options)
      -- lspconfig.sqlls.setup(lsp_default_options)

      -- lspconfig.lua_ls.setup({
      --   on_attach = on_attach,
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         globals = { 'vim' }
      --       }
      --     }
      --   }
      -- })

      -- lspconfig.vimls.setup(lsp_default_options)

      -- lspconfig.yamlls.setup({
      --   on_attach = on_attach,
      --   settings = {
      --     yaml = {
      --       keyOrdering = false
      --     }
      --   }
      -- })

      -- lspconfig.pyright.setup {
      --   on_attach = on_attach,
      --   handlers = {
      --     ["textDocument/publishDiagnostics"] = function() end
      --   }
      -- }

      -- lspconfig.ruff_lsp.setup {
      --   on_attach = on_attach,
      -- }

      local lsp = require('lsp-zero')

      lsp.on_attach(function(_, _)
        -- lsp.default_keymaps({buffer = bufnr})

        -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.keymap.set('n', '<space>q', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end)

      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      -- Disable the key ordering errors in YAML
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            keyOrdering = false
          }
        }
      })

      -- disable diagnostics coming from pyright
      -- it's just too much until sqlalchemy is updated with annotations
      lspconfig.pyright.setup {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end
        }
      }

      --
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          signs = {
            min = vim.diagnostic.severity.HINT,
          },
          virtual_text = {
            min = vim.diagnostic.severity.WARN,
          },
          underline = {
            min = vim.diagnostic.severity.ERROR,
          },
        }
      )

      lsp.setup()
    end
  },

  -- null-lsp
  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   lazy = true,
  --   ft = { "python", "javascript" },
  --   config = function ()
  --     local null_ls = require("null-ls")
  --     null_ls.setup({
  --         -- debug = true,
  --         sources = {
  --             null_ls.builtins.diagnostics.pylint,
  --             -- null_ls.builtins.diagnostics.flake8,
  --             null_ls.builtins.diagnostics.hadolint,
  --             -- null_ls.builtins.diagnostics.eslint,
  --             -- null_ls.builtins.code_actions.gitsigns,
  --         },
  --     })
  --   end
  -- },

  {
    'mfussenegger/nvim-lint',
    lazy = true,
    -- ft = { "python", "dockerfile", "javascript" },
    ft = { "dockerfile", "javascript" },
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint', },
        javascript = { 'eslint_d', },
        -- python = { 'pylint', },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end
      })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    event = { 'BufReadPre' },
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/playground' },
      {
        'romgrk/nvim-treesitter-context',
        lazy = false,
        keys = {
          { "<leader>c", "<cmd>TSContextToggle<cr>", defaults },
        },
        config = function()
          require 'treesitter-context'.setup {
            enable = false -- disabled by default
          }
        end
      },
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
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
            updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
    end
  },

  -- {
  --   'mhartington/formatter.nvim',
  --   lazy = true,
  --   ft = 'python',
  --   config = function ()
  --     local util = require "formatter.util"
  --
  --     require('formatter').setup({
  --       filetype = {
  --         python = {
  --           -- require("formatter.filetypes.python").isort,
  --           -- require("formatter.filetypes.python").black,
  --           -- require("formatter.filetypes.python").yapf,
  --           -- require("formatter.filetypes.python").autopep8,
  --           function()
  --             return {
  --               exe = "usort",
  --               args = {
  --                 "format",
  --                 util.escape_path(util.get_current_buffer_file_path()),
  --                 -- "-",
  --               },
  --               -- stdin = true,
  --             }
  --           end
  --         }
  --       }
  --     })
  --   end
  -- },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble"
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- keys = {
    --   {
    --     -- Customize or remove this keymap to your liking
    --     "<leader>f",
    --     function()
    --       require("conform").format({ async = true, lsp_fallback = true })
    --     end,
    --     mode = "",
    --     desc = "Format buffer",
    --   },
    -- },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        -- lua = { "stylua" },
        -- python = { "ruff_format", },
        -- python = function(bufnr)
        --   if require("conform").get_formatter_info("ruff_format", bufnr).available then
        --     return { "ruff_format" }
        --     -- else
        --     --   return { "isort", "blue" }
        --   end
        -- end,
        -- javascript = { { "prettierd", "prettier" } },
      },
      -- Set up format-on-save
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        -- shfmt = {
        --   prepend_args = { "-i", "2" },
        -- },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  { 'rcarriga/nvim-notify' },

  -- needed for correct indentation on new lines
  { 'hynek/vim-python-pep8-indent', ft = "python" },
  { 'sychen52/gF-python-traceback', ft = "python" }, -- or terminal?
  { 'Zaptic/elm-vim',               ft = "elm" },
  { 'sophacles/vim-bundle-mako',    ft = "mako" },
  { 'Glench/Vim-Jinja2-Syntax',     ft = { "jinja.html", "html" }, lazy = true },

  {
    "Zeioth/compiler.nvim",
    lazy = true,
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    keys = {
      { "<leader>m", "<cmd>CompilerOpen<cr>", defaults },
    },
    opts = {
      auto_close = true,
    },
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    lazy = true,
    -- commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },

}, {})

-- vim.cmd([[
-- augroup LazyVimColorHack
--   autocmd!
--   autocmd VeryLazy * :colorscheme material
-- augroup END
-- ]])

vim.cmd([[colorscheme material]])
-- vim.cmd([[colorscheme ariake]])

-- vim.cmd([[colorscheme tokyonight-storm]])
-- vim.cmd([[colorscheme tokyonight-moon]])
