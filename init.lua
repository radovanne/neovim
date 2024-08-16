require("verde.core")
require("verde.options")
require("verde.keymaps")
require("verde.autocmds")

-- Git specific plugins
spec("verde.git.neogit")
spec("verde.git.gitsigns")
spec("verde.git.gitlinker")

-- Colorsheme specific plugins
spec("verde.colorscheme.darkplus")
spec("verde.colorscheme.catppuccin")
spec("verde.colorscheme.github")

spec("verde.whichkey")
spec("verde.devicons")
spec("verde.treesitter")
spec("verde.mason")
spec("verde.lspconfig")
spec("verde.none-ls")
spec("verde.cmp")
spec("verde.lualine")
spec("verde.harpoon")
spec("verde.autopairs")
spec("verde.illuminate")
spec("verde.telescope")
spec("verde.alpha")
spec("verde.sleuth")
spec("verde.surround")
spec("verde.comment")

-- Clojure specific plugins
spec("verde.clojure.jack-in")
spec("verde.clojure.conjure")
spec("verde.clojure.paredit")

-- Rust specific plugins
spec("verde.rust.rustaceanvim")
spec("verde.rust.crates")

-- Go specific plugins
spec("verde.go.go")

-- Debug specific plugin
spec("verde.nvim-dap")

-- Less important plugins
spec("verde.colorizer")
spec("verde.undotree") -- cool plugin but do I use it? or maybe I should start
spec("verde.bqf") -- TEST if I need this
spec("verde.nvimtree")
spec("verde.toggleterm")
spec("verde.oil")
spec("verde.fidget")
require("verde.lazy")
