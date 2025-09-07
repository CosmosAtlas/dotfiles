return {
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
