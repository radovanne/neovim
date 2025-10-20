vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
	{ src = 'https://github.com/williamboman/mason.nvim' },
	{ src = 'https://github.com/saghen/blink.cmp' },
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function()
    vim.cmd "checktime"
  end,
})

local servers = {
	"lua_ls",
	"ts_ls",
	"pyright",
	"sqls",
	"bashls",
	"jsonls",
	"clojure_lsp",
	"yamlls",
	'dockerls',
	'docker_compose_language_service',
	-- 'nextls'
	'elixirls' -- Will be installed by elixir tools
}


require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

vim.lsp.config['docker_ls'] = {
	cmd = { 'docker-language-server' },
	filetypes = { 'Dockerfile', 'dockerfile', 'compose.yaml', 'compose.yml', 'bake.json', 'bake.hcl' },
	root_markers = { 'Dockerfile', 'dockerfile', 'compose.yaml', 'compose.yml', 'bake.json', 'bake.hcl' },
}

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'require'
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable({
	'clojure_lsp',
	'lua_ls',
	'pyright',
	'ts_ls',
	"sqls",
	'docker_ls',
	'docker_compose_language_service',
	'yamlls',
	"jsonls",
	"bashls",
	"elixirls"

})
local capabilities = {
	textDocument = {
		semanticTokens = {
			multilineTokenSupport = true,
		}
	},
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('*', {
	capabilities,
	root_markers = { '.git' },
})

local icons = require("config.icons")

local diagnostic_config = {
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
			{ name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
			{ name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
			{ name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
		},
	},
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_lines = false,
	float = {
		focusable = true,
		style = "minimal",
		source = "always",
		header = "",
		prefix = "",
		max_width = 80,
	},
}

vim.diagnostic.config(diagnostic_config)
