return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            sources = {
                files = {
                    hidden = true,
                },
                grep = {
                    hidden = true,
                },
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
            },
        },
        bigfile = {},
        lazygit = {},
        indent = {},
        quickfile = {},
    },
    keys = {
        { "<leader><space>", function() Snacks.picker.files() end,          desc = "Smart Find Files" },
        { "<leader>sr",      function() Snacks.picker.resume() end,         desc = "Resume" },
        { "<leader>/",       function() Snacks.picker.grep() end,           desc = "Grep" },
        { "gr",              function() Snacks.picker.lsp_references() end, nowait = true,            desc = "References" },
        { "<leader>g",       function() Snacks.lazygit() end,               nowait = true,            desc = "References" },
    },
}
