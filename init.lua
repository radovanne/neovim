require("config.core")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.disable")
spec("plugins.git.neogit")
spec("plugins.git.gitsigns")

spec("plugins.colorschemes.rose-pine")
spec("plugins.matchup")
spec("plugins.sleuth")
spec("plugins.surround")
spec("plugins.autopairs")
spec("plugins.undotree")
spec("plugins.fidget")

spec("plugins.whichkey")
spec("plugins.db")
spec("plugins.trouble")
spec("plugins.devicons")
spec("plugins.treesitter")
spec("plugins.mason")
spec("plugins.conform")
spec("plugins.oil")
spec("plugins.blink")
spec("plugins.telescope")


spec("plugins.lspconfig")
spec("plugins.lualine")
spec("plugins.harpoon")

-- Start language specific region

spec("plugins.langs.clojure.clay")
spec("plugins.langs.clojure.jack-in")
spec("plugins.langs.clojure.conjure")
spec("plugins.langs.clojure.paredit")
spec("plugins.langs.clojure.parinfer-rust")

spec("plugins.langs.rust.rustaceanvim")
spec("plugins.langs.rust.crates")

spec("plugins.langs.go.go")

-- End language specific region
spec("plugins.langs.lua.lazy_dev")

spec("plugins.nvim-dap")

require("config.lazy")
