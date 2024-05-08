local M = {
  "Olical/conjure",
  ft = { "clojure", "edn" }, -- etc
  event = "LspAttach",
  -- [Optional] cmp-conjure for cmp
  dependencies = {
    {
      "PaterJason/cmp-conjure",
      config = function()
	local cmp = require("cmp")
	local config = cmp.get_config()
	table.insert(config.sources, {
	  name = "buffer",
	  option = {
	    sources = {
	      { name = "conjure" },
	    },
	  },
	})
	cmp.setup(config)
      end,
    },
  },
  init = function()
    -- Set configuration options here
    vim.g["conjure#debug"] = false
  end,
}

function M.config()
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
    vim.g["conjure#mapping#doc_word"] = ",,gk"
end
return M
