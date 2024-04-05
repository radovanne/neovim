local M = {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup()
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
				vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
				vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
				vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
			end,
		},
		{ "theHamsta/nvim-dap-virtual-text" },
		{ "nvim-telescope/telescope-dap.nvim" }
	},
}

return M
