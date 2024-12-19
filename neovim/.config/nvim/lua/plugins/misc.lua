return { -- a list of misc and small extensions to make life easier
  { 'romainl/vim-cool' }, -- auto clear highlights
  { 'tpope/vim-commentary' }, -- easy comments
  { 'tpope/vim-repeat' }, -- dot repeat for plugins
  { 'tpope/vim-unimpaired' }, -- quick shortcuts
  { 'tpope/vim-surround' }, -- adding brackets around code
  { 'tpope/vim-dispatch' }, -- run jobs asynchronously
  { 'tommcdo/vim-lion' }, -- alignment with gl commands
  { 'andymass/vim-matchup' }, -- better % matching
  {
    'jpalardy/vim-slime',
    config = function()
      if vim.fn.has('win32') then
        vim.g.slime_target = "neovim"
      else
        vim.g.slime_target = 'tmux'
        vim.cmd[[
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
        ]]
      end
    end
  },
  {
    'hanschen/vim-ipython-cell',
    dependencies = { 'jpalardy/vim-slime' }
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup{}
    end
  },
}
