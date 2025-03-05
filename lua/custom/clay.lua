-- SciCloj/Clay integration with Conjure written in Lua
local eval = require("conjure.eval")
local extract = require("conjure.extract")

local M = {}

M.start = function()
	local source_path = vim.fn.expand("%:p")
	local code = string.format(
		'(do (require \'[scicloj.clay.v2.api :as clay]) (clay/make! {:source-path "%s"}))',
		source_path
	)

	eval["eval-str"]({
		origin = "custom-clay-wrapper",
		code = code,
	})
end


M.eval_form = function ()
	local form_content = extract.form({ root = true }).content
	local source_path = vim.fn.expand("%:p")
	local code =
	string.format('(scicloj.clay.v2.api/make! {:source-path "%s" :single-form %s})', source_path, form_content)

	eval["eval-str"]({
		origin = "custom-clay-wrapper",
		code = code,
	})
end


M.eval_ns = function()
	local source_path = vim.fn.expand("%:p")
	local code = string.format('(scicloj.clay.v2.api/make! {:source-path "%s"})', source_path)
	eval["eval-str"]({
		origin = "custom-clay-wrapper",
		code = code,
	})
end

M.eval_ns_to_hiccup = function()
	local source_path = vim.fn.expand("%:p")
	local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
	eval["eval-str"]({
		origin = "custom-clay-wrapper",
		code = code,
	})
end

return M
