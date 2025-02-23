require("settings")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
	})
end
vim.opt.rtp:prepend(lazypath)
print(lazypath)
require("lazy").setup({
	import = "plugins",
})

vim.cmd.colorscheme("nord")

-- modeline
-- vim: ts=2 sts=2 sw=2 et
