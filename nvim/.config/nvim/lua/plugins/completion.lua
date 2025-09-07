return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind.nvim",
  },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',

      ["<Tab>"] = {
          function(cmp)
              return cmp.select_next()
          end,
          "snippet_forward",
          "fallback",
      },
      ["<S-Tab>"] = {
          function(cmp)
              return cmp.select_prev()
          end,
          "snippet_backward",
          "fallback",
      },
      ['<C-l>'] = { function(cmp) cmp.show({ providers = { 'omni' } }) end },
    },

    appearance = {
      nerd_font_variant = 'normal'
    },

    completion = {
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { 'source_name', gap = 1 },
            { 'kind_icon', gap = 1 },
            { 'label', 'label_description', gap = 1 },
          },
          components = {
            label_description = {
              width = { max = 110 }
            },
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                        icon = dev_icon
                    end
                else
                    icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                    })
                end

                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            }
          }
        }
      },
      documentation = { auto_show = false }
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
