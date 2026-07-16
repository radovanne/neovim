vim.pack.add({
  {
    src = 'https://github.com/saghen/blink.lib',
  },
  {
    src = 'https://github.com/saghen/blink.cmp',
  },
  { src = "https://github.com/saghen/blink.compat" },
  {
    src = 'https://github.com/L3MON4D3/LuaSnip',
    version = vim.version.range("2.*")
  },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
})

local compat_ok, blink_compat = pcall(require, "blink.compat")
if compat_ok then
  blink_compat.setup({
    impersonate_nvim_cmp = true,
    debug = false,
  })
end

-- Must be after blink.compat setup so require("cmp") gets the shim
local dbee_cmp_ok, dbee_cmp = pcall(require, "cmp-dbee")
if dbee_cmp_ok then
  dbee_cmp.setup({})
end

-- Monkey-patch: enable column completions without alias (e.g. `win.<TAB>`)
pcall(function()
  local Handler = require("cmp-dbee.handler")
  local orig = Handler.get_completion
  local utils = require("cmp-dbee.utils")
  Handler.get_completion = function(self)
    local cursor_before_line = utils:get_cursor_before_line()
    local schema = utils:captured_schema(cursor_before_line)

    if schema and #self.latest_ts_structure > 0 then
      for _, m in ipairs(self.latest_ts_structure) do
        if m.table == schema then
          local columns = self.conn:get_columns(m.schema, m.table)
          if columns and #columns > 0 then
            return self:convert_many_to_completion_items(columns)
          end
        end
      end
    end

    return orig(self)
  end
end)

require("luasnip.loaders.from_vscode").lazy_load()
---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },
  appearance = {
    -- use_nvim_cmp_as_default = true,
    -- nerd_font_variant = "mono",
    nerd_font_variant = "normal",
  },
  signature = { enabled = true },
  cmdline = {
    enabled = true,
    -- sources = function()
    --   local type = vim.fn.getcmdtype()
    --   if type == "/" or type == "?" then
    --     return { "buffer" }
    --   end
    --   if type == ":" then
    --     return { "cmdline" }
    --   end
    --   return {}
    -- end,
    completion = {
      menu = {
        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      sql = { "dbee", "lsp", "path", "snippets", "buffer" },
    },
    providers = {
      dbee = {
        name = "cmp-dbee",
        module = "blink.compat.source",
        opts = {},
      },
    },
  },
  fuzzy = { implementation = "lua" },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
    }
  }
})
