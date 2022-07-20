-- Common ======================================================================
vim.opt.clipboard = "unnamedplus"
vim.opt.whichwrap = "b,s,[,],<,>"
vim.opt.backspace = "indent,eol,start"
vim.opt.ambiwidth = "single"
vim.opt.wildmenu = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. '/.vim/backup'
vim.opt.winblend = 5
vim.opt.pumblend = 5
vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.scroll = 2
vim.opt.number = true
vim.opt.wrap = false
vim.opt.nrformats = "bin,hex"
vim.opt.swapfile = false
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:append('mM')

-- vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
--   pattern = {"*.ts", "*.vue"},
--   command = 'set shiftwidth=2',
-- })
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = {"typescript", "vue"},
  command = 'set shiftwidth=2',
})
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = 'startinsert',
})
vim.cmd 'autocmd FileType vue syntax sync fromstart'
-- vim.cmd 'autocmd TermOpen * startinsert'
vim.cmd [[
if executable('fcitx5')
  let g:fcitx_state = 1
  augroup fcitx_savestate
    autocmd!
    autocmd InsertLeave * let g:fcitx_state = str2nr(system('fcitx5-remote'))
    autocmd InsertLeave * call system('fcitx5-remote -c')
    autocmd InsertEnter * call system(g:fcitx_state == 1 ? 'fcitx5-remote -c': 'fcitx5-remote -o')
  augroup END
endif
]]
-- function! s:init_fern() abort
--   set nonumber
--   nmap <buffer> <C-h> <Plug>(fern-action-hidden:toggle)
-- endfunction

-- augroup fern-custom
--   autocmd! *
--   autocmd FileType fern call s:init_fern()
-- augroup END
-- ]]

local init_fern = function()
  vim.opt.number = false
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', '<Plug>(fern-action-hidden:toggle)', {})
end
local fern_id = vim.api.nvim_create_augroup('fern-custom', {})
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = 'fern',
  callback = init_fern,
  group = fern_id,
})

-- packer ======================================================================
-- You must run `:PackerSync` whenever you make changes to your plugin configuration
require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  -- use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'cocopon/iceberg.vim'
  -- use 'Yggdroot/indentLine'
  use 'ibhagwan/fzf-lua'
  use 'lambdalisue/fern.vim'
  -- nvim-cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/vim-vsnip"
end)

