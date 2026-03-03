return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        notify = {
            view = "mini",
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            progress = { enabled = false },
        },
        routes = {
            {
                filter = { event = "msg_showmode" },
                view = "mini",
            },
            {
                filter = { event = "lsp", kind = "progress", find = "Diagnosing" },
                opts = { skip = true },
            },
            {
                filter = { event = "msg_show", kind = "", find = "written" },
                opts = { skip = true },
            },
        },
    },
}
