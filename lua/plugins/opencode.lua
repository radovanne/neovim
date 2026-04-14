vim.pack.add({
	{ src = "https://github.com/nickjvandyke/opencode.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
})

local snacks_ok, snacks = pcall(require, "snacks")
if snacks_ok then
	snacks.setup({
		input = {},
		picker = {
			actions = {
				opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
					},
				},
			},
		},
	})
end

vim.o.autoread = true

vim.g.opencode_opts = {
}

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
	wk.add({ { "<leader>o", group = "Opencode", mode = { "n", "x" } } })
end

vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
	{ desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end,
	{ desc = "Execute opencode action" })
vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
	{ desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
	{ desc = "Add line to opencode", expr = true })
