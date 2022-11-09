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

command! -nargs=0 ExampleHello lua require("example-plugin").myfunc()
