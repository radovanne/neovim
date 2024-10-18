local M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
		{ "nvim-telescope/telescope-project.nvim", lazy = true },
	},
}

function M.config()
	local base_ignore_patterns = {
		"nuts/*",
		"node%_modules/*",
		"external_data/*",
		"classes/*",
		"index_files/*",
		".idea/*",
		"app/Domain/Smartloader/assets/libs/*",
		"storage/*",
		".lsp/.cache/",
		".cache/*",
		".cpcache/*",
		".clj-kondo/*",
		"_ide_helper.php",
		".phpstorm.meta.php",
		"public/js/*",
		"public/css/*",
		"public/libs/*",
		"public/vendor/*",
		"public/assets/*",
	}

	local wk = require("which-key")

	require("telescope").load_extension("project")
	local builtin = require("telescope.builtin")

	wk.add({
		{ "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find" },
		{ "<leader>fb", builtin.git_branches, desc = "Checkout branch" },
		{ "<leader>fc", builtin.colorscheme, desc = "Colorscheme" },
		{ "<leader>ff", builtin.find_files, desc = "Find files" },
		{ "<leader>gf", builtin.git_files, desc = "Find git files" },
		{
			"<leader>pp",
			"<cmd>lua require('telescope').extensions.project.project{ display_type='full' }<cr>",
			desc = "Projects",
		},
		{ "<leader>ps", builtin.live_grep, desc = "Find Text" },
		{ "<leader>fh", builtin.help_tags, desc = "Help" },
		{ "<leader>fl", builtin.resume, desc = "Last Search" },
		{ "<leader>fr", builtin.oldfiles, desc = "Recent File" },
		{ "<leader>ss", builtin.current_buffer_fuzzy_find, desc = "Fuzzily search in current buffer" },
	})

	local icons = require("ned.icons")
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			file_ignore_patterns = base_ignore_patterns,
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
			},

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = {
					["<esc>"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			git_files = {
				theme = "ivy",
				previewer = false,
			},
			oldfiles = {
				theme = "ivy",
			},
			current_buffer_fuzzy_find = {
				theme = "ivy",
				previewer = true,
			},
			live_grep = {
				theme = "ivy",
			},

			grep_string = {
				theme = "ivy",
			},

			find_files = {
				theme = "ivy",
				previewer = false,
				hidden = true,
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			},

			buffers = {
				theme = "ivy",
				previewer = false,
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

			planets = {
				show_pluto = true,
				show_moon = true,
			},

			colorscheme = {
				theme = "ivy",
				enable_preview = true,
			},

			lsp_references = {
				theme = "ivy",
				initial_mode = "normal",
				enable_preview = true,
			},

			lsp_definitions = {
				theme = "ivy",
				initial_mode = "normal",
			},

			lsp_declarations = {
				theme = "ivy",
				initial_mode = "normal",
			},

			lsp_implementations = {
				theme = "ivy",
				initial_mode = "normal",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
			-- theme = "ivy"
		},
	})
end

return M
