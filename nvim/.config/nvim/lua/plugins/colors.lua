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
      -- vim.cmd.colorscheme('terafox')
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
  },
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {
    "nyoom-engineering/oxocarbon.nvim"
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = ...,
  },
  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme('kanagawa-wave')
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "vague-theme/vague.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      -- vim.cmd("colorscheme vague")
    end
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = false,
    opts = {
      set_dark_mode = function ()
        vim.cmd.colorscheme('terafox')
      end,
      set_light_mode = function ()
        vim.cmd.colorscheme('dayfox')
      end,
      update_interval = 1500,
      fallback = "dark"
    }
  }
}
