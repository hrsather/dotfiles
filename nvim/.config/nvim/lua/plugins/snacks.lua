return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {
			sources = {
				files = {
					hidden = true,
					ignored = true,
				},
				grep = {
					hidden = true,
					ignored = true,
				},
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
		},
		bigfile = {},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
	},
}
