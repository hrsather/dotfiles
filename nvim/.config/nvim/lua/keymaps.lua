-- Clear search highlights and dismiss Noice
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><cmd>NoiceDismiss<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
-- Center cursor after moving page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Ctrl-z doesn't suspend the shell anymore
vim.keymap.set("n", "<C-z>", "<nop>", { noremap = true, silent = true })
-- Ctrl-c for copy
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
-- Alt arrows movements
vim.keymap.set("i", "<M-Right>", "<Esc>ea", { noremap = true })
vim.keymap.set("i", "<M-Left>", "<Esc>lbi", { noremap = true })
-- Leader d for cut
vim.keymap.set("n", "<leader>d", '"+dd', { noremap = true, desc = "Cut line" })
vim.keymap.set("v", "<leader>d", '"+d', { noremap = true, desc = "Cut selection" })
-- Don't add pasting over to register
vim.keymap.set("v", "p", '"_dP"', { noremap = true })
-- Visual block
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true, desc = "Visual block" })
-- Y to yank right
vim.keymap.set("n", "Y", "y$", { noremap = true })
-- mini files
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { noremap = true, desc = "Open cwd" })
vim.keymap.set(
	"n",
	"<leader>E",
	"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
	{ noremap = true, desc = "Open root" }
)
-- buffers
vim.keymap.set("n", "<leader>b", "<cmd>e #<cr>", { noremap = true, desc = "Last Buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>wq<cr>", { noremap = true, desc = "Close Buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>wqa<cr>", { noremap = true, desc = "Close All Buffers" })
-- shortcuts
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { noremap = true, desc = "LazyGit" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("v", "<leader>j", "J", { desc = "Join" })
vim.keymap.set("v", "J", "j", { desc = "Shift-J" })
vim.keymap.set("v", "K", "k", { desc = "Shift-K" })

-- cloze Lazy with <esc>
local user_grp = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	desc = "Quit lazy with <esc>",
	callback = function()
		vim.keymap.set("n", "<esc>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = true, nowait = true })
	end,
	group = user_grp,
})
