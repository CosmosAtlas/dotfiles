local wk = require('which-key')

wk.register({
  b = {
    name = 'buffer',
    b = { '<cmd>Telescope buffers<CR>', 'Switch buffer' },
    d = { '<cmd>bdelete<CR>', 'Close buffer'},
  },
  e = {
    name = 'edit',
    nf = { function() require('telescope.builtin').find_files( { cwd = vim.fn.stdpath('config') } ) end, 'nvim configs' },
    nb = { '<cmd>Telescope file_browser path=' .. vim.fn.stdpath('config') .. '<CR>', 'nvim configs browse' },
  },
  f = {
    name = 'files',
    f = { '<cmd>Telescope find_files<CR>', 'Find files' },
    g = { '<cmd>Telescope live_grep<CR>', 'Grep in files' },
    h = { '<cmd>Telescope undo<CR>', 'Grep in undo history' },
    b = { '<cmd>Telescope file_browser<CR>', 'File Browser' },
  },
  t = {
    name = 'toggle',
    u = { '<cmd>UndotreeToggle<CR>', 'Undo tree'  },
    c = { '<cmd>Telescope colorscheme<CR>', 'Change color' },
  },
 x = {
   name = 'Trouble',
   x = { '<cmd>TroubleToggle<CR>', 'Toggle Trouble' },
   w = { '<cmd>TroubleToggle workspace_diagnostics<CR>', 'Toggle Trouble workspace' },
   d = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Toggle Trouble document' },
   q = { '<cmd>TroubleToggle quickfix<CR>', 'Toggle Trouble quickfix' },
   l = { '<cmd>TroubleToggle loclist<CR>', 'Toggle Trouble loclist' },
   r = { '<cmd>TroubleToggle lsp_references<CR>', 'Toggle Trouble references' },
 }
}, { prefix = '<leader>' })
