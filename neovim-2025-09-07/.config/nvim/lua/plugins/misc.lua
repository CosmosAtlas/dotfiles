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
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      iron.setup {
        config = {
          scratch_repl = false,
          repl_definition = {
            python = {
              command = { "uv", "run", "ipython", "--no-autoindent", "--no-confirm-exit" },
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
            }
          },
          repl_filetype = function(bufnr, ft)
            return ft
          end,
          repl_open_cmd = view.split.vertical.rightbelow(0.382),
        },
        keymaps = {
          toggle_repl = "<LocalLeader>rr",
          restart_repl = "<LocalLeader>rR",
          send_line = "<LocalLeader>l",
          send_code_block = "<LocalLeader>c",
          visual_send = "<LocalLeader>h",
          exit = "<LocalLeader>rq",
          clear = "<LocalLeader>rl",
        },
        ignore_blank_lines = true,
      }

      vim.keymap.set('n', '<Leader>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<Leader>rh', '<cmd>IronHide<cr>')
    end
  }
}
