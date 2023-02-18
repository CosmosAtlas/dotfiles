-- Automatically run :PackerCompile when plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Bootstrap packer.nvim on new installs
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  -- Plugin list
  use 'wbthomason/packer.nvim' -- Package manager

  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'williamboman/nvim-lsp-installer'

  -- Auto complete
  use 'hrsh7th/nvim-cmp'
  -- Completion sources
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-omni'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  -- Functionality enhancements
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require'nvim-tree'.setup{
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }
    end,
  }
  use {
    'folke/trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require'trouble'.setup{}
    end,
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'dstein64/vim-startuptime'
  use 'junegunn/vim-easy-align'
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require'impatient'
    end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup{}
    end,
  }
  use 'romainl/vim-cool'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-dispatch'
  use {
    'lervag/vimtex',
    -- config = 'vim.g.vimtex_compiler_latexmk = {build_dir = "build"}'
  } 
  use 'jpalardy/vim-slime'

  use "ggandor/lightspeed.nvim"
  use 'andymass/vim-matchup'

  -- Language specific
  use "jeetsukumaran/vim-pythonsense"  -- textobjects for python, e.g., func
  use "Vimjas/vim-python-pep8-indent"

  -- Colorschemes
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }
  use 'rafi/awesome-vim-colorschemes'
  use 'monsonjeremy/onedark.nvim'

  -- UI enhancements
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use {
    'nvim-lualine/lualine.nvim', 
    requires = { 'kyazdani42/nvim-web-devicons', opt = true} 
  }
  use 'arkav/lualine-lsp-progress'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'karb94/neoscroll.nvim'
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' } 
  }
  use {
    'goolord/alpha-nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end,
  }
  use {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000'
      })
    end
  }
  use 'mbbill/undotree'
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup{}
    end
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end
  }
  use "numToStr/FTerm.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Needs to be placed after all plugins
  if packer_bootstrap then
    require'packer'.sync()
  end
end)

-- Post Plugin setups

require'catppuccin'.setup({
  transparent_background = true,
})
-- require'onedark'.setup()

require'gitsigns'.setup()

require'telescope'.setup{}

require'neoscroll'.setup()

require'lualine'.setup{
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_c = {
      'lsp_progress'
    }
  }
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {"latex"},
  },
}

require'FTerm'.setup({
  ft = 'FTerm',
  cmd = vim.g.sysop == "win" and "pwsh" or "zsh", -- Use powershell on windows and zsh on other
  border = 'single',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

vim.keymap.set('n', '<A-f>', '<cmd>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-f>', '<cmd>lua require("FTerm").toggle()<CR>')

vim.keymap.set('n', '<A-t>', '<cmd>ToggleTerm<CR>')
vim.keymap.set('t', '<A-t>', '<cmd>ToggleTerm<CR>')


-- Setting up which-key.nvim
local wk = require("which-key")

wk.register({
  b = {
    name = "buffer",
    b = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
    d = { '<cmd>BufferClose<CR> :lua require("notify")("Buffer closed")<CR>', "Close buffer"}
  },
  f = {
    name = "files",
    f = { "<cmd>Telescope find_files<CR>", "Find files" },
    g = { "<cmd>Telescope live_grep<CR>", "Grep in files" }
  },
  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Toggle Trouble workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Toggle Trouble document" },
    q = { "<cmd>TroubleToggle quickfix<CR>", "Toggle Trouble quickfix" },
    l = { "<cmd>TroubleToggle loclist<CR>", "Toggle Trouble loclist" },
    r = { "<cmd>TroubleToggle lsp_references<CR>", "Toggle Trouble references" }
  }
}, { prefix = "<leader>" })

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'omni' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.texlab.setup {
  -- on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
