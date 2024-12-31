local options = {
	guicursor = "",
	backup = false,
	writebackup = false,
	cmdheight = 1,
	completeopt = { "menu", "menuone", "noselect", "noinsert", "preview" },
	fileencoding = "utf-8",
	ignorecase = true,
	smartcase = true,
	showmode = false,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	undofile = true,
	updatetime = 100,
	expandtab = true,
	shiftwidth = 2,
	softtabstop = 2,
	tabstop = 2,
	numberwidth = 4,
	number = true,
	relativenumber = true,
	laststatus = 3,
	showcmd = false,
	ruler = false,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	colorcolumn = "80",
	fillchars = vim.opt.fillchars + "eob: ",
	spelllang = "en_gb",
	more = false,
	inccommand = "split",
	title = false,
}

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

local opt = vim.opt

opt.fillchars:append({
	stl = " ",
})

for k, v in pairs(options) do
	opt[k] = v
end
