local wk = require('which-key')

wk.add({
  -- files
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files", mode = "n" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep in files", mode = "n" },
  { "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "File browser", mode = "n" },
  -- buffers
  { "<leader>b", group = "buffer" }, -- group
  { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "Switch buffer", mode = "n" },
  { "<leader>bd", "<cmd>bdelete<CR>", desc = "Close buffer", mode = "n" },
  -- init files
  { "<leader>e", group = "edit" }, -- group
  { "<leader>enf", function() require('telescope.builtin').find_files( { cwd = vim.fn.stdpath('config') } ) end, desc = "nvim configs", mode = "n" },
  -- toggles
  { "<leader>t", group = "edit" }, -- group
  { "<leader>tu", "<cmd>UndotreeToggle<CR>", desc = "Undo tree", mode = "n" },
  { "<leader>tc", "<cmd>Telescope colorscheme<CR>", desc = "Change color", mode = "n" },
})
