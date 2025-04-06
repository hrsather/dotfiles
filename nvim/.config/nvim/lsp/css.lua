---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { ".git" },
	init_options = {
		provideFormatter = true,
	},
	single_file_support = true,
}
