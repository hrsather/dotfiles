require("settings")
require("keymaps")
require("lsp")

vim.cmd.colorscheme("nord")

-- Manually enable the lsp servers in the ./lsp/ directory
vim.lsp.enable({ "basedpyright", "ruff", "lua", "json", "html", "css", "bash" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    import = "plugins",
})

-- Create a session file for each repo opened
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    nested = true,
    callback = function()
        local session_file = vim.fn.getcwd() .. '/.Session.vim'
        if vim.fn.filereadable(session_file) == 1 then
            vim.cmd('source ' .. session_file)
        else
            vim.cmd('mksession! ' .. session_file)
        end
    end,
})
