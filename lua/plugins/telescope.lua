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

vim.keymap.set('n', "<leader>bb", builtin.buffers)
vim.keymap.set('n', "<leader>fc", builtin.colorscheme)
vim.keymap.set('n', "<leader>ff", builtin.find_files)
vim.keymap.set('n', "<leader>gd", builtin.lsp_references)
vim.keymap.set('n', "<leader>fg", multigrep.live_multigrep)
vim.keymap.set('n', "<leader>wg", builtin.grep_string)
vim.keymap.set('n', "<leader>gf", builtin.git_files)
vim.keymap.set('n', "<leader>fP",
	function()
		builtin.find_files({
			cwd = vim.fn.stdpath("config"),
		})
	end)
vim.keymap.set('n', "<leader>sp", builtin.live_grep)
vim.keymap.set('n', "<leader>fh", builtin.help_tags)
vim.keymap.set('n', "<leader>fl", builtin.resume)
vim.keymap.set('n', "<leader>fr", builtin.oldfiles)
vim.keymap.set('n', "<leader>ss", builtin.current_buffer_fuzzy_find)

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

pcall(require("telescope").load_extension("fzf"))
pcall(require("telescope").load_extension("ui-select"))
