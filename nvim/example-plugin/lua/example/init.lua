local hello = require("example.hello")

win = hello.Window:new()

local M = {}

function M.nvim_open_win()
  h = vim.opt.lines['_value'] - vim.o.cmdheight
  w = vim.o.columns

  vim.api.nvim_open_win(win.bufnr, true, {
    relative='win',
    anchor="NW",
    width=80,    -- ウィンドウの幅
    height=30,   -- ウィンドウの高さ
    col=w-80-5,  -- 右からの距離
    row=h-30-3,  -- 上からの距離
    focusable=true,
  })
end

return M
