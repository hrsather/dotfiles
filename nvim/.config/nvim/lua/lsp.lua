vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf = args.buf
        local opts = { buffer = buf, silent = true }

        -- Keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

        -- Tab to accept completion if menu is visible
        vim.keymap.set("i", "<Tab>", function()
            return vim.fn.pumvisible() == 1 and "<Tab>"
        end, { expr = true, noremap = true })

        -- Enable autocompletion if supported
        if client:supports_method('textDocument/completion') then
            -- Set trigger characters to all printable ASCII characters
            client.server_capabilities.completionProvider.triggerCharacters = {}
            for i = 32, 126 do
                table.insert(client.server_capabilities.completionProvider.triggerCharacters, string.char(i))
            end

            -- Autocommand to trigger completion on every insert-mode text change
            vim.api.nvim_create_autocmd('TextChangedI', {
                buffer = buf,
                callback = function()
                    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
                    local line = vim.api.nvim_get_current_line()
                    local char = line:sub(col, col)
                    -- don't complete on whitespace
                    if char:match("%s") then
                        return
                    end
                    vim.lsp.completion.get()
                end,
            })

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
