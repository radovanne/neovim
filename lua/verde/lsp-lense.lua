local M = {
'VidocqH/lsp-lens.nvim',
  lazy = true
}

function M.confug()
  require("lsp-lens").setup()
end

return M
