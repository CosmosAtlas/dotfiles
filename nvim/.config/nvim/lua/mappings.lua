
local map = vim.keymap.set
local wk = require('which-key')

map("n", "<Leader>ed", ':e $MYVIMRC<CR> :echom "Editing $MYVIMRC"<CR>', { silent = true} )



wk.add({
  -- find stuff
  { "<leader>f", group = "find" },
  { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart [F]ind [F]iles" },
  { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
  { "<leader>fsl", function() Snacks.picker.lines() end, desc = "[F]ind [S]earch [L]ines" },
  { "<leader>fsg", function() Snacks.picker.grep() end, desc = "[F]ind [S]earch [G]rep" },
  { "<leader>fp", function() Snacks.picker.pickers() end, desc = "[F]ind [P]ickers" },
  -- toggles
  { "<leader>t", group = "toggle" },
  { "<leader>tu", function() Snacks.picker.undo() end, desc = "[U]ndo History" },
  { "<leader>tc", function() Snacks.picker.colorschemes() end, desc = "[C]olorschemes" },
  { "<leader>tg", function() Snacks.lazygit() end, desc = "lazy[g]it" },
  { "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "[L]SP Definitions / references / ... (Trouble)"},

  -- config related
  { "<leader>ec", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[E]dit [C]onfig" },

  -- lsp
  { "fld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
})
