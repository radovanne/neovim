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

local dbee_cmp_ok, dbee_cmp = pcall(require, "cmp-dbee")
if dbee_cmp_ok then
  dbee_cmp.setup({})
end

pcall(function()
  local Handler = require("cmp-dbee.handler")
  local orig = Handler.get_completion
  local utils = require("cmp-dbee.utils")
  Handler.get_completion = function(self)
    local cursor_before_line = utils:get_cursor_before_line()
    local schema = utils:captured_schema(cursor_before_line)

    if not schema then
      local items = {}
      local schemas = self.conn:get_schemas()
      if schemas then
        for _, s in ipairs(schemas) do
          if s.children then
            for _, child in ipairs(s.children) do
              table.insert(items, {
                name = s.name .. "." .. child.name,
                type = "table",
                description = child.type or "table",
              })
            end
          end
        end
      end
      if #items > 0 then
        return self:convert_many_to_completion_items(items)
      end
      return orig(self)
    end

    if schema then
      local schemas = self.conn:get_schemas()

      local function find_and_return(ref)
        local s, t = ref:match("([%w_]+)%.([%w_]+)")
        if s then
          local cols = self.conn:get_columns(s, t)
          if cols and #cols > 0 then return self:convert_many_to_completion_items(cols) end
          return
        end
        if schemas then
          for _, sc in ipairs(schemas) do
            if sc.children then
              for _, child in ipairs(sc.children) do
                if child.name == ref then
                  local cols = self.conn:get_columns(sc.name, ref)
                  if cols and #cols > 0 then return self:convert_many_to_completion_items(cols) end
                end
              end
            end
          end
        end
      end

      local result = find_and_return(schema)
      if result then return result end

      local alias_ref = cursor_before_line:match(
        "[Ff][Rr][Oo][Mm]%s+([%w_%.]+)%s+[Aa][Ss]?%s+" .. schema .. "[%s,;)]"
      )
      if alias_ref then
        result = find_and_return(alias_ref)
        if result then return result end
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
    nerd_font_variant = "normal",
  },
  signature = { enabled = true },
  cmdline = {
    enabled = true,
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
