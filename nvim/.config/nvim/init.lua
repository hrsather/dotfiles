vim.loader.enable()

require("settings")
require("keymaps")
require("lsp")

-- Manually enable the lsp servers in the ./lsp/ directory
vim.lsp.enable({ "basedpyright", "ruff", "lua", "json", "html", "css", "bash", "hcl" })

-- Plugins
vim.pack.add({
    "https://github.com/echasnovski/mini.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/EdenEast/nightfox.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/folke/noice.nvim",
})

require("plugins.mini")
require("plugins.snacks")
require("plugins.treesitter")
require("plugins.nightfox")
require("plugins.noice")
