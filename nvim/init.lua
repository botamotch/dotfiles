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
-- vim.cmd 'colorscheme default'
vim.cmd 'colorscheme iceberg'
vim.cmd 'highlight Normal ctermbg=none'
vim.cmd 'highlight NonText ctermbg=none'
vim.cmd 'highlight LineNr ctermbg=none'
vim.cmd 'highlight Folded ctermbg=none'
vim.cmd 'highlight EndOfBuffer ctermbg=none '

-- Key map =====================================================================
vim.g.mapleader = " "
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
-- vim.api.nvim_set_keymap('n', '<leader>G', :<C-u>Git log --oneline<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>G', :<C-u>Git commit<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>G', :<C-u>Git push<CR>', {noremap = true})

-- packer ======================================================================
-- You must run `:PackerSync` whenever you make changes to your plugin configuration
require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'cocopon/iceberg.vim'
  -- use 'ibhagwan/fzf-lua'
  -- nvim-cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
end)

-- 'williamboman/nvim-lsp-installer' -------------------------------------------
require("nvim-lsp-installer").on_server_ready(function(server)
  local opt = {}
  opt.on_attach = function(client, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  end
  server:setup(opt)
end)

-- 'hrsh7th/nvim-cmp' ----------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" },
    { name = "snippy" },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.complete(),
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['tsserver'].setup { capabilities = capabilities }
require('lspconfig')['volar'].setup { capabilities = capabilities }
require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }

-- 'vim-airline/vim-airline' ---------------------------------------------------
vim.cmd 'let g:airline_symbols_ascii = 1'
vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
vim.cmd 'let g:airline#extensions#whitespace#mixed_indent_algo = 1'

-- 'vim-airline/vim-airline-themes' --------------------------------------------
-- vim.cmd 'let g:airline_theme = "luna"'
vim.cmd 'let g:airline_theme = "raven"'
-- vim.cmd 'let g:airline_theme = "minimalist"'
-- vim.cmd 'let g:airline_theme = "papercolor"'

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

-- 'junegunn/fzf.vim' ----------------------------------------------------------
vim.cmd "let g:fzf_preview_window = ['right:70%', 'ctrl-/']"

-- vim-lsp =====================================================================
-- :help lsp-method
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { separator = false }
)
-- vim.lsp.util.stylize_markdown()
