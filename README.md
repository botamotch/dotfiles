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

### プラグイン（管理用）
- [Shougo/dein](https://github.com/Shougo/dein.vim)
- [roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc) (Vim only)
- [roxma/nvim-yarp](https://github.com/roxma/nvim-yarp) (Vim only)
  - **Yet Another Remote Plugin Framework for Neovim**
  - "This is my attempt on writing a remote plugin framework without"

### プラグイン（有効）
何が必要で何が不要か整理中。ややこしい
- [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
- [Shougo/denite.nvim](https://github.com/Shougo/denite.nvim)
- [Shougo/neomru.vim](https://github.com/Shougo/neomru.vim)
  - README.mdすらないんだけど使っていいやつなのかな？
- [rust-lang/rust.vim](https://github.com/rust-lang/rust.vim)
- [racer-rust/vim-racer](https://github.com/racer-rust/vim-racer)
- [davidhalter/jedi-vim](https://github.com/davidhalter/jedi-vim)
- [tpope/vim-fugitive](https://github.com/davidhalter/tpope/vim-fugitive)
- [junegunn/goyo.vim](https://github.com/davidhalter/junegunn/goyo.vim)
- [cespare/vim-toml](https://github.com/davidhalter/cespare/vim-toml)
- [vim-airline/vim-airline](https://github.com/davidhalter/vim-airline/vim-airline)
- [vim-airline/vim-airline-themes](https://github.com/davidhalter/vim-airline/vim-airline-themes)
- [dart-lang/dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin)
  - Dart/Flutterの文法エラーチェック、自動フォーマットをやってくれる
  - LSPを適用させて編集中にもチェックしてくれるようにした。設定内容はコピペなのでわからん
  - `export DART_SDK=~/flutter`してPATH通す必要あり
- [prabirshrestha/vim-lsp](https://github.com/prabirshrestha/vim-lsp)
  - いろいろうるさいのをなんとかして黙らせた。面倒くさい……
  - `let g:lsp_diagnostics_signs_enabled = 0` 左側になんか出てくるやつ
  - `let g:lsp_document_code_action_signs_enabled = 0` 左側になんか出てくるやつその２
  - `let g:lsp_document_highlight_enabled = 0` 選択中の変数をハイライトで白くするやつ。見えないんだよ
- [mattn/vim-lsp-settings](https://github.com/mattn/vim-lsp-settings)
  - `prabirshrestha/vim-lsp`の設定をなんかしてくれるやつ
- [lighttiger2505/deoplete-vim-lsp](https://github.com/lighttiger2505/deoplete-vim-lsp)

### プラグイン（無効）
- [w0rp/ale]()
  - linterのエラーを出力するプラグイン
  - `vim-lsp`だけでもALEを代用できるらしい。
- [junegunn/fzf.vim]()
- [Merlin and ocp-indent]()
- [scrooloose/nerdtree]()
- [thosakwe/vim-flutter]()
  - コマンドラインだけで足りてるからまぁいいかなって

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

