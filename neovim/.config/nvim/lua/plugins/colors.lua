return -- colorschemes!
{
  {
    'rafi/awesome-vim-colorschemes',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('OceanicNext')
    end
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('oxocarbon')
    end,
  },
  {
    'ntk148v/komau.vim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('komau')
    end,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('catppuccin-latte')
    end
  },
  {
    'cideM/yui',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('yui')
    end
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
      -- vim.cmd.colorscheme('everforest')
    end
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('terafox')
    end
  },
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
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('tokyonight-day')
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
      vim.cmd.colorscheme('evergarden')
    end
  },
  {
    'savq/melange-nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('melange')
    end
  }
}
