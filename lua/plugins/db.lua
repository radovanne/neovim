vim.pack.add({
	{ src = "https://github.com/kndndrj/nvim-dbee" },
	{
		src = "https://github.com/MattiasMTS/cmp-dbee",
		version = "ms/v2"
	},
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
})

local function find_dbee_path()
	local data_dir = vim.fn.stdpath("data") .. "/site/pack"
	local dirs = vim.fn.glob(data_dir .. "/*/opt/nvim-dbee", true, true)
	if #dirs > 0 then
		return dirs[1]
	end
	return nil
end

local function build_dbee()
	local dbee_path = find_dbee_path()
	if not dbee_path then
		print("nvim-dbee not found; skipping build.")
		return
	end

	local bin_path = vim.fn.stdpath("data") .. "/dbee/bin/dbee"
	if vim.fn.filereadable(bin_path) == 1 then
		-- already installed
		return
	end

	print("Installing nvim-dbee...")
	vim.cmd("packadd nvim-dbee")
	local ok, dbee = pcall(require, "dbee")
	if ok then
		dbee.install()
		print("✅ nvim-dbee installed successfully.")
	else
		print("❌ Failed to require nvim-dbee for build.")
	end
end

build_dbee()

local ok, dbee = pcall(require, "dbee")
if ok then
	dbee.setup({})
end

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
	wk.add({
		{ "<leader>d",  group = "Database" },
		{ "<leader>do", function() require("dbee").open() end,   desc = "Open DB UI" },
		{ "<leader>dq", function() require("dbee").close() end,  desc = "Close DB UI" },
		{ "<leader>dr", function() require("dbee").reload() end, desc = "Reload Connections" },
	})
end
