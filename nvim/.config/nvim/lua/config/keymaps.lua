---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- -- -- -- -- -- -- -- -- -- -- -- -- Keymaps -- -- -- -- -- -- -- -- -- -- -- -- -- --
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Modes --
--------------------------------------------------------------------------------------
-- Modes :
-- -- "n": normal mode
-- -- "v": visual mode
-- -- "x": visula_block mode
-- -- "i": insert mode
-- -- "t": terminal mode
-- -- "c": command mode
--------------------------------------------------------------------------------------
-- init --
--------------------------------------------------------------------------------------
local opts_1 = { noremap = true, silent = true }
local opts_2 = { noremap = false, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap
local keyset = vim.keymap.set

--------------------------------------------------------------------------------------
-- Leader --
--------------------------------------------------------------------------------------
keymap("", "<Space>", "<Nop>", opts_1)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------------
-- Changing behaviour --
--------------------------------------------------------------------------------------
-- deleting without yanking
keymap("n", "D", '"_d', opts_1)
keymap("v", "D", '"_d', opts_1)

-------------------------------------------------------------------------------------
-- Line navigation --
--------------------------------------------------------------------------------------
-- navigate to the beginning of the line
keymap("n", "1", "0", opts_1)
keymap("n", "0", "$", opts_1)

keymap("v", "1", "0", opts_1)

-- word/WORD, previous/next navigation in normal mode
keymap("n", "q", "b", opts_1)
keymap("n", "Q", "B", opts_1)

keymap("n", "f", "e", opts_1)
keymap("n", "F", "E", opts_1)

keymap("n", "e", "w", opts_1)
keymap("n", "E", "W", opts_1)

-- delete word/WORD, previous/next
keymap("n", "dq", "db", opts_1)
keymap("n", "dQ", "dB", opts_1)
keymap("n", "df", "dw", opts_1)
keymap("n", "dF", "dW", opts_1)

-- macros
keymap("n", "w", "q", opts_1)
keymap("n", "W", "Q", opts_1)

keymap("v", "w", "q", opts_1)
keymap("v", "W", "Q", opts_1)

-- navigate to the beginning of the line
keymap("v", "1", "0", opts_1)
keymap("v", "0", "$", opts_1)

-- word/WORD, previous/next navigation in visual mode
keymap("v", "q", "b", opts_1)
keymap("v", "Q", "B", opts_1)

keymap("v", "f", "e", opts_1)
keymap("v", "F", "E", opts_1)

keymap("v", "e", "w", opts_1)
keymap("v", "E", "W", opts_1)

--------------------------------------------------------------------------------------
-- State --
--------------------------------------------------------------------------------------
-- save on click
keymap("n", "<leader>s", ":w<cr>", opts_1)
keymap("i", "<C-s>", "<esc>:w<cr>", opts_1)

-- Redo
keymap("n", "U", "<C-r>", opts_2)

-- press fast to exit insert mode
keymap("i", "<C-o>", "<esc>", opts_2)
keymap("v", "<C-o>", "<esc>", opts_2)
keymap("c", "<C-o>", "<esc>", opts_2)

--------------------------------------------------------------------------------------
-- Text Related --
--------------------------------------------------------------------------------------
-- work navigation in other modes
keymap("i", "<A-j>", "<esc>:m .+1<cr>==gi", opts_1)
keymap("i", "<A-k>", "<esc>:m .-2<cr>==gi", opts_1)

keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts_1)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts_1)

-- move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts_1)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts_1)

keymap("v", "<K>", ":m .-2<cr>==", opts_1)
keymap("v", "<J>", ":m .+1<cr>==", opts_1)
keymap("v", "<K>", ":m '<-2<CR>gv=gv", opts_1)
keymap("v", "<J>", ":m '>+1<CR>gv=gv", opts_1)

-- select all content
keymap("n", "<C-a>", "ggVG", opts_1)

-- stay in indent mode
keymap("v", "<", "<gv", opts_1) -- Right Indentation
keymap("v", ">", ">gv", opts_1) -- Left Indentation

