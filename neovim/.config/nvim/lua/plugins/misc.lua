return { -- a list of misc and small extensions to make life easier
  { 'romainl/vim-cool' }, -- auto clear highlights
  { 'tpope/vim-commentary' }, -- easy comments
  { 'tpope/vim-repeat' }, -- dot repeat for plugins
  { 'tpope/vim-unimpaired' }, -- quick shortcuts
  { 'tpope/vim-surround' }, -- adding brackets around code
  { 'tpope/vim-dispatch' }, -- run jobs asynchronously
  { 'ggandor/lightspeed.nvim' }, -- fast searching
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
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { keys = 'aoeuidhtnspyfgcrlzvwmbxkjq' }
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, {remap=true})
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, {remap=true})
    end
  },
}
