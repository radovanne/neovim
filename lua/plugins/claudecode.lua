vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/coder/claudecode.nvim" }
})

local ok_claude, claudecode = pcall(require, "claudecode")
local ok_wk, wk = pcall(require, "which-key")

if ok_claude then
    claudecode.setup({})
end

if ok_wk then
    wk.add({
        { "<leader>a", group = "AI/Claude Code" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",  desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add current buffer" },

        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },

        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       desc = "Send to Claude", mode = "v" },
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        callback = function()
            wk.add({
                { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file", buffer = true },
            })
        end,
    })
end

