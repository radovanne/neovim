-- [[ q closes transient buffers and hides them from the buffer list ]]
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "git", "oil" },
	callback = function()
		vim.cmd [[
			nnoremap <silent> <buffer> q :close<CR>
			set nobuflisted
		]]
	end,
})

-- [[ Equalize window sizes on resize ]]
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- [[ Fixes neovim lag when CurSearch is active ]]
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd "hi! link CurSearch Search"
	end,
})

-- [[ Reload file when changed externally ]]
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd "checktime"
	end,
})

-- [[ Enable spell and wrap on certain filetypes ]]
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- [[ Terminal buffers: no line numbers, clean ]]
local set = vim.opt_local
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0
		vim.bo.filetype = "terminal"
	end,
})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Syntax highlighting for env files ]]
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})
