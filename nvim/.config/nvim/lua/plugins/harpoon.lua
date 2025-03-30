return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>A",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Harpoon file",
		},
		{
			"<leader>a",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon quick menu",
		},
		{
			"yh1",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"yh2",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"yh3",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"yh4",
			function()
				require("harpoon"):list():select(4)
			end,
		},
		{
			"yh5",
			function()
				require("harpoon"):list():select(5)
			end,
		},
		{
			"yh6",
			function()
				require("harpoon"):list():select(6)
			end,
		},
		{
			"yh7",
			function()
				require("harpoon"):list():select(7)
			end,
		},
		{
			"yh8",
			function()
				require("harpoon"):list():select(8)
			end,
		},
		{
			"yh9",
			function()
				require("harpoon"):list():select(9)
			end,
		},
	},
}
