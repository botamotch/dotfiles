local hello = require("example-plugin.hello")

local M = {}

M.ime_state_save_enable  = hello.ime_state_save_enable
M.ime_state_save_disable = hello.ime_state_save_disable
M.ime_state_save_toggle  = hello.ime_state_save_toggle

return M
