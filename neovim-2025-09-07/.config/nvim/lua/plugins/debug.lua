return -- colorschemes!
{
  {
    'mfussenegger/nvim-dap',
    config = function()
      -- vim.cmd.colorscheme('melange')
    end
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim'
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {'python'},
        handlers = {},
      })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
    end
  },
}

