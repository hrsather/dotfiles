return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'zbirenbaum/copilot-cmp',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert {
        ['<tab>'] = cmp.mapping.confirm(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'copilot' },
      },
    }
  end,
}
