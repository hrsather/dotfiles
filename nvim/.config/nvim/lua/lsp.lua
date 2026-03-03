vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf = args.buf
        local opts = { buffer = buf, silent = true }

        -- Keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

        -- Enable autocompletion if supported
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end

        -- Autoformat on save if not already handled by the server
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
                buffer = buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
