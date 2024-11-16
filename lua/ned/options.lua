local options = {
  guicursor = "",
  backup = false, -- Prevent a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect", "noinsert", "preview" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  -- mouse = "a" -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  pumblend = 10,
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- never show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  softtabstop = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = false, -- don't highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8,
  sidescrolloff = 8,
  --  guifont = "monospace:h17", -- the font used in graphical neovim applications
  title = false,
  colorcolumn = "80", -- display vertical line on 80th char
  fillchars = vim.opt.fillchars + "eob: ",
  -- spellchecker
  spelllang = "en_gb",
  more = false,
  inccommand = "split"
}

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

local opt = vim.opt

opt.fillchars:append {
    stl = " ",
  }

for k, v in pairs(options) do
	opt[k] = v
end
