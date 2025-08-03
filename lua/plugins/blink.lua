vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp' },
  {
    src = 'https://github.com/L3MON4D3/LuaSnip',
    version = vim.version.range("2.*")
  },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
})

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
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end,
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
  },
  fuzzy = { implementation = "lua" },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
    },
  },
})
