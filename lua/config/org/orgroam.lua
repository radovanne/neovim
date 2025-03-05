require("org-roam").setup({
	directory = "~/Documents/org",
})

require("config.org.orgmode")

require("org-bullets").setup()
require("render-markdown").setup({})

local blink = require("blink.cmp.config")

local opts = {
	sources = {
		per_filetype = {
			org = { "orgmode", "markdown", "lsp", "buffer", "path", "snippets"},
		},
		providers = {
			orgmode = {
				name = "Orgmode",
				module = "orgmode.org.autocompletion.blink",
				fallbacks = { "buffer" },
			},
			markdown = {
				name = "RenderMarkdown",
				module = "render-markdown.integ.blink",
				fallbacks = { "lsp" },
			},
		},
	},
}

local telescope = require("telescope")
telescope.load_extension("orgmode")

local wk = require("which-key")
wk.add({
	{ "<leader>n", group = "Orgmode" },
	{ "<leader>o", group = "Orgmode" },
	{ "<leader>r", telescope.extensions.orgmode.refile_heading, desc = "refile heading" },
	{ "<leader>sh", telescope.extensions.orgmode.search_headings, desc = "search headings" },
	{ "<leader>il", telescope.extensions.orgmode.insert_link, desc = "insert link" },
})

blink.merge_with(opts)
