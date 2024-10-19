local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
			config = function()
				local cmp = require("cmp")
				local config = cmp.get_config()
				config.sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}

				cmp.setup(config)
			end,
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1

		--[[
		Prompts user for required information to make SSH tunnel and
		connects to the RDS database with vim dadbod aka the real father
		figure.
		`work in progress function`
		--]]
		local function ssh_tunnel_and_connect()
			local user = vim.fn.input("SSH User: ")
			local domain = vim.fn.input("Domain: ")
			local key_path = vim.fn.input("Path to SSH Key: ")
			local rds_host = vim.fn.input("RDS Host: ")
			local db_name = vim.fn.input("DB Name: ")
			local db_user = vim.fn.input("DB User: ")
			local db_password = vim.fn.input("DB Password: ")
			local rds_port_input = vim.fn.input("RDS Port (default is 5432): ")
			local rds_port = (rds_port_input ~= "") and rds_port_input or "5432"
			local local_port_input = vim.fn.input(string.format("Local Port (default is %d): ", tonumber(rds_port) + 1))
			local local_port = (local_port_input ~= "") and local_port_input or tostring(tonumber(rds_port) + 1)

			local ssh_command = string.format(
				"ssh -i %s -L %s:%s:%s %s@%s -N -v",
				key_path,
				local_port,
				rds_host,
				rds_port,
				user,
				domain
			)
			local tmux_command = string.format("tmux split-window -h; tmux send-keys '%s' C-m", ssh_command)
			local success = os.execute(tmux_command)

			if success then
				print("SSH Tunnel established in a new tmux pane. You can connect to your RDS database.")
			else
				print("Failed to establish SSH Tunnel.")
			end

			local connection_url =
			string.format("postgres://%s:%s@127.0.0.1:%s/%s", db_user, db_password, local_port, db_name)
			local clipboard_command = string.format("echo '%s' | xclip -selection clipboard", connection_url)
			os.execute(clipboard_command)
		end
		local wk = require("which-key")
		wk.add({
			{ "<leader>d", group = "Dab/DBui" },
			{ "<leader>dd", "<cmd>DBUIToggle<CR>", desc = "DBUI Toggle" },
			{ "<leader>dc", ssh_tunnel_and_connect, desc = "Tunnel & Connect" },
		})
	end,
}

return M
