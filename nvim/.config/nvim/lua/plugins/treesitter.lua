return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'python', 'yaml', 'json', 'bash', 'html', 'lua', 'markdown', 'markdown_inline' },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<cr>",
                    node_incremental = "<cr>",
                    node_decremental = "<BS>",
                }
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
        }
    },
}
