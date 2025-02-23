return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
			language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
		},
		keys = {
			{ "<leader>cb", ":CopilotChatBuffer ", desc = "Chat with current buffer" },
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
			{
				"<leader>cc",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "Toggle Vsplit", -- Toggle vertical split
			},
			{
				"<leader>cr",
				"<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
				desc = "Reset chat history and clear buffer",
			},
		},
	},
}
