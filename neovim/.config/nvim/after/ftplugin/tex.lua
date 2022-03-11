require('cmp').setup.buffer {
  formatting = {
    format = function(entry, vim_item)
        vim_item.menu = ({
          omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          vsnip = "[VS]"
          -- formatting for other sources
          })[entry.source.name]
        return vim_item
      end,
  },
  sources = {
    { name = 'omni', keyword_length = 0 },
    -- { name = 'buffer' },
    { name = 'vsnip' },
    -- { name = 'nvim_lsp'},
    -- other sources
  },
}
