return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  { "romainl/vim-cool" }, -- auto clear highlights
  { "tpope/vim-commentary" }, -- comment
  { "tpope/vim-repeat" }, -- better . repeat
  { "tpope/vim-unimpaired" }, -- more quick options via ][
  { "tpope/vim-surround" },
  { "tpope/vim-dispatch" },
  { "andymass/vim-matchup" },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  -- TODO need an align plugin
  {
    "stevearc/conform.nvim", -- auto formatting
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          java = {},
          -- c = { 'clang-format' },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "never",
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
