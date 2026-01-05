vim.pack.add({ { src = "https://github.com/Olical/conjure" } })

local conjure = {
	["conjure#filetype#rust"] = false,
	["conjure#filetype#python"] = false,
	["conjure#filetype#lua"] = false,
	["conjure#debug"] = false,
	["conjure#highlight#enabled"] = true,
	["conjure#mapping#doc_word"] = false,
	-- ["conjure#mapping#doc_word"] = "gk",
	["conjure#extract#tree_sitter#enabled"] = true,
	["conjure#log#treesitter"] = false,
	["conjure#client_on_load"] = false,
	["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false,
	["conjure#client#clojure#nrepl#refresh#backend"] = "clj-reload",
	["conjure#log#wrap"] = true,
	-- Elixir
	["conjure#client#elixir#stdio#command"] = "iex -S mix"
}

for key, value in pairs(conjure) do
	vim.g[key] = value
end

require("conjure.main").main()
