require("snacks").setup({
    picker = {
        sources = {
            files = {
                hidden = true,
            },
            grep = {
                hidden = true,
                regex = false,
            },
        },
        win = {
            input = {
                keys = {
                    ["<Esc>"] = { "close", mode = { "n", "i" } },
                },
            },
        },
        exclude = {
            ".git",
            "node_modules",
            "poetry.lock",
        }
    },
    notifier = {},
    bigfile = {},
    lazygit = {},
    indent = {},
    quickfile = {},
    bufdelete = {},
    image = {}
})

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
vim.keymap.set("n", "<leader>g", function() Snacks.lazygit() end, { desc = "LazyGit" })
