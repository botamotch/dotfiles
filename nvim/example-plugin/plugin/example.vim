if !has('nvim-0.7')
    echohl Error
    echomsg "Fzf-lua is only available for Neovim versions 0.7 and above"
    echohl clear
    finish
endif

if exists('g:loaded_example_plugin')
  finish
endif
let g:loaded_example_plugin = 1

call example#IMEStateSaveEnable()

command! IMEStateSaveEnable  call example#IMEStateSaveEnable()
command! IMEStateSaveDisable call example#IMEStateSaveDisable()
command! IMEStateSaveToggle  call example#IMEStateSaveToggle()

command! -nargs=0 ExampleOpenWin  lua require("example").nvim_open_win()
