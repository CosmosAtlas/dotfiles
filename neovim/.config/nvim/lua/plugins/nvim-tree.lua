return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {}
      }
    }
    vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeFindFile<CR>', { silent = true, noremap = true })
  end,
}
