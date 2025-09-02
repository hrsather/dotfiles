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
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.accent })
vim.api.nvim_set_hl(0, "@module", { fg = colors.accent })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = colors.accent })
