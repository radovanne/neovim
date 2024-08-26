local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()

	local harpoon = require("harpoon")
	harpoon:setup()

	-- basic telescope configuration
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

	wk.add({
		{
			"<leader>hE",
			function()
				toggle_telescope(harpoon:list())
			end,
			desc = "Open harpoon window",
		},
		{
			"<leader>ha",
			function()
				harpoon:list():add()
			end,
			desc = "Add to list",
		},
		{
			"<leader>he",
			function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon quick menu",
		},
		{
			"<leader>hh",
			function()
				harpoon:list():select(1)
			end,
			desc = "Harpoon select 1",
		},
		{
			"<leader>hj",
			function()
				harpoon:list():select(2)
			end,
			desc = "Harpoon select 2",
		},
		{
			"<leader>hk",
			function()
				harpoon:list():select(3)
			end,
			desc = "Harpoon select 3",
		},
		{
			"<leader>hl",
			function()
				harpoon:list():select(4)
			end,
			desc = "Harpoon select 4",
		}})
end

return M
