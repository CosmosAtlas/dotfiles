return {
  {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
          "mason-org/mason.nvim",
          "neovim/nvim-lspconfig",
          "saghen/blink.cmp",
      },
      config = function()
        -- lsp configuration
        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        default_capabilities.textDocument.completion.completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          deprecatedSupport = true,
          commitCharactersSupport = true,
          tagSupport = { valueSet = { 1 } },
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          },
        }

        -- completion override
        local capabilities = require('blink.cmp').get_lsp_capabilities(default_capabilities)

        -- all lsp configurations
        require("mason-lspconfig").setup {
          ensure_installed = { "pylsp", "lua_ls", "ruff" },
          automatic_installation = false,
          handlers = {
            -- Default handler applied to all servers
            function(server_name)
              require("lspconfig")[server_name].setup {
                capabilities = capabilities,
              }
            end,
          },
        }
      end
  },
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUpdate"
    },
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig").defaults()
    end
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = 'simple',
        signs = {
          diag = "",
        }
      })
      vim.diagnostic.config({ virtual_text = false })  -- explicit disable again
    end
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    config = function()
      require('nvim-navic').setup({
        lsp = {
          auto_attach = true
        }
      })
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Or relative, which means they will be resolved from the plugin dir.
        "lazy.nvim",
        "blink.cmp",
        "${3rd}/luv/library",
        "snacks.nvim",
      },
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
}
