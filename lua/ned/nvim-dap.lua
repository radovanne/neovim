local M = {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require "dap"
			local ui = require "dapui"

			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup {
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			}

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "/home/ned/.local/share/nvim/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			local codelldb_configuration_c =  {
				{
					name = 'Launch',
					type = 'codelldb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.c = codelldb_configuration_c

			local wk = require("which-key")

			wk.add({
				{  "<leader>du", ui.toggle, desc= "toggle DapUI"},
				{  "<leader>dr", dap.run, desc="dap run"},
				{  "<leader>dt", dap.toggle_breakpoint, desc="toggle breakpoint"},
				{  "<leader>d<F1>", dap.continue, desc="Continue"},
				{  "<leader>d<F2>", dap.step_into, desc="Step Into"},
				{  "<leader>d<F3>", dap.step_over, desc="Step over"},
				{  "<leader>d<F4>", dap.step_out, desc="Step out"},
				{  "<leader>d<F5>", dap.step_back, desc="Step Back"},
				{  "<leader>d<F6>", dap.terminate, desc="Terminate"},
				{  "<leader>d<F13>", dap.restart, desc="Restart"},
				{ "<leader>d<space>?", function()
					require("dapui").eval(nil, { enter = true })
				end, desc="Eval var under cursor" }
			})


			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}

return M
