local colors = require("colors")

require("mini.base16").setup({
    palette = {
        base00 = colors.bg_dark,    -- Default background
        base01 = colors.bg_light,   -- Lighter background (status bars, panels)
        base02 = colors.selection,  -- Selection background / highlights
        base03 = colors.comment,    -- Comments, line highlighting, invisibles
        base04 = colors.fg_dark,    -- Darker foreground (subtle UI text)
        base05 = colors.fg,         -- Default foreground, main text
        base06 = colors.fg_light,   -- Lighter foreground (secondary text)
        base07 = colors.accent,     -- Brightest shade / emphasis
        base08 = colors.error,      -- Variables, errors, deleted text
        base09 = colors.link,       -- Constants, links, numbers
        base0A = colors.highlight,  -- Classes, search highlights
        base0B = colors.success,    -- Strings, inserted text
        base0C = colors.warning,    -- Regex, escape sequences, support
        base0D = colors.func,       -- Functions, method names, headings
        base0E = colors.keyword,    -- Keywords, storage, markup emphasis
        base0F = colors.deprecated, -- Deprecated, special, warnings
    }
})
