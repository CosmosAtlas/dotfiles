return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          section_separators = '',
          component_separators = ''
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '' },
              right_padding = 2
            }
          },
          lualine_b = {
            'branch',
            {
              'diff',
              symbols = { added = ' ', modified = '󰝤 ', removed = ' ' }
            },
          },
          lualine_c = {
            '%=', --[[ add your center components here in place of this comment ]]
          },
          lualine_x = {
            {
              'lsp_status',
              icon = '', -- f013
              symbols = {
                -- Standard unicode symbols to cycle through for LSP progress:
                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                -- Standard unicode symbol for when LSP is done:
                done = '✓',
                -- Delimiter inserted between LSP names:
                separator = ' ',
              },
              -- List of LSP names to ignore (e.g., `null-ls`):
              ignore_lsp = {},
            },
            'diagnostics'
          },
          lualine_y = { 'filetype' },
          lualine_z = {
            { '%p%%/%L', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      })
    end

  },
  {
    "b0o/incline.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'SmiteshP/nvim-navic',
    },
    config = function()
      local helpers = require 'incline.helpers'
      local navic = require 'nvim-navic'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local res = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
          }
          if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(res, {
                { ' > ', group = 'NavicSeparator' },
                { item.icon, group = 'NavicIcons' .. item.type },
                { item.name, group = 'NavicText' },
              })
            end
          end
          table.insert(res, ' ')
          return res
        end,
      }
    end
  }
}
