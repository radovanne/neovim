local keymap = vim.keymap.set
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = "'"

keymap("n", "<C-i>", "<C-i>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move highlighted text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Resize neovim panes
keymap("n", "<M-,>", "<c-w>5>", opts)
keymap("n", "<M-.>", "<c-w>5<", opts)
keymap("n", "<M-t>", "<c-w>+", opts)
keymap("n", "<M-s>", "<c-w>-", opts)

-- Prevent cursor from jumping to the end of the line while appending next to previous line
keymap("n", "J", "mzJ`z", opts)

-- Keep cursor in the middle while jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Preserve copied text after pasting
keymap("x", "p", [["_dP]])

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- Easily hit escape in terminal mode.
keymap("t", "<esc><esc>", "<c-\\><c-n>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
