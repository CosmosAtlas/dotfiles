return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    -- disable optional field missing diagnostic warning
    ---@diagnostic disable-next-line: missing-fields
    notify.setup({
      stages = "fade_in_slide_out",
      timeout = 1500,
      render = "compact",
    })

    -- Set as global notify
    vim.notify = notify
  end,
}
