return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
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
