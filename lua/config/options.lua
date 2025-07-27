local options = {
	-- Basic settings
nu = true,																	-- Line numbers
rnu = true,																	-- Relative line numbers
wrap = false,                               -- Don't wrap lines
scrolloff = 10,                             -- Keep 10 lines above/below cursor 
sidescrolloff = 8,                          -- Keep 8 columns left/right of cursor

-- Indentation
tabstop = 2,                                -- Tab width
shiftwidth = 2,                             -- Indent width
softtabstop = 2,                            -- Soft tab stop
expandtab = true,                           -- Use spaces instead of tabs
smartindent = true,                         -- Smart auto-indenting

-- Search settings
ignorecase = true,                          -- Case insensitive search
smartcase = true,                           -- Case sensitive if uppercase in search

-- Visual settings
termguicolors = true,                       -- Enable 24-bit colors
signcolumn = "yes",                         -- Always show sign column
showmatch = true,                           -- Highlight matching brackets
matchtime = 2,                              -- How long to show matching bracket
completeopt ={ "menu", "menuone", "noselect", "popup", "fuzzy" },  -- Completion options 
showmode = false,                           -- Don't show mode in command line 
pumheight = 10,                             -- Popup menu height 
synmaxcol = 300,                            -- Syntax highlighting limit 
-- winborder = "shadow",

-- File handling
writebackup = false,                        -- Don't create backup before writing
swapfile = false,                           -- Don't create swap files
undofile = true,                            -- Persistent undo
undodir = vim.fn.expand("~/.vim/undodir"),  -- Undo directory
updatetime = 300,                           -- Faster completion
timeoutlen = 500,                           -- Key timeout duration
ttimeoutlen = 0,                            -- Key code timeout

-- Behavior settings
hidden = true,                              -- Allow hidden buffers
backspace = "indent,eol,start",             -- Better backspace behavior
mouse = "a",                                -- Enable mouse support
modifiable = true,                          -- Allow buffer modifications

-- Split behavior
splitbelow = true,                          -- Horizontal splits go below
splitright = true,                          -- Vertical splits go right

fillchars = vim.opt.fillchars + "eob: ",
more = false,
inccommand = "split",

-- Performance improvements
redrawtime = 10000,
maxmempattern = 20000,
}

vim.opt.shortmess:append("c")
vim.opt.path:append("**")                          -- include subdirectories in search

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- If netrw is being used
-- vim.g.netrw_banner = 0
-- vim.g.netrw_mouse = 2

local opt = vim.opt

opt.fillchars:append({
	stl = " ",
})

for k, v in pairs(options) do
	opt[k] = v
end
