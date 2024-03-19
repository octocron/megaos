-- set variable scope
-- INFO: (g) global (b) buffer (w) current window (t) tabpage
-- (v) predefined variables (env) environment variables
local g = vim.g

-- INFO: vim.o behaves like :set vim.go behaves like :setglobal
local o = vim.o

-- INFO: vim.opt sets global and local options (behaves like :set)
local opt = vim.opt

-- add 24bit color
o.termguicolors = true

-- display a confirm when closing unsaved
o.confirm = true

-- disable codeium tab
g.codeium_no_map_tab = true

-- decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- number of lines to keep surrounding cursor
o.scrolloff = 8

-- line column settings
o.number = true
o.numberwidth = 6
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
--o.colorcolumn = "80"

-- tabbing and indenting
o.expandtab = true
o.smarttab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.cindent = true
o.autoindent = true

-- folding
o.nofoldenable = true
o.foldlevelstart = 99
o.foldmethod = "indent"
o.foldnestmax = 3
o.foldcolumn = "1"

-- wrapper
o.wrap = true
o.textwidth = 300

-- decorators
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- better completion experience
opt.completeopt = { "menuone", "noselect" }

-- add access to system clipboard
o.clipboard = "unnamed,unnamedplus"

-- case insensitive searching UNLESS /C or capital in search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- remember 50 items in commandline history
o.history = 50

-- create undo history file to perisist data
o.undofile = true

-- better buffer splitting
o.splitright = true
o.splitbelow = true

opt.mouse = "a"

-- map <leader> to space
g.mapleader = " "
g.maplocalleader = " "
