# WindowsにNeovimをインストールする
## 1. Neovim

- [Releases - neovim/neovim - Github](https://github.com/neovim/neovim/releases/)
- PATH追加 `C:\Program Files\Neovim\bin`

## 2. Neovim-GTK

- [Github - daa84/neovim-gtk](https://github.com/daa84/neovim-gtk)

## 3. Python3

- [Python Release Python3.7.1 - Python.org](https://www.python.org/downloads/release/python-371/)

```
C:\> python -m pip install --upgrade pip
C:\> python -m pip install neovim
```

## 4. Neovim設定
### Dein Install

```
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
$ sh ./installer.sh ~/AppData/Local/nvim/dein
```

### init.vim

```vim
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/AppData/Local/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/AppData/Local/nvim/dein')
  call dein#begin('~/AppData/Local/nvim/dein')

  call dein#load_toml('~/AppData/Local/nvim/dein.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" if dein#check_install()
"   call dein#install()
" endif

filetype plugin indent on
syntax enable
```

### dein.toml

```
[[plugins]]
repo = 'Shougo/denite.nvim'

[[plugins]]
repo = 'Shougo/neomru.vim'

[[plugins]]
repo = 'Shougo/deoplete.nvim'

[[plugins]]
repo = 'scrooloose/nerdtree'

[[plugins]]
repo = 'scrooloose/syntastic'
```

### インストール
Neovim起動してからインストール

```vim
call dein#install()
```