--------------------------------------------------------------------------------------
-- Neotree --
--------------------------------------------------------------------------------------
-- -- this is an old try -- --
-- vim.g.startup_dir = vim.fn.getcwd()
-- vim.keymap.set("n", "<A-e>", function()
--   local startup_dir = vim.g.startup_dir or vim.fn.getcwd()
--   local current_file = vim.fn.expand("%:p")
--
--   vim.cmd("Neotree float reveal=true dir=" .. startup_dir .. " reveal_file=" .. current_file)
-- end, opts_1)
--

-- opening neotree on the "perfect" parent of the current file
function isFile(full_path)
	if vim.fn.isdirectory(full_path) == 0 then
		return vim.fn.fnamemodify(full_path, ":h")
	end
	return full_path
end

Neotree_is_open = false
vim.keymap.set("n", "<leader>f", function()
	if Neotree_is_open then
		vim.cmd("Neotree close")
	else
		-- local cwd = vim.fn.argv()[1]
		-- local fullPath = vim.fn.expand(cwd)
		local fullPath = vim.fn.getcwd()
		local path = isFile(fullPath)
		local current_file = vim.fn.expand("%:p")

		vim.cmd("Neotree float reveal=true dir=" .. path .. " reveal_file=" .. current_file)
	end
	Neotree_is_open = not Neotree_is_open
end, opts_1)

--------------------------------------------------------------------------------------
-- Buffers --
--------------------------------------------------------------------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts_2) -- left window
keymap("n", "<C-j>", "<C-w>k", opts_2) -- up window
keymap("n", "<C-k>", "<C-w>j", opts_2) -- down window
keymap("n", "<C-l>", "<C-w>l", opts_2) -- right window

-- Resize with arrows when using multiple windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts_1)
keymap("n", "<c-down>", ":resize +2<cr>", opts_1)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts_1)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts_1)

-- Buffer Navigation
vim.keymap.set(
	"n",
	"<leader>g",
	":Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<CR>",
	opts_1
)

keymap("n", "<leader>r", ":bnext<cr>", opts_1) -- Next Tab
keymap("n", "<leader>e", ":bprevious<cr>", opts_1) -- Previous tab
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts", "*.html" },
	command = "lua vim.lsp.buf.format()",
})

--------------------------------------------------------------------------------------
-- Windows --
--------------------------------------------------------------------------------------
-- Window navigation
keymap("n", "zu", ":vs<CR>", opts_1)
keymap("n", "zy", ":split<CR>", opts_1)
keymap("n", "zq", ":close<CR>", opts_1)
keymap("n", "zl", ":wincmd l<CR>", opts_1)
keymap("n", "zh", ":wincmd h<CR>", opts_1)
keymap("n", "zk", ":wincmd k<CR>", opts_1)
keymap("n", "zj", ":wincmd j<CR>", opts_1)

-- window navigation in insert mode
keymap("i", "<C-l>", "<esc><C-l>", opts_1)
keymap("i", "<C-h>", "<esc><C-h>", opts_1)
keymap("i", "<C-k>", "<esc><C-k>", opts_1)
keymap("i", "<C-j>", "<esc><C-j>", opts_1)

--------------------------------------------------------------------------------------
-- Terminal --
--------------------------------------------------------------------------------------
-- leaving terminal insert mode
-- keymap("t", "<esc>", "<C-\\><C-N> :ToggleTerm float<CR>", opts_1)

-- insert mode to normal mode in toggleterm
keymap("t", "<esc>", "<C-\\><C-N>", opts_1)

-- nvim .local/share/nvim/lazy/toggleterm.nvim/lua/toggleterm/config.lua
-- go to the path above and change the default toggleterm direction from horizontal to float
keymap("n", "<leader>t", ":ToggleTerm float<CR>", opts_1)
-- keymap("t", "<leader>t", "<C-\\><C-N> :ToggleTerm float<CR>", opts_1)

--Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--------------------------------------------------------------------------------------
-- Telescope --
--------------------------------------------------------------------------------------
local builtin = require("telescope.builtin")
keyset("n", "<leader>k", builtin.diagnostics, { desc = "Telescope find files" })
-- keyset("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
-- keyset("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
-- keyset("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
keyset("n", "<leader>d", builtin.lsp_definitions, { desc = "definition" })
keyset("n", "<leader>dd", builtin.lsp_implementations, { desc = "implementation" })

--------------------------------------------------------------------------------------
-- Fold --
--------------------------------------------------------------------------------------
keyset("n", "aa", "zf%", opts_1)

--------------------------------------------------------------------------------------
