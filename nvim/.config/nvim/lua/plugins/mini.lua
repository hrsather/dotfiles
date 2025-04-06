return {
	"echasnovski/mini.nvim",
	config = function()
		-- ai
		require("mini.ai").setup()

		-- surround
		require("mini.surround").setup()

		-- git signs
		require("mini.diff").setup({ view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } } })

		-- indent
		require("mini.indentscope").setup({ draw = { delay = 50 } })

		-- pairs
		require("mini.pairs").setup()

		-- file explorer
		require("mini.files").setup({
			mappings = {
				go_in_plus = "<cr>",
				close = "<esc>",
				synchronize = "<c-s>",
			},
		})
		local map_split = function(buf_id, lhs, direction)
			local rhs = function()
				-- Make new window and set it as target
				local new_target_window
				vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
					vim.cmd(direction .. " split")
					new_target_window = vim.api.nvim_get_current_win()
				end)

				MiniFiles.set_target_window(new_target_window)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, true, true), "m", true)
			end
			local desc = "Split " .. direction
			vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
		end
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				map_split(buf_id, "<space>-", "belowright horizontal")
				map_split(buf_id, "<space>|", "belowright vertical")
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
