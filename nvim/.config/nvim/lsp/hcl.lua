---@type vim.lsp.Config
return {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "hcl", "terraform", "terraform-vars" },
	root_markers = { ".terraform", ".git" },
	single_file_support = true,
}
