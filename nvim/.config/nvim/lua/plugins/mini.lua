return {
	"echasnovski/mini.nvim",
	config = function()
		-- ai
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup()

		-- move
		require("mini.move").setup()

		-- surround
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- sensible defaults
		require("mini.basics").setup()

		-- indent
		require("mini.indentscope").setup({ draw = { delay = 50 } })

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

		-- comment
		require("mini.comment").setup()

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
