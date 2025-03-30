return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- Set an empty statusline until Lualine loads
			vim.o.statusline = " "
		else
			-- Hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		-- PERF: Simplify Lualine require
		local lualine_require = require("lualine_require")
		lualine_require.require = require

		vim.o.laststatus = vim.g.lualine_laststatus

		local noice = require("noice")

		return {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						noice.api.statusline.mode.get,
						cond = noice.api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_y = {
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return os.date("%I:%M")
					end,
				},
			},
		}
	end,
}
