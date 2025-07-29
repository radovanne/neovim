vim.pack.add({
  {src= "https://github.com/nvim-lualine/lualine.nvim"},
  {src= "https://github.com/nvim-tree/nvim-web-devicons"},
})

require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		ignore_focus = { "NvimTree" },
	},
	sections = {
		lualine_a = {},
		lualine_b = { "branch" },
		lualine_c = { "diagnostics", { "filename", path = 1 } },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = {},
	},
	extensions = { "quickfix", "man", "fugitive" },
})

vim.cmd("hi statusline guibg=Turquoise")
