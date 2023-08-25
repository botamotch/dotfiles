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
vim.opt.winblend = 8
vim.opt.pumblend = 8
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
  pattern = {"*.sql"},
  callback = function () vim.opt.expandtab = true end
})
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {"*.go"},
  callback = function () vim.opt.expandtab = false end
})
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {"*.ts", "*.tsx", "*.vue", "*.lua", "*.dart"},
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
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-CR>', '<Plug>(fern-action-cd:cursor)', {})
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
  use '~/Git/dotfiles/nvim/example-plugin'
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'crispgm/nvim-tabline'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'
  use 'nvim-lua/plenary.nvim'
  use 'akinsho/flutter-tools.nvim'
  use 'ibhagwan/fzf-lua'
  use 'lambdalisue/fern.vim'
  use 'rapan931/lasterisk.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'APZelos/blamer.nvim'
  use 'machakann/vim-sandwich'
  use 'folke/zen-mode.nvim'
  use 'brenoprata10/nvim-highlight-colors'

  -- nvim-cmp
  use {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
  }

  -- colorscheme
  use {
    'cocopon/iceberg.vim',
    -- 'nanotech/jellybeans.vim',
    -- 'sainnhe/everforest',
    -- 'rebelot/kanagawa.nvim',
    -- 'ellisonleao/gruvbox.nvim',
    -- 'folke/tokyonight.nvim',
    -- 'tiagovla/tokyodark.nvim',
    -- 'sainnhe/sonokai',
    -- 'svrana/neosolarized.nvim',
    -- 'tjdevries/colorbuddy.nvim',
    'nordtheme/vim',
  }
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
vim.keymap.set('n', '<C-W>+', ':<C-u>resize +5<CR>', { silent = true })
vim.keymap.set('n', '<C-W>-', ':<C-u>resize -5<CR>', { silent = true })
vim.keymap.set('n', '<C-W>>', ':<C-u>vertical resize +10<CR>', { silent = true })
vim.keymap.set('n', '<C-W><', ':<C-u>vertical resize -10<CR>', { silent = true })
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>')
-- vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-W>j', '<CMD>wincmd j<CR>')
vim.keymap.set('t', '<C-W>k', '<CMD>wincmd k<CR>')
vim.keymap.set('t', '<C-W>h', '<CMD>wincmd h<CR>')
vim.keymap.set('t', '<C-W>l', '<CMD>wincmd l<CR>')
vim.keymap.set('t', '<C-W>:', '<C-\\><C-n>:<C-u>')

vim.keymap.set('n', '<leader>DD', ':<C-u>diffthis<CR>')
vim.keymap.set('n', '<leader>DO', ':<C-u>bufdo diffoff<CR>')
-- 'ibhagwan/fzf-lua' ----------------------------------------------------------
vim.keymap.set('n', '<leader>e', "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set('n', '<leader>g', "<cmd>lua require('fzf-lua').git_status()<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').git_branches()<CR>")
vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').grep()<CR>")
vim.keymap.set('n', '<leader>/', "<cmd>lua require('fzf-lua').blines()<CR>")

vim.keymap.set('n', '<leader>r', "<cmd>lua require('fzf-lua').lsp_references()<CR>")
vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
vim.keymap.set('n', '<leader>D', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>")
vim.keymap.set('n', '<leader>i', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
vim.keymap.set('n', '<leader>s', "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>")
vim.keymap.set('n', '<leader>t', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>")
vim.keymap.set('n', '<leader>a', "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")
vim.keymap.set('n', '<leader>l', "<cmd>lua require('fzf-lua').diagnostics_document()<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>")

vim.keymap.set('n', ']g', '<cmd>GitGutterNextHunk<CR>', opts)
vim.keymap.set('n', '[g', '<cmd>GitGutterPrevHunk<CR>', opts)
vim.keymap.set('n', 'gp', '<cmd>GitGutterPreviewHunk<CR>', opts)
vim.keymap.set('n', 'gh', '<cmd>GitGutterStageHunk<CR>', opts)
vim.keymap.set('n', 'gu', '<cmd>GitGutterUndoHunk<CR>', opts)
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
vim.keymap.set("n", "<A-a>", [[<cmd>ToggleTerm dir='float'<CR>]])
vim.keymap.set("t", "<A-a>", [[<C-\><C-n><cmd>ToggleTerm dir='float'<CR>]])

-- colorscheme -----------------------------------------------------------------
-- vim.g.everforest_enable_italic = 0
-- vim.g.everforest_disable_italic_comment = 1
-- require('neosolarized').setup()
vim.cmd [[
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
autocmd ColorScheme * highlight link FloatBorder NormalFloat
autocmd ColorScheme * highlight Search guifg=#222240 guibg=#77A0E0

colorscheme iceberg
" colorscheme nord
" colorscheme neosolarized
" colorscheme everforest

highlight LspReferenceText  ctermbg=8 guibg=#305090
highlight LspReferenceRead  ctermbg=8 guibg=#305090
highlight LspReferenceWrite ctermbg=8 guibg=#305090

highlight link LspFloatWinNormal NormalFloat

highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850 gui=bold
]]

-- LspAttach
-- (1) Keymap
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.format {async=true}<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  end,
})

-- (2) Highlight Reference
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.cmd [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]]
  end,
})

my_capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
-- 'williamboman/nvim-lsp-installer'
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  require('lspconfig')[server].setup({
    capabilities = my_capabilities,
  })
end })
-- akinsho/flutter-tools.nvim#full-configuration
require("flutter-tools").setup({
  lsp = {
    capabilities = my_capabilities,
  }
})

require('lspconfig').gopls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').ocamllsp.setup({})
require('lspconfig').denols.setup({})

local border = "single" -- single, rounded , none, shadow, double, solid
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    border = border
  }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    -- :help nvim_open_win() , :help lsp-handlers
    separator = true,
    border = border
    -- width = 100,  -- minimum width みたいなのないかな
    -- :echo winwidth('%') でウィンドウのサイズを取得できる。使えそう
    -- :help winwidth()
  }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)

-- =============================================================================
-- setup plugins
-- =============================================================================
require('gitsigns').setup()
require("nvim-autopairs").setup({})
require('lualine').setup({})
require("zen-mode").setup({})
require('nvim-highlight-colors').setup({
  enable_tailwind = true
})

require'fzf-lua'.setup({
  winopts = {
    height = 0.95,
    width  = 0.90,
    border = 'single',
  },
})

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
      fg = '#fdf6e3',
      bold = true,
      italic = true,
    },
  },
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "help" },
  },
  indent = {
    enable = false,
  },
  ensure_installed = 'all',
}

vim.g.gitgutter_signs = 0

-- 'hrsh7th/nvim-cmp'
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
