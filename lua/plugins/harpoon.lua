vim.pack.add({ {
	src = "https://github.com/ThePrimeagen/harpoon",
	version = "harpoon2",
},
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
	}
})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

local wk = require("which-key")
local harpoon = require("harpoon")
harpoon:setup()

wk.add({
	{ "<leader>h",  group = "Harpoon" },
	{ "<leader>hE", function() toggle_telescope(harpoon:list()) end,             desc = "Open harpoon window", },
	{ "<leader>ha", function() harpoon:list():add() end,                         desc = "Add file" },
	{ "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle menu" },
	{ "<leader>h1", function() harpoon:list():select(1) end,                     desc = "Harpoon file 1" },
	{ "<leader>h2", function() harpoon:list():select(2) end,                     desc = "Harpoon file 2" },
	{ "<leader>h3", function() harpoon:list():select(3) end,                     desc = "Harpoon file 3" },
	{ "<leader>h4", function() harpoon:list():select(4) end,                     desc = "Harpoon file 4" },
	{ "<leader>h5", function() harpoon:list():select(5) end,                     desc = "Harpoon file 5" },
	{ "<leader>h6", function() harpoon:list():select(6) end,                     desc = "Harpoon file 6" },
	{ "<leader>h7", function() harpoon:list():select(7) end,                     desc = "Harpoon file 7" },
	{ "<leader>h8", function() harpoon:list():select(8) end,                     desc = "Harpoon file 8" },
})
