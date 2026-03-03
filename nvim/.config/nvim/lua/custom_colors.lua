local colors = require("colors")

-- Transparent backgrounds
local transparent = {
    "NormalFloat", "LineNr", "LineNrAbove", "LineNrBelow",
    "Pmenu", "PmenuKind", "SignColumn", "TabLineFill",
    "MiniStatuslineFilename", "StatusLine", "StatusLineNC",
}
for _, group in ipairs(transparent) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
end

-- Noice / mini.files
vim.api.nvim_set_hl(0, "MiniFilesTitle", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = colors.success, bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.error, bg = "NONE", bold = false })

-- Git diff signs
vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = colors.success, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = colors.keyword, bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = colors.accent, bg = "NONE" })

-- Delimiters
vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.fg })

-- LSP / syntax
local accent_groups = { "@attribute", "@lsp.type.property", "Identifier", "@module", "@variable.parameter" }
for _, group in ipairs(accent_groups) do
    vim.api.nvim_set_hl(0, group, { fg = colors.accent })
end
