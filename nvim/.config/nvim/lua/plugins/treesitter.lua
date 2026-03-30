local sel = require("vim.treesitter._select")
vim.keymap.set("n", "<cr>", "viw", { desc = "Init treesitter selection" })
vim.keymap.set("x", "<cr>", function() sel.select_parent(vim.v.count1) end, { desc = "Expand selection" })
vim.keymap.set("x", "<BS>", function() sel.select_child(vim.v.count1) end, { desc = "Shrink selection" })

require("treesitter-context").setup({ enable = true })
