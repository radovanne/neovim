vim.pack.add({
  {
    src = 'https://github.com/saghen/blink.lib',
  },
  {
    src = 'https://github.com/saghen/blink.cmp',
  },
})

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
  keymap = {
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
    default = { "lsp", "path", "buffer" },
  },
  fuzzy = { implementation = "lua" },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    documentation = {
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
    }
  }
})
