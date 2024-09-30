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
		Adds SSH host for tunneling purposes.
		`Work in progress`	
		--]]
		local function add_ssh_host_to_config()
			local ssh_config_path = vim.fn.expand("~/.ssh/config")

			local host_name = vim.fn.input("Host Name: ")
			local ec2_domain = vim.fn.input("EC2 Domain: ")
			local ec2_user = vim.fn.input("EC2 User: ")
			local key_path = vim.fn.input("Path to SSH Key: ", "", "file")
			local rds_host = vim.fn.input("RDS Host: ")
			local db_port_input = vim.fn.input("DB Port (default is 5432): ")
			local db_port = (db_port_input ~= "") and db_port_input or "5432"
			local local_port_input = vim.fn.input(string.format("Local Port (default is %d): ", tonumber(db_port) + 1))
			local local_port = (local_port_input ~= "") and local_port_input or tostring(tonumber(db_port) + 1)

			local new_host_entry = string.format(
				[[

Host %s
  HostName %s
  User %s
  IdentityFile %s
  LocalForward %s %s:%s
]],
				host_name,
				ec2_domain,
				ec2_user,
				key_path,
				local_port,
				rds_host,
				db_port
			)

			local file = io.open(ssh_config_path, "a")

			if file then
				file:write(new_host_entry)
				file:close()
				print(string.format("Successfully added host '%s' to ~/.ssh/config", host_name))
			else
				print("Failed to open ~/.ssh/config")
			end
		end

		local job = require("plenary.job")
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local conf = require("telescope.config").values

		-- work in progress function
		local function get_ssh_hosts()
			local hosts = {}
			for line in io.lines(os.getenv("HOME") .. "/.ssh/config") do
				local host = line:match("^Host%s+(.*)")
				if host then
					table.insert(hosts, host)
				end
			end
			return hosts
		end

		--[[
		Opens SSH tunnel based on provided host.
		`Work in progress`	
		--]]
		local function run_ssh_job(host)
			job:new({
				command = "ssh",
				args = { "-N", host },
				on_stdout = function(_, data)
					print("stdout:", data)
				end,
				on_stderr = function(_, data)
					print("stderr:", data)
				end,
				on_exit = function(return_val)
					if return_val == 0 then
						print("SSH connection to " .. host .. " successful!")
					else
						print("SSH connection to " .. host .. " failed with exit code", return_val)
					end
				end,
			}):start()
		end

		--[[
		"Display available hosts and run SSH tunnel when host is selected"
		`Work in progress`	
		--]]
		local function ssh_connect_via_job()
			local hosts = get_ssh_hosts()

			pickers
				.new({}, {
					prompt_title = "SSH Hosts",
					finder = finders.new_table({
						results = hosts,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()[1]

							run_ssh_job(selection)
						end)
						return true
					end,
				})
				:find()
		end

		--[[
		Prompts user for required information to make SSH tunnel and
		connects to the RDS database vid vim dadbod aka the real father
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
			{ "<leader>dr", add_ssh_host_to_config, desc = "Register SSH Host" },
			{ "<leader>dD", ssh_connect_via_job, desc = "Tunnel picker" },
		})
	end,
}

return M
