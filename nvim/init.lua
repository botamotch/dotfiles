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
vim.opt.updatetime = 500
vim.opt.signcolumn = 'yes'

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {"*.go"},
  callback = function () vim.opt.expandtab = false end
})
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {"*.ts", "*.vue", "*.lua"},
  command = 'set shiftwidth=2',
})
-- vim.api.nvim_create_autocmd({'FileType'}, {
--   pattern = {"typescript", "vue"},
--   command = 'set shiftwidth=2',
-- })
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = 'startinsert',
})
-- vim.cmd 'autocmd FileType vue syntax sync fromstart'
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
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- use 'vim-airline/vim-airline'
  -- use 'vim-airline/vim-airline-themes'
  -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'crispgm/nvim-tabline'
  -- use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'lewis6991/gitsigns.nvim'
  -- use 'dinhhuy258/git.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'
  use 'glepnir/lspsaga.nvim'

  -- colorscheme
  use {
    -- 'cocopon/iceberg.vim',
    -- 'nanotech/jellybeans.vim',
    'sainnhe/everforest',
    -- 'rebelot/kanagawa.nvim',
    -- 'ellisonleao/gruvbox.nvim',
    -- 'folke/tokyonight.nvim',
    -- 'tiagovla/tokyodark.nvim',
    -- 'sainnhe/sonokai',
    use 'svrana/neosolarized.nvim',
    use 'tjdevries/colorbuddy.nvim',
  }

  -- use 'Yggdroot/indentLine'
  use 'ibhagwan/fzf-lua'
  use 'lambdalisue/fern.vim'
  use 'rapan931/lasterisk.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  -- nvim-cmp
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/vim-vsnip"
end)

