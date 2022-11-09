# Example Plugin

Neovimプラグイン

フォルダの構成はこんな感じ。
最小構成なら `plugin/example-plugin.vim` と `lua/example-plugin/init.lua` だけで動く。

```
├── README.md
├── LICENSE
├── doc
│  └── example-plugin.txt
├── plugin
│  └── example-plugin.vim
├── lua
│  └── example-plugin
│     ├── init.lua
│     ├── config.lua
│     └── util.lua
├── scripts
│  ├── init.lua
│  ├── mini.sh
│  └── minimal_init.lua
└── tests
   ├── init_spec.lua
   └── minimal_init.vim

```

## plugin/example-plugin.vim
```vim
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
```

## lua/example-plugin/init.lua
```lua
local M = {}

M.myfunc = function() print('hello by lua!') end

return M
```

