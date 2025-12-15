return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- TODO: Update to "main" branch once 0.12 is out
        branch = "master",
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'python', 'yaml', 'json', 'bash', 'html', 'toml', 'lua', 'markdown', 'markdown_inline', 'dockerfile', 'jq' },
            highlight = { enable = true },
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
