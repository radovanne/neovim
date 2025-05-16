local M = {
	"elmcgill/springboot-nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-jdtls"
	},
	config = function()
		local springboot_nvim = require("springboot-nvim")

		vim.keymap.set('n', '<localleader>Jr', springboot_nvim.boot_run, { desc = "[J]ava [R]un Spring Boot" })
		vim.keymap.set('n', '<localleader>Jc', springboot_nvim.generate_class, { desc = "[J]ava Create [C]lass" })
		vim.keymap.set('n', '<localleader>Ji', springboot_nvim.generate_interface, { desc = "[J]ava Create [I]nterface" })
		vim.keymap.set('n', '<localleader>Je', springboot_nvim.generate_enum, { desc = "[J]ava Create [E]num" })

		springboot_nvim.setup({})
	end
}
return M
