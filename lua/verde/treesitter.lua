local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  ---@diagnostic disable: missing-fields
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "graphql",
      "luadoc",
      "vimdoc",
      "lua",
      "vim",
      "markdown",
      "markdown_inline",
      "bash",
      "python",
      "typescript",
      "javascript",
      "clojure",
      "rust",
      "dockerfile",
      "go",
      "html",
      "json",
      "scss",
      "xml",
      "yaml",
      "css",
    },
    highlight = { enable = true },
    indent = { enable = true },
    sync_install = false,
  })
end

return M
