local M = {
  "ThePrimeagen/harpoon",
  event = { "BufReadPre", "BufNewFile" },
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}

function M.config()
  -- set keymaps
  local keymap = vim.keymap -- for conciseness

  local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end)
keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end)
keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end)
keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

  -- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
--     local file_paths = {}
--     for _, item in ipairs(harpoon_files.items) do
--         table.insert(file_paths, item.value)
--     end
--
--     require("telescope.pickers").new({}, {
--         prompt_title = "Harpoon",
--         finder = require("telescope.finders").new_table({
--             results = file_paths,
--         }),
--         previewer = conf.file_previewer({}),
--         sorter = conf.generic_sorter({}),
--     }):find()
-- end

-- keymap.set("n", "<leader>hE", function() toggle_telescope(harpoon:list()) end,
--     { desc = "Open harpoon window" })
--
end

return M
