-- lua/config/options.lua
-- Direct translations of settings from the old vimrc

local opt = vim.opt

-- Behavior
opt.autowrite = true          -- old: set autowrite
opt.hidden = true              -- old: set hidden
opt.timeoutlen = 500           -- old: set timeoutlen=500
opt.modeline = true            -- old: set modeline

-- UI
opt.number = true              -- old: set number
opt.ruler = true               -- old: set ruler
opt.showcmd = true              -- old: set showcmd
opt.laststatus = 2              -- old: always show statusline (lualine will render it)
opt.linespace = 3               -- old: set linespace=3 (GUI only, harmless in terminal)
opt.list = true                 -- old: set list
opt.listchars = { tab = "……", trail = "¬", eol = "¶" } -- old: set listchars
opt.showmatch = true             -- old: set showmatch
opt.mousehide = true             -- old: (no-op in terminal Neovim, kept for parity)
opt.splitbelow = true             -- old: set splitbelow

-- Indentation (defaults; filetype autocmds below override per-language,
-- exactly like the old vimrc did)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Wrapping
opt.wrap = true
opt.textwidth = 79
opt.formatoptions = "qrn1"

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Folding (old: set foldenable / foldmethod=marker as default)
opt.foldenable = true

-- Completion menu (old: wildmenu / wildmode=list:longest)
opt.wildmenu = true
opt.wildmode = "list:longest"

-- Sessions (old: sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help)
opt.sessionoptions = "resize,winpos,winsize,buffers,tabpages,folds,curdir,help"

-- Backups / swap (old: backupdir / directory under ~/.vim/tmp)
local data = vim.fn.stdpath("data")
vim.fn.mkdir(data .. "/backup", "p")
vim.fn.mkdir(data .. "/swap", "p")
opt.backup = true
opt.backupdir = data .. "/backup//"
opt.directory = data .. "/swap//"

-- Colors: badwolf still works unmodified in Neovim (pure Vimscript colorscheme)
vim.g.colors_name_pending = "badwolf" -- actually set in plugins/colorscheme.lua after it loads
