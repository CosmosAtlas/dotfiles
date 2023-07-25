return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup({
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<C-d>'] = require('telescope.actions').delete_buffer
              }
            }
          }
        }
      })
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('telescope').load_extension('file_browser')
    end
  },
}
