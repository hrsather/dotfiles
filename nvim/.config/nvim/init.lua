require("settings")
require("keymaps")
require("lsp")

-- Manually enable the lsp servers in the ./lsp/ directory
vim.lsp.enable({ "basedpyright", "ruff", "lua", "json", "html", "css", "bash" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    import = "plugins",
}, {
    rocks = {
        enabled = false,
    }
})

vim.cmd("colorscheme nord")

require("mini.colors").get_colorscheme():add_transparency():apply()

local colors = require("colors")

-- Floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

-- Number Column
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "NONE" })

-- Popup menu
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKind", { bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniFilesTitle", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = colors.success, bg = "NONE", bold = false })

-- Sign column
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = colors.success, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = colors.keyword, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = colors.accent, bg = "NONE" })

-- Tab bar
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

-- Status bar
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

-- Delimiters
vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.fg })

-- LSP / syntax
vim.api.nvim_set_hl(0, "@attribute", { fg = colors.accent })
vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = colors.accent })
vim.api.nvim_set_hl(0, "@module", { fg = colors.accent })
