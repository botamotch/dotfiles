-- Common ======================================================================
-- global
vim.o.clipboard = "unnamedplus"
vim.o.whichwrap = "b,s,[,],<,>"
vim.o.backspace = "indent,eol,start"
vim.o.ambiwidth = "double"
vim.o.wildmenu = true
vim.o.cmdheight = 1
vim.o.laststatus = 2
vim.o.showcmd = true
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.backup = true
vim.o.backupdir = "~/.vim/backup"
-- vim.o.pumblend = 30
-- vim.o.termguicolors = true
-- local to window
vim.wo.number = true
vim.wo.scroll = 2
vim.wo.wrap = false
-- vim.wo.winblend = 10
-- local to buffer
vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.nrformats = "bin,hex"
vim.bo.swapfile = false
-- vim.cmd
vim.cmd 'set formatoptions-=tc'
vim.cmd 'set formatoptions+=mM'
vim.cmd 'colorscheme delek'

-- Key map =====================================================================
vim.cmd 'let mapleader = " "'
vim.api.nvim_set_keymap('n', '<leader><leader>', ':<C-u>cd %:h<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>w', ':<C-u>w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':<C-u>bd<CR>', {noremap = true})
vim.api.nvim_set_keymap('n',  '<C-l>', ':<C-u>bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n',  '<C-h>', ':<C-u>bprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('i',  'jj', '<ESC>', {silent=true})
vim.api.nvim_set_keymap('n',  '<ESC><ESC>', ':nohlsearch<CR>', {silent=true})
-- vim.api.nvim_set_keymap('t',  '<esc>', '<C-\><C-n>')
-- 'junegunn/fzf.vim' ----------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>e', ':<C-u>Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>g', ':<C-u>GFiles?<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', ':<C-u>Rg<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>h', ':<C-u>History<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':<C-u>Buffer<CR>', {noremap = true})
-- 'tpope/vim-fugitive' --------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>G', ':<C-u>Git<CR>', {noremap = true})

-- packer ======================================================================
-- require("packer").sync()
require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
end)

-- nvim-lsp-installer
require("nvim-lsp-installer").on_server_ready(function(server)
  opt = {}
  server:setup(opt)
end)
-- 'vim-airline/vim-airline'
vim.cmd 'let g:airline_symbols_ascii = 1'
vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
vim.cmd 'let g:airline#extensions#whitespace#mixed_indent_algo = 1'

-- 'vim-airline/vim-airline-themes'
-- vim.cmd 'let g:airline_theme = "dark"'
-- vim.cmd 'let g:airline_theme = "molokai"'
vim.cmd 'let g:airline_theme = "papercolor"'

-- 'airblade/vim-gitgutter'
vim.cmd 'let g:gitgutter_sign_added = "+"'
vim.cmd 'let g:gitgutter_sign_modified = "^"'
vim.cmd 'let g:gitgutter_sign_removed = "-"'
vim.cmd 'highlight GitGutterAdd    guifg=#009900 ctermfg=2'
vim.cmd 'highlight GitGutterChange guifg=#bbbb00 ctermfg=3'
vim.cmd 'highlight GitGutterDelete guifg=#ff2222 ctermfg=1'
vim.cmd 'highlight GitGutterAddLine          ctermbg=2'
vim.cmd 'highlight GitGutterChangeLine       ctermbg=3'
vim.cmd 'highlight GitGutterDeleteLine       ctermbg=1'
-- vim.cmd 'highlight GitGutterChangeDeleteLine ctermbg='
