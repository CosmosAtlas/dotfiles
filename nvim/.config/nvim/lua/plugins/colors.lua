return {
  {
    'webhooked/kanso.nvim',
    priority = 1000,
    config = function()
      require('kanso').setup({
        theme = 'mist',
      })
      -- vim.cmd.colorscheme('kanso')
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme('carbonfox')
    end
  },
  {
    'everviolet/nvim', name = 'evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = 'spring', -- 'winter'|'fall'|'spring'|'summer'
        accent = 'green',
      },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          invert_border = false,
        },
        completion = {
          color = 'surface0',
        },
      },
    },
    config = function()
      -- vim.cmd.colorscheme('evergarden')
    end
  }
}
