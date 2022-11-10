if !has('nvim-0.8')
    echohl Error
    echomsg "Fzf-lua is only available for Neovim versions 0.8 and above"
    echohl clear
    finish
endif

if exists('g:loaded_example_plugin')
  finish
endif
let g:loaded_example_plugin = 1

lua require("example-plugin").ime_state_save_enable()

command! -nargs=0 IMEStateSaveEnable  lua require("example-plugin").ime_state_save_enable()
command! -nargs=0 IMEStateSaveDisable lua require("example-plugin").ime_state_save_disable()
command! -nargs=0 IMEStateSaveToggle  lua require("example-plugin").ime_state_save_toggle()
