return {
    "echasnovski/mini.nvim",
    config = function()
        -- ai
        require("mini.ai").setup()

        -- surround
        require("mini.surround").setup()

        -- git signs
        require("mini.diff").setup({ view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } } })

        -- sessions
        require("mini.sessions").setup({ autoread = false, file = ".Session.vim" })

        -- pairs
        require("mini.pairs").setup()

        -- jump
        require("mini.jump").setup()

        -- tabline
        require("mini.tabline").setup()

        -- statusline
        local my_active_content = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 40 })
            local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = mode_hl,                  strings = { search, location } },
            })
        end
        require("mini.statusline").setup({ content = { active = my_active_content } })

        -- file explorer
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

        -- highlight patterns
        require("mini.hipatterns").setup({
            highlighters = {
                fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
                hack = { pattern = "HACK", group = "MiniHipatternsHack" },
                todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
                note = { pattern = "NOTE", group = "MiniHipatternsNote" },
            },
        })
    end,
}
