local rose_pine_custom = {
	moon = {
		base = "#161616",
		surface = "#202020",
		overlay = "#2a2a2a",
		text = "#D9D1E9",
		love = "#C36E70",
	},
}

require("rose-pine").setup({
	palette = rose_pine_custom,
	styles = {
		transparency = false,
	},
})
vim.cmd.colorscheme("rose-pine-moon")
