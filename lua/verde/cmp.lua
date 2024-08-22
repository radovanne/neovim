local M = {
  "hrsh7th/nvim-cmp", -- autocompletion plugin
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp", -- source for LSP completions
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-emoji", -- source for emoji completions
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path", -- source for file system paths
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-cmdline", -- source for command line completions
      event = "InsertEnter",
    },
    {
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      event = "InsertEnter",
    },
    {
      "L3MON4D3/LuaSnip", -- snippet engine
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/cmp-nvim-lua", -- source for nvim lua completions
    },
    --{
    --  "onsails/lspkind.nvim",  -- vs-code like pictograms
    --}
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local fmt = require("luasnip.extras.fmt").fmt

  -- custom snippet for html in php file
  luasnip.add_snippets("php", {
    luasnip.snippet(
      "html5",
      fmt(
        [[
      <!DOCTYPE html>
      <html lang='en'>
      <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <title>{1}</title>
      </head>
      <body>
        {2} 
      </body>
      </html>
      ]],
        {
          luasnip.insert_node(1, "Title"),
          luasnip.insert_node(2, "Body")
        }
      )
    ),
  })

  require("luasnip/loaders/from_vscode").lazy_load()

-- #3F0FB7
-- #4B0082
-- #3964C3
-- #e71837

  vim.api.nvim_set_hl(0, "CmpItemKindConjure", { fg = "#3964C3" })
  vim.api.nvim_set_hl(0, "CmpItemKindBuffer", { fg = "#6CC644" })
  vim.api.nvim_set_hl(0, "CmpItemKindNvimLsp", { fg = "#CA42F0" })
  vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

  local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  local icons = require("verde.icons")
  -- local lspkind = require "lspkind"

  cmp.setup({
    snippet = {
      expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
          -- require("neotab").tabout()
        else
          fallback()
          -- require("neotab").tabout()
        end
        end, {
          "i",
          "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
        end, {
          "i",
          "s",
      }),
    }),
    formatting = {
      expandable_indicator = true,
      fields = { "kind", "abbr", "menu" },
      -- format = lspkind.cmp_format({
      --		maxwidth = 50,
      --		ellipsis_char = "..."}),
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
          emoji = "",
        })[entry.source.name]

        if entry.source.name == "conjure" then
          vim_item.kind = icons.ui.Code
          vim_item.kind_hl_group = "CmpItemKindConjure"
        end

        if entry.source.name == "emoji" then
          vim_item.kind = icons.misc.Smiley
          vim_item.kind_hl_group = "CmpItemKindEmoji"
        end

        if entry.source.name == "buffer" then
          vim_item.kind = icons.ui.File
          vim_item.kind_hl_group = "CmpItemKindBuffer"
        end

        if entry.source.name == "nvim_lsp" then
          vim_item.kind = icons.misc.Robot
          vim_item.kind_hl_group = "CmpItemKindNvimLsp"
        end

        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      -- { name = "copilot" },
      { name = "buffer" },
      { name = "path" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "calc" },
      { name = "emoji" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
    experimental = {
      ghost_text = false,
    },
  })
end

return M
