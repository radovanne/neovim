local M = { 'echasnovski/mini.nvim', version = '*' }

M.config = function()
	require('mini.surround').setup()
end

return M
