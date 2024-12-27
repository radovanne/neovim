local M = {
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
}

function M.config()
	local lspconfig = require("ned.lspconfig")
	local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb"
	local this_os = vim.loop.os_uname().sysname

	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

	vim.g.rustaceanvim = {
		tools = {
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				auto = true,
				show_parameter_hints = true,
				parameter_hints_prefix = "",
				other_hints_prefix = "",
			},
			hover_actions = {
				auto_focus = false,
			},
		},

		server = {
			on_attach = function(client, bufnr)
				lspconfig.on_attach(client, bufnr)

				vim.keymap.set("n", "<leader>ca", function()
					vim.cmd.RustLsp("codeAction")
				end, { buffer = bufnr, desc = "Code actions" })

				vim.keymap.set("n", "<leader>K", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, { buffer = bufnr, desc = "Code action groups" })
			end,

			capabilities = lspconfig.common_capabilities(),

			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
					cargo = {
						allFeatures = true,
					},
					inlayHints = {
						chainingHints = {
							bindingModeHints = {
								enable = true,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureCaptureHints = {
								enable = true,
							},
							closureReturnTypeHints = {
								enable = "always", -- "never"
							},
							closureStyle = "impl_fn",
							discriminantHints = {
								enable = "always", -- "never"
							},
							expressionAdjustmentHints = {
								hideOutsideUnsafe = false,
								mode = "prefix",
							},
							implicitDrops = {
								enable = true,
							},
							lifetimeElisionHints = {
								enable = "always", -- "never"
								useParameterNames = true,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							rangeExclusiveHints = {
								enable = true,
							},
							renderColons = {
								enable = true,
							},
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
					lens = {
						enable = true,
					},
				},
			},
		},
		-- DAP configuration
		dap = { adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path) },
	}
end

return M
