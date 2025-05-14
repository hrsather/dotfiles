return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = function(_, opts)
        -- Ensure opts is initialized
        opts = opts or {}

        -- Apply the notify setup
        require("notify").setup({ background_colour = "#2E3440" })

        -- Merge the lsp override configurations
        opts.lsp                  = opts.lsp or {}
        opts.lsp.override         = vim.tbl_deep_extend("force", opts.lsp.override or {}, {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        })

        opts.lsp.progress         = opts.lsp.progress or {}
        opts.lsp.progress.enabled = false

        opts.routes               = {
            {
                filter = { event = "msg_showmode" },
                view = "notify",
            },
            {
                filter = {
                    event = "lsp",
                    kind = "progress",
                    find = "Diagnosing",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        }

        return opts
    end,
}
