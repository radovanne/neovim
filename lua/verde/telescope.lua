local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
                   {"nvim-telescope/telescope-project.nvim", lazy = true}
  },
}

function M.config()
  require("telescope").load_extension("project")
  local wk = require "which-key"
  local builtin = require("telescope.builtin")
  wk.register {
    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    ["<leader>fb"] = { builtin.git_branches, "Checkout branch" },
    ["<leader>fc"] = { builtin.colorscheme, "Colorscheme" },
    ["<leader>ff"] = { builtin.find_files, "Find files" },
    ["<leader>gf"] = { builtin.git_files, "Find git files" },
    ["<leader>pp"] = { "<cmd>lua require('telescope').extensions.project.project()<cr>", "Projects" },
    ["<leader>ps"] = { builtin.live_grep, "Find Text" },
    ["<leader>fh"] = { builtin.help_tags, "Help" },
    ["<leader>fl"] = { builtin.resume, "Last Search" },
    ["<leader>fr"] = { builtin.oldfiles, "Recent File" },
    ["<leader>ss"] = { builtin.current_buffer_fuzzy_find, "Fuzzily search in current buffer"}
  }

  local icons = require "verde.icons"
  local actions = require "telescope.actions"


  require("telescope").setup {
    defaults = {
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
        "--glob=!.git/",
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
    },
  }
end

return M
