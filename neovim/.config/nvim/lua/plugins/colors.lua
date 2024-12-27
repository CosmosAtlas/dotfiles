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
      vim.cmd.colorscheme('oxocarbon')
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
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('tokyonight-day')
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
