vim.pack.add({
  {src= "https://github.com/nvim-lua/plenary.nvim"},
  {src= "https://github.com/BurntSushi/ripgrep"},
  {src= "https://github.com/nvim-telescope/telescope-fzy-native.nvim"},
  {src= "https://github.com/nvim-telescope/telescope-ui-select.nvim"},
  {src= "https://github.com/nvim-telescope/telescope.nvim",
  version= "0.1.8"},
})

local base_ignore_patterns = {
	"dune.lock",
	".lsp/.cache/",
	".cache/*",
	".cpcache/*",
	".clj-kondo/*",
}

local wk = require("which-key")
local builtin = require("telescope.builtin")

local multigrep = require("custom.multigrep")

wk.add({
	{ "<leader>bb", builtin.buffers, desc = "Active buffers" },
	{ "<leader>fb", builtin.git_branches, desc = "Checkout branch" },
	{ "<leader>fc", builtin.colorscheme, desc = "Colorscheme" },
	{ "<leader>ff", builtin.find_files, desc = "Find files" },
	{ "<leader>gd", builtin.lsp_references, desc = "Telescope Find References" },
	{ "<leader>fg", multigrep.live_multigrep, desc = "Files Grep" },
	{ "<leader>wg", builtin.grep_string, desc = "Word Grep" },
	{ "<leader>gf", builtin.git_files, desc = "Find git files" },
	{
		"<leader>en",
		function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end,
		desc = "Edit Neovim",
	},
	{ "<leader>sp", builtin.live_grep, desc = "Find Text" },
	{ "<leader>fh", builtin.help_tags, desc = "Help" },
	{ "<leader>fl", builtin.resume, desc = "Last Search" },
	{ "<leader>fr", builtin.oldfiles, desc = "Recent File" },
	{ "<leader>ss", builtin.current_buffer_fuzzy_find, desc = "Fuzzily search in current buffer" },
})

local icons = require("config.icons")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		entry_prefix = "   ",
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = icons.ui.Forward .. " ",
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
			n = {
				["<esc>"] = actions.close,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
			},
		},
	},
	preview = false,
	pickers = {
		find_files = {
			theme = "ivy",
			file_ignore_patterns = base_ignore_patterns,
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
		current_buffer_fuzzy_find = {
			theme = "ivy",
		},
		buffers = {
			theme = "ivy",
			initial_mode = "normal",
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
		colorscheme = {
			enable_preview = true,
		},
	},
	extensions = {
		wrap_results = true,
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
pcall(require('telescope').load_extension('fzy_native'))
pcall(require("telescope").load_extension("ui-select"))
