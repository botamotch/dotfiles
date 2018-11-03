# 各種設定ファイル保存用リポジトリ

## Vim / Neovim設定
- vimrc / init.vim
- gvimrc / ginit.vim

### キーマップ
- Leaderキー `<Space>`
- denite `<Space>-u`
- fugitive `<Space>-g`

### プラグイン

- [Shougo/dein]()
- [Shougo/deoplete.nvim]()
- [Shougo/denite.nvim]()
- [Shougo/neomru.vim]()
- [rust-lang/rust.vim]()
- [racer-rust/vim-racer]()
- [scrooloose/nerdtree]()
- [scrooloose/syntastic]()
- [davidhalter/jedi-vim]()
- [tpope/vim-fugitive]()
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

