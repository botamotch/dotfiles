" Common =======================================================================
set number
syntax on
colorscheme desert
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set scroll=2
set clipboard+=unnamedplus
set nrformats-=octal
set formatoptions+=mM
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set cmdheight=1
set laststatus=2
set showcmd
set hlsearch
set nowrap

" Dein =========================================================================
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

" Key map ======================================================================
let mapleader = "\<Space>"
" nnoremap <silent> <C-l> :<C-u>tabnext<CR>
" nnoremap <silent> <C-h> :<C-u>tabNext<CR>
nnoremap j gj
nnoremap k gk
nnoremap <silent> <ESC><ESC> :noh<CR>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap \r :!tmux send-keys -t 0:0.0 C-p C-j

" Merlin and ocp-indent ========================================================
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

execute 'set rtp+=' . g:opamshare . '/merlin/vim'
execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'

execute 'helptags ' . g:opamshare . '/merlin/vim/doc'
let g:syntastic_ocaml_chekers = ['merlin']
function! s:ocaml_format()
    let now_line = line('.')
    exec ':%! ocp-indent'
    exec ':' . now_line
endfunction

augroup ocaml_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
augroup END
