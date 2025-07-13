local options = {
	-- Basic settings
number = true,                              -- Line numbers
relativenumber = true,                      -- Relative line numbers
numberwidth = 4,
wrap = false,                               -- Don't wrap lines
scrolloff = 10,                             -- Keep 10 lines above/below cursor 
sidescrolloff = 8,                          -- Keep 8 columns left/right of cursor

-- Indentation
tabstop = 2,                                -- Tab width
shiftwidth = 2,                             -- Indent width
softtabstop = 2,                            -- Soft tab stop
expandtab = true,                           -- Use spaces instead of tabs
smartindent = true,                         -- Smart auto-indenting
autoindent = true,                          -- Copy indent from current line

-- Search settings
ignorecase = true,                          -- Case insensitive search
smartcase = true,                           -- Case sensitive if uppercase in search
incsearch = true,                           -- Show matches as you type

-- Visual settings
termguicolors = true,                       -- Enable 24-bit colors
signcolumn = "yes",                         -- Always show sign column
colorcolumn = "100",                        -- Show column at 100 characters
showmatch = true,                           -- Highlight matching brackets
matchtime = 2,                              -- How long to show matching bracket
cmdheight = 1,                              -- Command line height
laststatus = 3,
completeopt ={ "menu", "menuone", "noselect", "noinsert", "preview" },  -- Completion options 
showmode = false,                           -- Don't show mode in command line 
pumheight = 10,                             -- Popup menu height 
pumblend = 10,                              -- Popup menu transparency 
conceallevel = 0,                           -- Don't hide markup 
concealcursor = "",                         -- Don't hide cursor line markup 
lazyredraw = true,                          -- Don't redraw during macros
synmaxcol = 300,                            -- Syntax highlighting limit 

-- File handling
backup = false,                             -- Don't create backup files
writebackup = false,                        -- Don't create backup before writing
swapfile = false,                           -- Don't create swap files
undofile = true,                            -- Persistent undo
undodir = vim.fn.expand("~/.vim/undodir"),  -- Undo directory
updatetime = 300,                           -- Faster completion
timeoutlen = 500,                           -- Key timeout duration
ttimeoutlen = 0,                            -- Key code timeout
autoread = true,                            -- Auto reload files changed outside vim
autowrite = false,                          -- Don't auto save

-- Behavior settings
hidden = true,                              -- Allow hidden buffers
errorbells = false,                         -- No error bells
backspace = "indent,eol,start",             -- Better backspace behavior
autochdir = false,                          -- Don't auto change directory
selection = "exclusive",                    -- Selection behavior
mouse = "a",                                -- Enable mouse support
modifiable = true,                          -- Allow buffer modifications
encoding = "UTF-8",                         -- Set encoding

-- Cursor settings
-- guicursor = "",

-- Split behavior
splitbelow = true,                          -- Horizontal splits go below
splitright = true,                          -- Vertical splits go right

fillchars = vim.opt.fillchars + "eob: ",
spelllang = "en_gb",
more = false,
inccommand = "split",
title = false,

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
