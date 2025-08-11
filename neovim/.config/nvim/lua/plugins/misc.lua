return {                      -- a list of misc and small extensions to make life easier
  { 'romainl/vim-cool' },     -- auto clear highlights
  { 'tpope/vim-commentary' }, -- easy comments
  { 'tpope/vim-repeat' },     -- dot repeat for plugins
  { 'tpope/vim-unimpaired' }, -- quick shortcuts
  { 'tpope/vim-surround' },   -- adding brackets around code
  { 'tpope/vim-dispatch' },   -- run jobs asynchronously
  { 'tommcdo/vim-lion' },     -- alignment with gl commands
  { 'andymass/vim-matchup' }, -- better % matching
  { 'sindrets/diffview.nvim' },
  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = 'tmux'
      vim.cmd [[
        let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
      ]]
    end
  },
  {
    'hanschen/vim-ipython-cell',
    dependencies = { 'jpalardy/vim-slime' }
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {}
    end
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports', },
          java = {},
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "never",
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  },
}
