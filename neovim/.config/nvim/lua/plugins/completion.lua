return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.api.nvim_command, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'saadparwaiz1/cmp_luasnip'},
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end
    },     -- Required
  },
  config = function()
    -- LSP setup
    local lsp = require'lsp-zero'.preset{}

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    lsp.nvim_workspace()
    lsp.setup()

    -- completion setup
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()

    cmp.setup({
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<C-l>'] = cmp_action.luasnip_jump_forward(),
        ['<C-h>'] = cmp_action.luasnip_jump_backward(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'omni' },
        { name = 'buffer' },
      }
    })
  end
}

