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
set backupdir=~/.backup
set noswapfile
set nowrap

" ============== Dein ======================
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))
  call dein#begin(expand('~/.vim/dein'))

  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('vim-latex/vim-latex')
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('scrooloose/nerdtree')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" ============== Key map ======================
nnoremap <C-\> :NERDTreeToggle<CR>

nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]h :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>

" ============== Vim-LaTeX ======================
let g:Tex_AutoFolding = 0

" " ================ Merlin and ocp-indent ===================
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute 'set rtp+=' . g:opamshare . '/merlin/vim'
" execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'

" " ================ Racer and rustfmt ======================
let g:rustfmt_autosave = 1
let g:rustfmt_command = '~/.cargo/bin/rustfmt'
set hidden
let g:racer_command = '~/.cargo/bin/racer'
let $RUST_SRC_PATH = '~/.cargo/registry/src/github.com-1ecc6299db9ec823/racer-2.0.6/src'

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

