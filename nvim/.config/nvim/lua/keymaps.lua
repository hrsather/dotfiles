-- Clear search highlights and dismiss Noice
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><cmd>NoiceDismiss<CR>")
-- Center cursor after moving page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "j", function()
    return vim.v.count > 0 and "jzz" or "j"
end, { expr = true, noremap = true })
vim.keymap.set("n", "k", function()
    return vim.v.count > 0 and "kzz" or "k"
end, { expr = true, noremap = true })
-- Ctrl-z doesn't suspend shell
vim.keymap.set("n", "<C-z>", "<nop>", { noremap = true, silent = true })
-- Leader d for cut
vim.keymap.set("n", "<leader>d", '"+dd', { noremap = true, desc = "Cut line" })
vim.keymap.set("v", "<leader>d", '"+d', { noremap = true, desc = "Cut selection" })
-- Don't paste over copy register
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })
vim.keymap.set("v", "C", '"_C', { noremap = true })
vim.keymap.set("v", "D", '"_D', { noremap = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { noremap = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true })
vim.keymap.set("v", "P", '"_dP', { noremap = true })
-- Comment in normal mode
vim.keymap.del("n", "gcc")
vim.keymap.set("n", "gc", function()
    return require("vim._comment").operator() .. "_"
end
, { expr = true, desc = "Toggle comment line" })
-- Y to yank right
vim.keymap.set("n", "Y", "y$", { noremap = true })
-- yp to yank full path
vim.keymap.set("n", "yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path)
end, { noremap = true, desc = "Yank full path" })
-- Visual block
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true, desc = "Visual block" })
-- Tab to accept completion if menu is visible
vim.keymap.set("i", "<Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<Tab>"
end, { expr = true, noremap = true })
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
-- buffers
vim.keymap.set("n", "<leader>b", "<cmd>e #<cr>", { noremap = true, desc = "Last Buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>wq<cr>", { noremap = true, desc = "Close Buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>wqa<cr>", { noremap = true, desc = "Close All Buffers" })
-- shortcuts
vim.keymap.set("n", "<leader>-", ":split<cr>", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", ":vsplit<cr>", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Joining
vim.keymap.set("v", "<leader>j", "J", { desc = "Join" })
vim.keymap.set("v", "J", "j", { desc = "Shift-J is j in v mode" })
vim.keymap.set("v", "K", "k", { desc = "Shift-K is k in v mode" })
-- close Lazy with <esc>
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    desc = "Quit lazy with <esc>",
    callback = function()
        vim.keymap.set("n", "<esc>", function()
            vim.api.nvim_win_close(0, false)
        end, { buffer = true, nowait = true })
    end,
    group = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true }),
})
-- Save on Ctrl+S
vim.keymap.set("n", "<C-S>", ":update<CR>", { silent = true, noremap = true })
vim.keymap.set("i", "<C-S>", "<Esc>:update<CR>", { silent = true, noremap = true })
-- buffer movements
vim.keymap.set("n", "zl", ":bprev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "zr", ":bnext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-w>", function() Snacks.bufdelete.delete() end,
    { desc = "Delete buffer", nowait = true })
-- file explorer
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { noremap = true, desc = "Open cwd" })
vim.keymap.set("n", "<leader>E", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
    { noremap = true, desc = "Open root" })
-- split movements
vim.keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Move to right split' })
