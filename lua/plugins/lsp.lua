vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
})

local servers = {
  "lua_ls",
  "ts_ls",
  "pyright",
  "dockerls",
  "bashls",
  "jsonls",
  "clojure_lsp",
  "graphql",
  "yamlls",
}

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

-- Native way, still bad
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local lsp = vim.lsp
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          local kind = lsp.protocol.CompletionItemKind[item.kind] or 'u'
          return {
            abbr = item.label:gsub('%b()', ''),
            kind = kind:sub(1, 1):lower(),
            menu = '',
          }
        end,
      })
    end
  end,
})
--
-- show documentation popups
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local supports_resolve = client:supports_method(vim.lsp.protocol.Methods.completionItem_resolve)
    local _, cancel_prev = nil, function() end
    vim.api.nvim_create_autocmd("CompleteChanged", {
      buffer = args.buf,
      callback = function()
        cancel_prev()
        local info = vim.fn.complete_info({ "selected" })
        local completionItem = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
        if nil == completionItem then
          return
        end
        if not supports_resolve then
          return
        end
        _, cancel_prev = vim.lsp.buf_request(
          args.buf,
          vim.lsp.protocol.Methods.completionItem_resolve,
          completionItem,
          function(err, item, ctx)
            if err then
              return
            end
            if not item then
              return
            end
            local docs = (item.documentation or {}).value
            local win = vim.api.nvim__complete_set(info["selected"], { info = docs })
            if win.winid and vim.api.nvim_win_is_valid(win.winid) then
              vim.treesitter.start(win.bufnr, "markdown")
              vim.wo[win.winid].conceallevel = 3
            end
          end
        )
      end,
    })
  end,
})

vim.lsp.enable(servers)

vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())   -- TODO: What does this do?

local wk = require("which-key")

wk.add({
  { "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
  { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",           desc = "Goto definition" },
  { "cx",         "<cmd>lua vim.diagnostic.open_float()<CR>",        desc = "Trouble preview" },
})

wk.add({
  mode = { "i" },
  {
    "<c-space>",
    function()
      vim.lsp.completion.get()
    end,
    desc = "Autocomplete"
  },
})

local icons = require("config.icons")

local default_diagnostic_config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = icons.diagnostics.Error },
      { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
      { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
      { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
    },
  },
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "",
    max_width = 80,
  },
}

vim.diagnostic.config(default_diagnostic_config)

for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config() or {}, "signs", "values") or {}) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end
