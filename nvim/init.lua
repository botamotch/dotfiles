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
vim.o.backupdir = os.getenv("HOME") .. '/.vim/backup'
-- vim.o.pumblend = 30
-- vim.o.termguicolors = true
-- local to window -------------------------------------------------------------
vim.wo.number = true
vim.wo.scroll = 2
vim.wo.wrap = false
-- vim.wo.winblend = 10
-- local to buffer -------------------------------------------------------------
vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.nrformats = "bin,hex"
vim.bo.swapfile = false
-- vim.opt ---------------------------------------------------------------------
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:append('mM')
-- vim.cmd ---------------------------------------------------------------------
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
-- lsp-client ------------------------------------------------------------------
local opts = { noremap=true, silent=true }
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   -- Mappings.
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- end
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- packer ======================================================================
-- You must run `:PackerSync` whenever you make changes to your plugin configuration
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

-- 'nvim-lsp-installer' --------------------------------------------------------
require("nvim-lsp-installer").on_server_ready(function(server)
  local opt = {}
  -- opts.on_attach = on_attach
  server:setup(opt)
end)
-- 'vim-airline/vim-airline' ---------------------------------------------------
vim.cmd 'let g:airline_symbols_ascii = 1'
vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
vim.cmd 'let g:airline#extensions#whitespace#mixed_indent_algo = 1'

-- 'vim-airline/vim-airline-themes' --------------------------------------------
-- vim.cmd 'let g:airline_theme = "dark"'
-- vim.cmd 'let g:airline_theme = "molokai"'
vim.cmd 'let g:airline_theme = "papercolor"'

-- 'airblade/vim-gitgutter' ----------------------------------------------------
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

-- vim-lsp =====================================================================
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
