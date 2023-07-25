return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require'gitsigns'.setup{} -- lazy unable to detect correct MAIN name
    end
  },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'ntpeters/vim-better-whitespace' },  -- adds red warnings to bad whitespaces
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require'bufferline'.setup {
        options = {
          mode = 'tabs' -- the vim way of using tabs
        }
      }
    end
  },
}
