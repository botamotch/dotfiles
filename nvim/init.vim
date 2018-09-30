" ============== Common ======================
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

" ============== Dein ======================
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/syntastic')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('tpope/vim-fugitive')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

" ================ Key map ======================
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 g0
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap <C-c> :lcd %:h<CR>
nnoremap <silent> <ESC><ESC> :noh<CR>

" ============== deoplete ======================
let g:deoplete#enable_at_startup = 1

" ============== Denite ======================
nnoremap [denite] <Nop>
nmap <Space>u [denite]
nnoremap <silent> [denite]u :<C-u>Denite buffer file_mru<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]h :<C-u>Denite file_mru<CR>
" nnoremap <silent> [denite]f :<C-u>DeniteBufferDir -buffer-name=files file file/new<CR>

" ================ Merlin and ocp-indent ===================
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

" ================ Racer and rustfmt ======================
let g:rustfmt_autosave = 1
set hidden

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" ================ jedi-vim ======================
let g:jedi#popup_on_dot=0
let g:jedi#popup_select_first=0
" let g:jedi#show_call_signatures=2
autocmd FileType python setlocal completeopt-=preview

