return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		vim.cmd([[highlight CopilotSuggestion guifg=#66CED6 ctermfg=8]])
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>cE", ":Copilot enable<CR>", { desc = "[C]opilot [e]nable" })
		keymap.set("n", "<leader>cD", ":Copilot disable<CR>", { desc = "[C]opilot [d]isable" })
		keymap.set("n", "<leader>cS", ":Copilot status<CR>", { desc = "[C]opilot [s]tatus" })
		keymap.set("n", "<leader>cR", ":Copilot restart<CR>", { desc = "[C]opilot [r]estart" })
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<Tab>",
					accept_word = false,
					accept_line = false,
					next = "<[[>",
					prev = "<]]>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 16.x
			server_opts_overrides = {},
		})
	end,
}
