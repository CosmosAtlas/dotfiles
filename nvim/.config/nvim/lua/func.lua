local M = {}

function M.fill_line()
  local line = vim.api.nvim_get_current_line()

  line = line:gsub("%s+$", "")

  local tw = vim.api.nvim_get_option_value("textwidth", { scope = "local" })
  if tw == 0 then
    tw = 80
  end

  line = line .. " "

  local needed = tw - #line
  if needed > 0 then
    line = line .. string.rep("=", needed)
  end

  vim.api.nvim_set_current_line(line)
end

function M.remove_trailing_whitespace()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    -- Remove trailing spaces/tabs
    lines[i] = line:gsub("%s+$", "")
  end

  -- Write back the cleaned lines
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  vim.notify("Trailing whitespace removed!")
end

function M.show_syntax_group()
  local pos = vim.api.nvim_win_get_cursor(0) -- {row, col}
  local row, col = pos[1], pos[2] + 1

  -- Get the highlight group id at cursor
  local id = vim.fn.synID(row, col, 1)
  local trans_id = vim.fn.synIDtrans(id)

  local group_name = vim.fn.synIDattr(id, "name")
  local trans_name = vim.fn.synIDattr(trans_id, "name")

  vim.notify(
    string.format("Syntax group: %s -> %s", group_name, trans_name),
    vim.log.levels.INFO,
    { title = "Highlight Inspector" }
  )
end

return M
