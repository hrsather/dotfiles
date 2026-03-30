require("mini.ai").setup()
require("mini.surround").setup()
require("mini.diff").setup({ view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } } })
require("mini.sessions").setup({ autoread = true, file = ".Session.vim" })
require("mini.pairs").setup()
require("mini.jump").setup()
require("mini.tabline").setup()
require("mini.icons").setup()

local my_active_content = function()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
    local location      = MiniStatusline.section_location({ trunc_width = 75 })

    return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = mode_hl, strings = { location } },
    })
end
require("mini.statusline").setup({ content = { active = my_active_content } })

require("mini.files").setup({
    mappings = {
        go_in_plus = "<cr>",
        close = "<esc>",
        synchronize = "<c-s>",
    },
})
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        local MiniFiles = require("mini.files")

        local map_split = function(lhs, direction)
            vim.keymap.set("n", lhs, function()
                -- Create a new split and set it as the target window
                local new_target_window
                vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function()
                    vim.cmd(direction .. " split")
                    new_target_window = vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target_window)
                MiniFiles.go_in()
                MiniFiles.close()
            end, { buffer = buf_id, desc = "Open in " .. direction .. " split" })
        end

        map_split("<space>-", "belowright horizontal")
        map_split("<space>|", "belowright vertical")
    end,
})
