vim.pack.add({ {
	src = "https://github.com/ThePrimeagen/harpoon",
	version = "harpoon2",
},
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
	}
})

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set('n', "<leader>ha", function()
	harpoon:list():add()
end)
vim.keymap.set('n', "<leader>he", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i = 1, 8, 1 do
	vim.keymap.set('n', '<leader>h' .. i, function()
		harpoon:list():select(i)
	end)
end