-- Key map =====================================================================
vim.g.mapleader = " "
-- vim.api.nvim_set_keymap('n', '<leader><leader>', ':<C-u>cd %:h<CR>', {noremap = true})
vim.keymap.set('n', '<leader><leader>', ':<C-u>cd %:h<CR>')
vim.keymap.set('n', '<leader>w', ':<C-u>w<CR>')
vim.keymap.set('n', '<leader>q', ':<C-u>bd<CR>')
vim.keymap.set('n', '<C-l>', ':<C-u>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-h>', ':<C-u>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<A-l>', ':<C-u>BufferLineMoveNext<CR>')
vim.keymap.set('n', '<A-h>', ':<C-u>BufferLineMovePrev<CR>')
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
vim.keymap.set('n', '<leader>e', "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set('n', '<leader>g', "<cmd>lua require('fzf-lua').git_status()<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').git_branches()<CR>")
vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').grep()<CR>")

vim.keymap.set('n', '<leader>r', "<cmd>lua require('fzf-lua').lsp_references()<CR>")
vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
vim.keymap.set('n', '<leader>D', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>")
vim.keymap.set('n', '<leader>i', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
vim.keymap.set('n', '<leader>t', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>")
vim.keymap.set('n', '<leader>a', "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")
vim.keymap.set('n', '<leader>l', "<cmd>lua require('fzf-lua').diagnostics_document()<CR>")

vim.keymap.set('n', 'g]', '<cmd>GitGutterNextHunk<CR>', opts)
vim.keymap.set('n', 'g[', '<cmd>GitGutterPrevHunk<CR>', opts)
vim.keymap.set('n', 'gp', '<cmd>GitGutterPreviewHunk<CR>', opts)
-- 'tpope/vim-fugitive' --------------------------------------------------------
vim.keymap.set('n', '<leader>GG', ':<C-u>Git<CR>')
vim.keymap.set('n', '<leader>GC', ':<C-u>Git commit<CR>')
vim.keymap.set('n', '<leader>GP', ':<C-u>Git push<CR>')
vim.keymap.set('n', '<leader>GL', ':<C-u>Git log --oneline<CR>')
vim.keymap.set('n', '<leader>GD', ':<C-u>vert Gdiffsplit')
-- Gdiffsplit              -- git add する前に変更点を見る
-- Gdiffsplit --cached     -- なんだっけ？？？
-- Gdiffsplit HEAD         -- コミットする前に変更点を見る
-- Gdiffsplit HEAD^        -- 前回コミットとの変更点を見る
-- Gdiffsplit ORIG_HEAD    -- origin/HEADと同じ？？？
-- Gdiffsplit origin/HEAD
-- * ブランチ間の差分がほしい
-- 'lambdalisue/fern.vim' ------------------------------------------------------
vim.keymap.set('n', '<C-\\>', ':<C-u>Fern . -drawer -toggle -width=50<CR>')
-- 'rapan931/lasterisk.nvim' ---------------------------------------------------
vim.keymap.set('n', '*',  function() require("lasterisk").search() end)
vim.keymap.set('n', 'g*', function() require("lasterisk").search({ is_whole = false }) end)
vim.keymap.set('x', 'g*', function() require("lasterisk").search({ is_whole = false }) end)

-- colorscheme -----------------------------------------------------------------
-- vim.g.everforest_enable_italic = 0
-- vim.g.everforest_disable_italic_comment = 1
require('neosolarized').setup()
vim.cmd [[
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none

" colorscheme iceberg
colorscheme neosolarized
" colorscheme everforest

highlight LspReferenceText  ctermbg=8 guibg=#206050
highlight LspReferenceRead  ctermbg=8 guibg=#206050
highlight LspReferenceWrite ctermbg=8 guibg=#206050
]]

-- 'williamboman/nvim-lsp-installer' -------------------------------------------
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    on_attach = function(client, bufnr)
      -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      local opts = { noremap=true, silent=true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K",  "<cmd>Lspsaga hover_doc<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>Lspsaga rename<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

      vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
    end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 'hrsh7th/nvim-cmp' ----------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

-- 'windwp/nvim-autopairs'
require("nvim-autopairs").setup()

-- 'vim-airline/vim-airline' ---------------------------------------------------
-- vim.cmd 'let g:airline_symbols_ascii = 1'
-- vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
-- vim.cmd 'let g:airline#extensions#whitespace#mixed_indent_algo = 1'

require('lualine').setup({
  options = {
    -- theme = 'iceberg_dark',
    theme = 'material',
  }
})
-- require('tabline').setup({})
require("bufferline").setup({
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { '|', ' ' },
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },
  highlights = {
    buffer_selected = {
      guifg = '#fdf6e3',
      gui = "bold",
    },
  },
})

-- 'nvim-treesitter/nvim-treesitter' -------------------------------------------
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  ensure_installed = 'all',
}

-- 'vim-airline/vim-airline-themes' --------------------------------------------
-- vim.g.airline_theme = 'everforest'
-- vim.g.airline_theme = 'jellybeans'

-- 'airblade/vim-gitgutter' ----------------------------------------------------
vim.g.gitgutter_signs = 0
-- vim.g.gitgutter_sign_added    = "|"
-- vim.g.gitgutter_sign_modified = "|"
-- vim.g.gitgutter_sign_removed  = "|"
-- vim.cmd 'highlight GitGutterAdd    guifg=#009900 ctermfg=2'
-- vim.cmd 'highlight GitGutterChange guifg=#bbbb00 ctermfg=3'
-- vim.cmd 'highlight GitGutterDelete guifg=#ff2222 ctermfg=1'
-- vim.cmd 'highlight GitGutterAddLine    guifg=#009900 ctermbg=2'
-- vim.cmd 'highlight GitGutterChangeLine guifg=#bbbb00 ctermbg=3'
-- vim.cmd 'highlight GitGutterDeleteLine guifg=#ff2222 ctermbg=1'
-- vim.cmd 'highlight GitGutterChangeDeleteLine ctermbg='
require('gitsigns').setup()
-- require('git').setup()

-- 'junegunn/fzf.vim' ----------------------------------------------------------
-- vim.cmd "let g:fzf_preview_window = ['right:70%', 'ctrl-/']"

-- 'lambdalisue/fern.vim' ------------------------------------------------------
-- vim.cmd 'let g:fern#default_hidden=1'

-- vim-lsp =====================================================================
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    -- :help nvim_open_win() , :help lsp-handlers
    separator = true,
    border = "none", -- "shadow" , "single", "rounded"
    -- width = 100,  -- minimum width みたいなのないかな
  }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)
