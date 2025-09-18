-- set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- set clipboard to system clipboard
vim.o.clipboard = 'unnamed'

-- enable gui colors from the last 50 years
if vim.fn.has('termguicolors') then
  vim.o.termguicolors = true
end

-- turn on line numbers
vim.o.number = true

-- turn on relative line numbers
vim.o.relativenumber = true

-- vim.o.ruler at 81 chars
vim.o.colorcolumn = "81,101"

vim.o.signcolumn = "yes"

-- highlight the line the cursor is on
vim.o.cursorline = true

-- correctly increment "p-2" rather than decrement
vim.o.nrformats = "bin,hex,blank"

-- only enable cursorline in the active buffer
vim.cmd([[
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
]])

-- enable lazyredraw to not slaughter performance
vim.o.lazyredraw = true

-- open new splits to the right or below
-- like a non sociopath
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.scrolloff = 3

-- allows you to have multiple buffers open
vim.o.hidden = true

-- lines of code will not wrap to the next line
vim.o.wrap = false

-- highlight matching braces/tags
vim.o.showmatch = true

-- ignore case when searching
-- ... unless there's a capital letter in the query
vim.o.ignorecase = true
vim.o.smartcase = true

-- indent to correct locatin with tab
vim.o.smarttab = true

-- highlight search matches
vim.o.hlsearch = true

-- search while you enter they query, not after
vim.o.incsearch = true

-- let vim vim.o.the title of the terminal window
vim.o.title = true

--
vim.o.timeoutlen = 500

-- wildignore
vim.opt.wildignore = {
  '*.pyc',
  '__pycache__',
  '*/.git/*'
}

-- vim.opt.wildignore = "__pycache__"
-- vim.opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }


-- use ripgrep for grep
if vim.fn.executable('rg') then
  vim.o.grepprg = "rg --vimgrep"
end

-- trims trailing whitespace
vim.cmd([[
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
]])

-- remove trailing whitespace on save
vim.cmd([[
augroup trim_whitespace
    autocmd!
    " trims whitespace and restores cursor position
    autocmd BufWritePre * call TrimTrailingWhitespace()
augroup END
]])

-- highlight yanked text
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=350}
augroup END
]])

-- setup python_host_progs
local python_host_prog = vim.env['HOME'] .. '/environments/nvim_python/bin/python'
if vim.fn.filereadable(python_host_prog) then
  vim.g.python_host_prog = python_host_prog
end

local python3_host_prog = vim.env['HOME'] .. '/environments/nvim_python3/bin/python'
if vim.fn.filereadable(python3_host_prog) then
  vim.g.python3_host_prog = python3_host_prog
end


----------------
-- Annoying Shit
----------------

-- because fuck vim turds are annoying
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- disable fucking folding
vim.cmd([[
augroup fuck_folding
    autocmd!
    autocmd BufAdd * set nofoldenable
augroup END
]])
