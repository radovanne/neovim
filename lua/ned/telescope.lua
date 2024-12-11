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
		"dune.lock",
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
	local builtin = require("telescope.builtin")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local make_entry = require("telescope.make_entry")

	local live_multigrep = function (opts)
		opts = opts or {}
		opts.cwd = opts.cwd or vim.uv.cwd()

		local finder = finders.new_async_job {
			command_generator = function (prompt)
				if not prompt or prompt == "" then
					return nil
				end

				local pieces = vim.split(prompt, "  ")
				local args = { "rg" }

				if pieces[1] then
					table.insert(args, "-e")
					table.insert(args, pieces[1])
				end

				if pieces[2] then
					table.insert(args, "-g")
					table.insert(args, pieces[2])
				end

---@diagnostic disable-next-line: deprecated
				return vim.tbl_flatten {
					args,
					{ "--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case"}
				}
			end,

			entry_maker = make_entry.gen_from_vimgrep(opts),
			cwd = opts.cwd

		}
		pickers.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty()
		}):find()
	end

	wk.add({
		{ "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find" },
		{ "<leader>fb", builtin.git_branches, desc = "Checkout branch" },
		{ "<leader>fc", builtin.colorscheme, desc = "Colorscheme" },
		{ "<leader>ff", builtin.find_files, desc = "Find files" },
		{ "<leader>fg", live_multigrep, desc = "Files Grep" },
		{ "<leader>gf", builtin.git_files, desc = "Find git files" },
		{ "<leader>en", function ()
			builtin.find_files {
				cwd = vim.fn.stdpath("config")
			}
		end, desc = "Edit Neovim" },
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
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
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
		previewer = false,
		theme = "ivy",
		pickers = {
			current_buffer_fuzzy_find = {
				previewer = true,
			},
			find_files = {
				file_ignore_patterns = base_ignore_patterns,
				hidden = true,
				find_command = { "rg", "--files", "--glob", "!**/.git/*" },
			},
			buffers = {
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
			lsp_references = {
				initial_mode = "normal",
				enable_preview = true,
			},
			lsp_definitions = {
				initial_mode = "normal",
			},
			lsp_declarations = {
				initial_mode = "normal",
			},
			lsp_implementations = {
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
		},
	})

	require("telescope").load_extension("project")
	require('telescope').load_extension('fzf')
end

return M
