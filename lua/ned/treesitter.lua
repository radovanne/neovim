local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  ---@diagnostic disable: missing-fields
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua",
      "luadoc",
      "vim",
      "vimdoc",
      "graphql",
      "markdown",
      "markdown_inline",
      "bash",
      "dockerfile",
      "html",
      "json",
      "scss",
      "xml",
      "yaml",
      "css",
      "sql",
      "c",
      "odin",
      "go",
      "ocaml",
      "python",
      "typescript",
      "javascript",
      "clojure",
      "rust",
    },
    highlight = { enable = true },
    indent = { enable = true },
    sync_install = false,
  })
end

return M
