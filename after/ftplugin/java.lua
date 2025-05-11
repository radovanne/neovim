local config = {
    bundles = {},
    cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
-- Add spring-boot jdtls extension jar files
vim.list_extend(config.bundles, require("spring_boot").java_extensions())
require('jdtls').start_or_attach(config)
