local Window = {}

function Window:new()
  local w = {}

  w.bufnr = vim.api.nvim_create_buf(false, true)

  return w
end

M = {}

M.Window = Window

return M
