-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"
-- Decrease update time
vim.opt.timeout = false
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15
-- Saving session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- Ignore warnings in :checkhealth
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- Undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- Don't kick numbers right
vim.o.signcolumn = "yes"
-- Better completion settings
vim.o.completeopt = "menu,menuone,noselect,fuzzy"
-- Default spacing
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- Smart '/' searching
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
vim.o.cmdheight = 0
