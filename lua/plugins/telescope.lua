vim.pack.add({
	{
		src = 'https://github.com/nvim-telescope/telescope.nvim',
		version = vim.version.range("1.*")
	},
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
})

-- Define a function to handle the build process
local function build_fzf_native()
	local fzf_native_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
	if vim.fn.isdirectory(fzf_native_path) == 1 and vim.fn.filereadable(fzf_native_path .. "/build/libfzf.so") == 0 then
		print("telescope-fzf-native.nvim is installed, running build command...")
		vim.fn.system("cd " .. fzf_native_path .. " && make")
		print("Build command finished.")
	end
end

build_fzf_native()

local base_ignore_patterns = {
	"dune.lock",
	".lsp/.cache/",
	".cache/*",
	".cpcache/*",
	".clj-kondo/*",
}

local builtin = require("telescope.builtin")
local multigrep = require("custom.multigrep")
local icons = require("config.icons")
local wk = require("which-key")

wk.add({
	{ "<leader>b",  group = "Buffers" },
	{ "<leader>bb", builtin.buffers,          desc = "Buffers" },

	{ "<leader>f",  group = "Find" },
	{ "<leader>fc", builtin.colorscheme,      desc = "Colorscheme" },
	{ "<leader>ff", builtin.find_files,       desc = "Find Files" },
	{ "<leader>fg", multigrep.live_multigrep, desc = "Live Multigrep" },
	{
		"<leader>fP",
		function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end,
		desc = "Neovim Files"
	},
	{ "<leader>fh", builtin.help_tags,                                      desc = "Help Tags" },
	{ "<leader>fl", builtin.resume,                                         desc = "Resume" },
	{ "<leader>fr", builtin.oldfiles,                                       desc = "Recent Files" },

	{ "<leader>g",  group = "Git" },
	-- { "<leader>gd", builtin.lsp_references,                                 desc = "Go to Definition" },
	{ "<leader>gf", builtin.git_files,                                      desc = "Git Files" },

	{ "<leader>s",  group = "Search" },
	{ "<leader>sp", builtin.live_grep,                                      desc = "Live Grep" },
	{ "<leader>ss", builtin.current_buffer_fuzzy_find,                      desc = "Current Buffer" },
	{ "<leader>sS",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "MF_GREP" },

	{ "<leader>w",  group = "Words" },
	{ "<leader>wg", builtin.grep_string,                                    desc = "Grep String" },
})

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

pcall(require("telescope").load_extension("fzf"))
pcall(require("telescope").load_extension("ui-select"))
