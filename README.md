# 各種設定ファイル保存用リポジトリ

## Vim / Neovim設定
- vimrc / init.vim
- gvimrc / ginit.vim

### dein install
```
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
```

### 共存
- dein
  - `~/.cache/dein/repos/github.com/Shougo/dein.vim`
- Vim config
  - `~/.vim/vimrc`
  - `~/.vim/gvimrc`
  - `~/.vim/dein.toml`
- Neovim config
  - `~/.config/nvim/init.vim` -> `~/.vim/vimrc`
  - `~/.config/nvim/ginit.vim`
  - `~/.config/nvim/dein.toml` -> `~/.vim/dein.toml`

### Neovimでクリップボードを使う
- `init.vim`に`clipbooard+=unnamedplus`を追加
- `xclip` or `xsel`をインストール

### Vim置換
- `:%s/hoge/fuga/g` ファイル内の単語を一括置換
- `:%s/hoge/fuga/gc` ファイル内の単語を確認しながら置換
- `:10,20s/hoge/fuga/gc` 行を指定して置換

### キーマップ
- basic
  - `nnoremap <silent> <C-l> :<C-u>bnext<CR>`
  - `nnoremap <silent> <C-h> :<C-u>bprevious<CR>`
  - `nnoremap j gj`
  - `nnoremap k gk`
  - `inoremap <silent> jj <ESC>`
  - `nnoremap <silent> <ESC><ESC> :noh<CR>`
- Leader `let mapleader = "\<Space>"`
  - `<leader><leader> V`
  - `<leader>w :<C-u>w<CR>`
  - `<leader>q :<C-u>bd<CR>`
  - `<leader>r :<C-u>call RepeatTerm()<CR>`
- denite `nmap <Space>-u`
  - `[denite]u :<C-u>Denite buffer file_mru<CR>`
  - `[denite]b :<C-u>Denite buffer<CR>`
  - `[denite]h :<C-u>Denite file_mru<CR>`
  - `[denite]g :<C-u>Denite file<CR>`
  - `[denite]f :<C-u>DeniteBufferDir file<CR>`
- fugitive `nmap <Space>-g`
  - `[fugitive]s :Gstatus<CR>`
  - `[fugitive]a :Gwrite<CR>`
  - `[fugitive]c :Gcommit-v<CR>`
  - `[fugitive]b :Gblame<CR>`
  - `[fugitive]d :Gdiff<CR>`
  - `[fugitive]m :Gmerge<CR>`
- vim-racer
  - completion: `<C-x><C-o>`
  - `au FileType rust nmap gd <Plug>(rust-def)`
  - `au FileType rust nmap gs <Plug>(rust-def-split)`
  - `au FileType rust nmap gx <Plug>(rust-def-vertical)`
  - `au FileType rust nmap <leader>gd <Plug>(rust-doc)`
- jedi-vim
  - `let g:jedi#goto_assignments_command = "<leader>g"`
  - `let g:jedi#goto_command = "<leader>d"`
  - `let g:jedi#goto_definitions_command = ""`
  - `let g:jedi#documentation_command = "K"`
  - `let g:jedi#usages_command = "<leader>n"`
  - `let g:jedi#completions_command = "<C-Space>"`
  - `let g:jedi#rename_command = "<leader>n"`
- merlin
  - completion: `<C-x><C-o>`

### プラグイン
- [Shougo/dein]()
- [Shougo/deoplete.nvim]()
- [roxma/vim-hug-neovim-rpc]() (Vim only)
- [roxma/nvim-yarp]() (Vim only)
- [Shougo/denite.nvim]()
- [Shougo/neomru.vim]()
- [rust-lang/rust.vim]()
- [racer-rust/vim-racer]()
- [scrooloose/nerdtree]()
- [w0rp/ale]()
- [davidhalter/jedi-vim]()
- [tpope/vim-fugitive]()
- [junegunn/goyo.vim]()
- [cespare/vim-toml]()
- [junegunn/fzf.vim]()
- [vim-airline/vim-airline]()
- [vim-airline/vim-airline-themes]()
- [Merlin and ocp-indent]()

### フォント設定
Neovim-Gtkは使用するPCでコンパイルしないとフォントが認識されない？要確認。

- gvim
  - `set guifont=M+\ 1M\ medium\ 11`
- neovim-gtk
  - `call rpcnotify(1, 'Gui', 'Font', 'M+ 1M medium 12')`
- neovim-qt
  - `Guifont! M+ 1M medium:h12`

## tmux
- tmux.conf

## zsh
- zshrc
- zshenv

## xprofile
- xprofile

## fonts.conf

