-- https://luals.github.io/wiki/settings/
return {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim", "spec" },
			},
			runtime = {
				version = "LuaJIT",
				special = {
					spec = "require",
				},
			},
			-- workspace = {
			-- 	checkThirdParty = false,
			-- 	library = {
			-- 		vim.fn.expand("$VIMRUNTIME/lua"),
			-- 		vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
			-- 	},
			-- },
			hint = {
				enable = false,
				arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
				await = true,
				paramName = "Disable", -- "All" | "Literal" | "Disable"
				paramType = true,
				semicolon = "All", -- "All" | "SameLine" | "Disable"
				setType = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
