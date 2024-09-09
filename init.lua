require("ned.core")
require("ned.options")
require("ned.keymaps")
require("ned.autocmds")

-- Git specific plugins
spec("ned.git.neogit")
spec("ned.git.gitsigns")
spec("ned.git.gitlinker")

-- Colorsheme specific plugins
-- spec("ned.colorscheme.darkplus")
-- spec("ned.colorscheme.catppuccin")
-- spec("ned.colorscheme.github")
spec("ned.colorscheme.rose-pine")
-- spec("ned.colorscheme.doom-one")

spec("ned.whichkey")
spec("ned.devicons")
spec("ned.treesitter")
spec("ned.mason")
spec("ned.lspconfig")
spec("ned.none-ls")
spec("ned.cmp")
spec("ned.lualine")
spec("ned.harpoon")
spec("ned.autopairs")
spec("ned.matchup")
spec("ned.illuminate")
spec("ned.telescope")
-- spec("ned.alpha") -- commented out because I am not using it.
spec("ned.sleuth")
spec("ned.surround")
spec("ned.comment")
spec("ned.undotree")

-- Clojure specific plugins
spec("ned.clojure.jack-in")
spec("ned.clojure.conjure")
spec("ned.clojure.parpar")

-- Rust specific plugins
spec("ned.rust.rustaceanvim")
spec("ned.rust.crates")

-- Go specific plugins
spec("ned.go.go")

-- Debug specific plugin
spec("ned.nvim-dap")

-- Less important plugins
spec("ned.colorizer")
-- spec("ned.bqf") -- commented out, TODO check how to use this 
spec("ned.nvimtree")
-- spec("ned.toggleterm") -- commented out because I am not using it.
spec("ned.oil")
spec("ned.fidget")
require("ned.lazy")
