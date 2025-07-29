-- require("config.core")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.disable")
require("plugins.sleuth")
require("plugins.whichkey")
require("plugins.git.neogit")
require("plugins.git.gitsigns")
require("plugins.oil")
require("plugins.fidget")
require("plugins.undotree")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.lualine")
require("plugins.lsp")

require("plugins.langs.clojure")
--
-- -- spec("plugins.colorschemes.rose-pine")
-- require("plugins.treesitter")
-- require("plugins.matchup")
-- spec("plugins.surround")
-- spec("plugins.autopairs")
--
-- spec("plugins.db")
-- spec("plugins.trouble")
-- spec("plugins.devicons")
-- spec("plugins.mason")
-- spec("plugins.conform")
-- spec("plugins.cmp")
--
--
-- -- Start language specific region
--
-- spec("plugins.langs.clojure.jack-in")
-- spec("plugins.langs.clojure.conjure")
-- spec("plugins.langs.clojure.paredit")
-- -- spec("plugins.langs.clojure.parinfer-rust")
--
-- -- End language specific region
-- spec("plugins.langs.lua.lazy_dev")
--
-- -- spec("plugins.nvim-dap")
--
-- require("config.lazy")
