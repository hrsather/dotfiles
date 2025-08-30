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
-- vim.g.nord_disable_background = true
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
-- numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.diagnostic.config({ signs = false })
-- better completion settings
vim.o.completeopt = "menu,menuone,noselect"
-- default spacing
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- smart '/' searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- Create a session file for each repo opened
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    nested = true,
    callback = function()
        -- Check if no file arguments were provided
        if vim.fn.argc() == 0 then
            local session_file = vim.fn.getcwd() .. '/.Session.vim'
            if vim.fn.filereadable(session_file) == 1 then
                vim.cmd('source ' .. session_file)
            else
                vim.cmd('mksession! ' .. session_file)
            end
        end
    end,
})
-- Don't notify on mode switches
vim.opt.showmode = false
