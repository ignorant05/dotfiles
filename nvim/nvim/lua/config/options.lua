local wo = vim.wo
local opt = vim.opt
local o = vim.o

wo.number = true -- Make line numbers default
wo.signcolumn = "yes" -- Keep signcolumn on by default

opt.termguicolors = true -- set termguicolors to enable highlight groups
opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
opt.iskeyword:append("-") -- hyphenated words recognized by searches
opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

o.background = dark
o.hlsearch = false -- Set highlight on search
o.mouse = "a" -- Enable mouse mode
o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
o.breakindent = true -- Enable break indent
o.undofile = true -- Save undo history
o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
o.smartcase = true -- smart case
o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
o.backup = false -- creates a backup file
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
o.wrap = false -- display lines as one long line
o.linebreak = true -- companion to wrap don't split words
o.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
o.relativenumber = true -- set relative numbered lines
o.numberwidth = 4 -- set number column width to 2 {default 4}
o.shiftwidth = 3 -- the number of spaces inserted for each indentation
o.tabstop = 4 -- insert n spaces for a tab
o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
o.expandtab = false -- convert tabs to spaces
o.cursorline = false -- highlight the current line
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = false -- creates a swapfile
o.smartindent = true -- make indenting smarter again
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 2 -- always show tabs
o.backspace = "indent,eol,start" -- allow backspace on
o.pumheight = 10 -- pop up menu height
o.conceallevel = 0 -- so that `` is visible in markdown files
o.fileencoding = "utf-8" -- the encoding written to a file
o.cmdheight = 2 -- more space in the neovim command line for displaying messages
o.autoindent = true -- copy indent from current line when starting new one
