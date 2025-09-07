  return {
    'goolord/alpha-nvim', -- Start page
    event = 'VimEnter',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('alpha').setup(require'alpha.themes.startify'.config)
    end,
  }
