local options = {
	-- Basic settings
	nu = true,																	-- Line numbers
	rnu = true,																	-- Relative line numbers
	wrap = false,                               -- Don't wrap lines
	scrolloff = 10,                             -- Keep 10 lines above/below cursor 
	guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",

	-- Indentation
	tabstop = 4,                                -- Tab width
	shiftwidth = 4,                             -- Indent width
	softtabstop = 4,                            -- Soft tab stop
	expandtab = true,                           -- Use spaces instead of tabs
	smartindent = true,                         -- Smart auto-indenting

	-- Visual settings
	termguicolors = true,                       -- Enable 24-bit colors
	signcolumn = "yes",                         -- Always show sign column
	completeopt ={ "menu", "menuone", "noselect", "popup", "fuzzy" },  -- Completion options 
	synmaxcol = 300,                            -- Syntax highlighting limit 
	title = true,

	-- File handling
	writebackup = false,                        -- Don't create backup before writing
	swapfile = false,                           -- Don't create swap files
	undofile = true,                            -- Persistent undo
	undodir = vim.fn.expand("~/.vim/undodir"),  -- Undo directory
	updatetime = 50,                           -- Faster completion

	-- Split behavior
	splitbelow = true,                          -- Horizontal splits go below
	splitright = true,                          -- Vertical splits go right
}

vim.opt.path:append("**")                          -- include subdirectories in search

-- If netrw is being used
-- vim.g.netrw_banner = 0
-- vim.g.netrw_mouse = 2
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_winsize = 25

local opt = vim.opt

opt.isfname:append("@-@")

for k, v in pairs(options) do
	opt[k] = v
end
