return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({ "fzf-native" })
		vim.keymap.set("n", "<leader><leader>", function()
			fzf.files()
		end, { desc = "Search Files" })
		vim.keymap.set("n", "<leader>/", function()
			fzf.live_grep()
		end, { desc = "Search by Grep" })
		vim.keymap.set("n", "<leader>?", function()
			fzf.grep_curbuf()
		end, { desc = "Search current buffer" })
		vim.keymap.set("n", "<leader>sr", function()
			fzf.resume()
		end, { desc = "Search Resume" })
		vim.keymap.set("n", "<leader>sw", function()
			fzf.grep_cword()
		end, { desc = "Search Word" })
		vim.keymap.set("v", "<leader>sw", function()
			fzf.grep_visual()
		end, { desc = "Search Selection" })
	end,
}
