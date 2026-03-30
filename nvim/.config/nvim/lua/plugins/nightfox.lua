require("nightfox").setup({
    options = {
        transparent = true,
    },
})
vim.cmd("colorscheme nordfox")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
