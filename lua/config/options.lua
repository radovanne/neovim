local options = {
  guicursor = "",
  backup = false, -- Prevent a backup file
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect", "noinsert", "preview" },
  fileencoding = "utf-8", -- the encoding written to a file
  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- ignore `ignore case` when capital letter is used in search
  -- mouse = "a", -- allow the mouse to be used in neovim
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  softtabstop = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  numberwidth = 4, -- set number column width to 2 {default 4}
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8,
  sidescrolloff = 8,
  title = false,
  colorcolumn = "80", -- display vertical line on 80th char
  fillchars = vim.opt.fillchars + "eob: ",
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
