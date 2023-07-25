return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TSUpdateSync' },
  config = function()
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true ,
        disable = {"latex"}
      },
      ensure_installed = {
        'bash',
        'c',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'vim',
        'vimdoc',
        'yaml'
      }
    }
  end,
}
