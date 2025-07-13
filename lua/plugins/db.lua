local M = {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
            lazy = true,
            init = function()
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = { "sql", "mysql", "plsql" },
                    callback = function()
                        if package.loaded["cmp"] then
                            local cmp = require("cmp")
                            local current_sources = cmp.get_config().sources
                            local dadbod_source = { name = "vim-dadbod-completion" }

                            local found = false
                            for _, source in ipairs(current_sources) do
                                if source.name == dadbod_source.name then
                                    found = true
                                    break
                                end
                            end

                            if not found then
                                table.insert(current_sources, dadbod_source)
                            end

                            cmp.setup.buffer({
                                sources = {
                                    { name = "vim-dadbod-completion" },
                                    { name = "nvim_lsp" },
                                    { name = "buffer" },
                                    { name = "path" },
                                },
                            })
                        end
                    end,
                })
            end,
        },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
}

M.init = function()
    require("config.db")
end

return M