-- Key map =====================================================================
vim.g.mapleader = " "
-- vim.api.nvim_set_keymap('n', '<leader><leader>', ':<C-u>cd %:h<CR>', {noremap = true})
vim.keymap.set('n', '<leader><leader>', ':<C-u>cd %:h<CR>')
vim.keymap.set('n', '<leader>w', ':<C-u>w<CR>')
vim.keymap.set('n', '<leader>q', ':<C-u>bd<CR>')
vim.keymap.set('n', '<C-l>', ':<C-u>bnext<CR>')
vim.keymap.set('n', '<C-h>', ':<C-u>bprevious<CR>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-W>j', '<CMD>wincmd j<CR>')
vim.keymap.set('t', '<C-W>k', '<CMD>wincmd k<CR>')
vim.keymap.set('t', '<C-W>h', '<CMD>wincmd h<CR>')
vim.keymap.set('t', '<C-W>l', '<CMD>wincmd l<CR>')
-- 'ibhagwan/fzf-lua' ----------------------------------------------------------
-- TODO :help fzf-lua でめちゃめちゃ役に立ちそうなコマンドを見つけたので調べておくこと
vim.keymap.set('n', '<leader>e', "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set('n', '<leader>g', "<cmd>lua require('fzf-lua').git_status()<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').git_branches()<CR>")
vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').live_grep()<CR>")
-- vim.keymap.set('n', '<leader>h', "<cmd>lua require('fzf-lua').oldfiles()<CR>")
-- vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>")
vim.keymap.set('n', '<leader>l', "<cmd>lua require('fzf-lua').lsp_references()<CR>")
-- vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
-- vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_decralations()<CR>")
vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').diagnostics_document()<CR>")
-- 'tpope/vim-fugitive' --------------------------------------------------------
vim.keymap.set('n', '<leader>GG', ':<C-u>Git<CR>')
vim.keymap.set('n', '<leader>GC', ':<C-u>Git commit<CR>')
vim.keymap.set('n', '<leader>GP', ':<C-u>Git push<CR>')
vim.keymap.set('n', '<leader>GL', ':<C-u>Git log --oneline<CR>')
vim.keymap.set('n', '<leader>GD', ':<C-u>vert Gdiffsplit !~1')
-- とりあえず下記３パターンのDIFFがほしい
-- * 編集中のファイルの差分
-- * N個前のコミット分との差分
-- * ブランチ間の差分
-- 'lambdalisue/fern.vim' ------------------------------------------------------
vim.keymap.set('n', '<C-\\>', ':<C-u>Fern . -drawer -toggle -width=50<CR>')

-- colorscheme -----------------------------------------------------------------
vim.cmd 'autocmd ColorScheme * highlight Normal ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight NonText ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight Folded ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none'
-- vim.cmd 'colorscheme default'
vim.cmd 'colorscheme iceberg'

-- 'williamboman/nvim-lsp-installer' -------------------------------------------
require("nvim-lsp-installer").on_server_ready(function(server)
  local opt = {
    on_attach = function(client, bufnr)
      -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      local opts = { noremap=true, silent=true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  server:setup(opt)
end)

-- 'hrsh7th/nvim-cmp' ----------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    -- documentation = {
    --   border = "none",
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    --   separator = false,
    -- },
    -- completion = {
    --   border = "none",
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    --   separator = false,
    -- },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" },
    { name = "snippy" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-l>"] = cmp.mapping.complete(),
    -- ["<C-c>"] = cmp.mapping {
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- },
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

-- 'vim-airline/vim-airline' ---------------------------------------------------
vim.cmd 'let g:airline_symbols_ascii = 1'
vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
vim.cmd 'let g:airline#extensions#whitespace#mixed_indent_algo = 1'

-- 'vim-airline/vim-airline-themes' --------------------------------------------
-- vim.cmd 'let g:airline_theme = "luna"'
-- vim.cmd 'let g:airline_theme = "iceberg"'
-- vim.cmd 'let g:airline_theme = "raven"'
-- vim.cmd 'let g:airline_theme = "minimalist"'
-- vim.cmd 'let g:airline_theme = "papercolor"'
vim.g.airline_theme = 'iceberg'

-- 'airblade/vim-gitgutter' ----------------------------------------------------
vim.cmd 'let g:gitgutter_sign_added = "+"'
vim.cmd 'let g:gitgutter_sign_modified = "^"'
vim.cmd 'let g:gitgutter_sign_removed = "-"'
vim.cmd 'highlight GitGutterAdd    guifg=#009900 ctermfg=2'
vim.cmd 'highlight GitGutterChange guifg=#bbbb00 ctermfg=3'
vim.cmd 'highlight GitGutterDelete guifg=#ff2222 ctermfg=1'
vim.cmd 'highlight GitGutterAddLine    guifg=#009900 ctermbg=2'
vim.cmd 'highlight GitGutterChangeLine guifg=#bbbb00 ctermbg=3'
vim.cmd 'highlight GitGutterDeleteLine guifg=#ff2222 ctermbg=1'
-- vim.cmd 'highlight GitGutterChangeDeleteLine ctermbg='

-- 'junegunn/fzf.vim' ----------------------------------------------------------
-- vim.cmd "let g:fzf_preview_window = ['right:70%', 'ctrl-/']"

-- 'lambdalisue/fern.vim' ------------------------------------------------------
-- vim.cmd 'let g:fern#default_hidden=1'

-- vim-lsp =====================================================================
-- local config = {
--   virtual_text = false,
--   update_in_insert = true,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = true,
--     style = "minimal",
--     border = "none",
--     source = "always",
--     header = "",
--     prefix = "",
--     separator = true,
--   },
-- }
-- vim.diagnostic.config(config)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { separator = true }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)
