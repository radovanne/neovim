vim.pack.add({
  {src= "https://github.com/mbbill/undotree"},
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>u", vim.cmd.UndotreeToggle, opts)
