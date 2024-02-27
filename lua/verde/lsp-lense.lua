return {
  'VidocqH/lsp-lens.nvim',
  event = "LspAttach",
  config = function()
    require 'lsp-lens'.setup({
      enable = false,
      include_declaration = false,     -- Reference include declaration
      sections = {                     -- Enable / Disable specific request
        definition = false,
        references = true,
        implements = false,
    }})
  end
}
