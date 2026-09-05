require("config.remote_clipboard").setup()

local options = {
	-- Line numbers
	nu = true,
	rnu = true,
	wrap = false,
	scrolloff = 10,

	-- Indentation baseline (vim-sleuth overrides per project when it detects)
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	expandtab = true,

	-- Visual
	termguicolors = true,
	signcolumn = "yes",
	completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy" },
	synmaxcol = 300,
	title = true,

	-- File handling
	swapfile = false,
	undofile = true,
	updatetime = 200,

	-- Split behavior
	splitbelow = true,
	splitright = true,
}

vim.opt.path:append("**")
vim.opt.isfname:append("@-@")

-- Don't auto-continue comments (Enter under "//" won't add another "//")
vim.opt.formatoptions:remove({ "c", "r", "o" })

for k, v in pairs(options) do
	vim.opt[k] = v
end
