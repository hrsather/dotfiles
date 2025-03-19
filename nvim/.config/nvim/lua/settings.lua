-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
-- Make line numbers default
vim.opt.relativenumber = true
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"
-- Decrease update time
vim.opt.ttimeoutlen = 10
vim.opt.timeout = false
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15
-- Transparent background
vim.g.nord_disable_background = true
-- Saving session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- Comments in interactive shell
--setopt interactive_comments
