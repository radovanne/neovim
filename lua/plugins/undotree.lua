vim.pack.add({ { src = 'https://github.com/mbbill/undotree' } })

local wk = require("which-key")
local icons = require("config.icons")
wk.add({ { "<leader>u", vim.cmd.UndotreeToggle, icon = icons.misc.Watch, desc = "Undotree", mode = "n" } })
