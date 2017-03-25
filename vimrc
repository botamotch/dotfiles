" ============== 全体設定 ======================
set number
syntax on
colorscheme delek
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set scroll=2
" クリップボードを共有
set clipboard=unnamedplus,autoselect
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=1
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set backup
set backupdir=$HOME/.backup
set noswapfile
set nowrap

" ============== 各プラグイン設定 ======================
" TeX ファイルを開いたときの折りたたみを OFF
let g:Tex_AutoFolding = 0

" ============== NeoBundle 設定 ======================
" viとの互換性をとらない（vimの独自拡張機能を使う為）
set nocompatible
" ファイル形式の検出を無効化
filetype off
if has('vim_starting')
  " neobudle.vimの関数を呼ぶためにインストールしたディレクトリを指定
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" NeoBundle 管理開始（プラグインインストールディレクトリを指定）
call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundle 自体を管理
NeoBundleFetch 'Shougo/neobundle.vim'
" 管理するプラグイン
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 管理終了
call neobundle#end()
" ファイル形式検出、プラグイン、インデントを ON
filetype plugin indent on
" インストールチェック
NeoBundleCheck

" " ================ Setup for Merlin and ocp-indent ===================
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"
" execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'

" " ================ Setup for raceer and rustfmt ======================
let g:rustfmt_autosave = 1
let g:rustfmt_command = "$HOME/.cargo/bin/rustfmt"
set hidden
let g:racer_command = "$HOME/.cargo/bin/racer"
let $RUST_SRC_PATH = "$HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/racer-2.0.6/src"
