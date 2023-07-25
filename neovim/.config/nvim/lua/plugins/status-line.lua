return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'arkav/lualine-lsp-progress'
  },
  config = function()
    require'lualine'.setup {
      options = {
        component_separators = '|',
        section_separators = { left = '', right = '' },
        theme = 'auto',
      },
      sections = {
        lualine_a = {
          {
            'mode',
            icons_enabled = true,
            icon = ' ',
          },
        },
      },
      extensions = {
        'nvim-tree'
      }
    }
  end
}
