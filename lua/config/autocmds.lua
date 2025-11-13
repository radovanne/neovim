vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- [[ Fixes neovim lag when CurSearch is active ]]
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "hi! link CurSearch Search"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})


-- [[ Enable spell and wrap on certain filetypes ]]
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})

local set = vim.opt_local

-- [[ Terminal ]]
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0

    vim.bo.filetype = "terminal"
  end,
})


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})


-- [[ Syntax highlighting for env files ]]
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})



-- [[ Highlight symbol and references under cursor ]]
local HIGHLIGHT_GROUP_NAME = "LspCurrentWordHighlight"
local cur_word_hl_group = vim.api.nvim_create_augroup(HIGHLIGHT_GROUP_NAME, { clear = false })

local function enable_lsp_highlight()
  local lsp_highlight_toggle = function()
    if next(vim.lsp.get_clients({ bufnr = 0 })) then
      if vim.fn.eventhandler() then
        vim.lsp.buf.document_highlight()
      end
    end
  end

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = cur_word_hl_group,
    callback = lsp_highlight_toggle,
    desc = "Trigger LSP Document Highlight on hold",
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
    group = cur_word_hl_group,
    callback = vim.lsp.buf.clear_references,
    desc = "Clear LSP Document Highlights on move",
  })
end

local function disable_lsp_highlight()
  vim.api.nvim_clear_autocmds({ group = HIGHLIGHT_GROUP_NAME })
  vim.lsp.buf.clear_references()
end

local function toggle_lsp_highlight()
  local is_active = not not vim.api.nvim_get_autocmds({
    group = HIGHLIGHT_GROUP_NAME,
    event = "CursorHold",
  })

  if is_active then
    disable_lsp_highlight()
  else
    enable_lsp_highlight()
  end
end

vim.keymap.set("n", "<Leader>lh", toggle_lsp_highlight, {
  noremap = true,
  silent = true,
  desc = "Toggle LSP Document Highlight",
})
