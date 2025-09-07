return {
  'lervag/vimtex',
  config = function()
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull',
      'Overfull'
    }
    if vim.loop.os_uname().sysname == 'Linux' then
      vim.g.latex_view_general_viewer = 'zathura'
      vim.g.vimtex_view_method = 'zathura'
    end
  end
}
