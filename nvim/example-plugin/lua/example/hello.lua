-- vim.cmd [[
-- if executable('fcitx5')
--   let g:fcitx_state = 1
--   augroup fcitx_savestate
--     autocmd!
--     autocmd InsertLeave * let g:fcitx_state = str2nr(system('fcitx5-remote'))
--     autocmd InsertLeave * call system('fcitx5-remote -c')
--     autocmd InsertEnter * call system(g:fcitx_state == 1 ? 'fcitx5-remote -c': 'fcitx5-remote -o')
--   augroup END
-- endif
-- ]]

local group_name = "IMEStateSave"

local function get_ime_state()
  local f = assert(io.popen('fcitx5-remote', 'r'))
  local s = assert(f:read('*a'))
  f:close()

  s = string.gsub(s, '^%s+', '')     -- remove head space
  s = string.gsub(s, '%s+$', '')     -- remove tail space
  s = string.gsub(s, '[\n\r]+', ' ') -- remove new line

  return s
end

local M = {}

function M.ime_state_save_enable()
  vim.api.nvim_set_var('ime_state', '1')
  vim.api.nvim_create_augroup(group_name, {
    clear = true,
  })

  vim.api.nvim_create_autocmd({"InsertLeave"}, {
    group = group_name,
    callback = function()
      vim.api.nvim_set_var('ime_state', get_ime_state())
      os.execute('fcitx5-remote -c')
    end,
  })

  vim.api.nvim_create_autocmd({"InsertEnter"}, {
    group = group_name,
    callback = function()
      if vim.api.nvim_get_var('ime_state') == '1' then
        os.execute('fcitx5-remote -c')
      else
        os.execute('fcitx5-remote -o')
      end
    end,
  })
end

function M.ime_state_save_disable()
  -- vim.api.nvim_del_var('ime_state')
  vim.api.nvim_create_augroup(group_name, {
    clear = true,
  })
end

function M.ime_state_save_toggle()
  autocommands = vim.api.nvim_get_autocmds({
    group = group_name,
    event = {"InsertEnter", "InsertLeave"},
  })

  if #autocommands == 0 then
    M.ime_state_save_enable()
  else
    M.ime_state_save_disable()
  end
end

return M
