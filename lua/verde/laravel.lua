return {
  "adalessa/laravel.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvimtools/none-ls.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<localleader>la", ":Laravel artisan<cr>" },
    { "<localleader>lr", ":Laravel routes<cr>" },
    { "<localleader>lm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  config = true,
}
