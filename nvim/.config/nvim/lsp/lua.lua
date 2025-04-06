---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json", ".luarc.jsonc", ".git"
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- or "Lua 5.1", etc.
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" }, -- Prevent 'vim' is undefined warning
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
	single_file_support = true,
}
