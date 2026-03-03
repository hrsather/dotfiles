-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
-- Line numbers
vim.opt.number = true
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
-- Saving session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})
-- ignore warnings in :checkhealth
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- don't kick numbers right
vim.o.signcolumn = "yes"
-- better completion settings
vim.o.completeopt = "menu,menuone,noselect"
-- default spacing
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- smart '/' searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- Create session file if one doesn't exist (mini.sessions handles read/write)
vim.api.nvim_create_autocmd("VimEnter", {
    nested = true,
    callback = function()
        if vim.fn.argc() == 0 and vim.fn.filereadable(vim.fn.getcwd() .. "/.Session.vim") == 0 then
            MiniSessions.write(".Session.vim")
        end
    end,
})
-- Don't notify on mode switches
vim.opt.showmode = false
