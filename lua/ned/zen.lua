local M =  {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                plugins = {
                    gitsigns = { enabled = true },
                    -- This doesn't work?
                    -- tmux = { enabled = false }, -- disables the tmux statusline
                    -- alacritty = {
                    --     enabled = false,
                    --     font = "15", -- font size
                    -- },
                },
                window = {
                    width = 110,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
        end)
    end
}

return M
