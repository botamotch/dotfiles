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

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.sql" },
  callback = function() vim.opt.expandtab = true end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.go", "*.gd" },
  callback = function() vim.opt.expandtab = false end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.ts", "*.tsx", "*.vue", "*.lua", "*.dart" },
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
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'fern',
  callback = init_fern,
  group = fern_id,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { dir = '~/Git/dotfiles/nvim/example-plugin' },
    -- '~/Git/dotfiles/nvim/hono',

    'neovim/nvim-lspconfig',
    { "nvim-tree/nvim-web-devicons", lazy = true },
    'akinsho/bufferline.nvim',
    'crispgm/nvim-tabline',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'windwp/nvim-autopairs',
    'nvim-lua/plenary.nvim',
    -- 'akinsho/flutter-tools.nvim',
    'ibhagwan/fzf-lua',
    'lambdalisue/fern.vim',
    'rapan931/lasterisk.nvim',
    { 'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate' },
    'APZelos/blamer.nvim',
    'machakann/vim-sandwich',
    'folke/zen-mode.nvim',
    -- 'nvimdev/lspsaga.nvim',
    -- 'simrat39/symbols-outline.nvim',
    -- 'brenoprata10/nvim-highlight-colors',
    -- "princejoogie/tailwind-highlight.nvim",
    -- "L3MON4D3/LuaSnip",
    -- 'vim-denops/denops.vim',
    { "sindrets/diffview.nvim", lazy = true },
    -- "github/copilot.vim",

    {
      "hrsh7th/nvim-cmp",
      lazy = true,
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/vim-vsnip",
      },
    },

    -- colorscheme
    'cocopon/iceberg.vim',
    -- 'nanotech/jellybeans.vim',
    -- 'sainnhe/everforest',
    -- 'rebelot/kanagawa.nvim',
    -- 'ellisonleao/gruvbox.nvim',
    'folke/tokyonight.nvim',
    -- 'tiagovla/tokyodark.nvim',
    -- 'sainnhe/sonokai',
    -- 'svrana/neosolarized.nvim',
    -- 'tjdevries/colorbuddy.nvim',
    'nordtheme/vim',
    'catppuccin/nvim',
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

-- Key map =====================================================================
vim.g.mapleader = " "
-- vim.api.nvim_set_keymap('n', '<leader><leader>', ':<C-u>cd %:h<CR>', {noremap = true})
-- vim.keymap.set('n', '<leader><leader>', ':<C-u>cd %:h<CR>')
vim.keymap.set('n', '<leader><leader>', '<cmd>ZenMode<CR>')
vim.keymap.set('n', '<leader>w', ':<C-u>w<CR>')
vim.keymap.set('n', '<leader>q', ':<C-u>bd<CR>')
vim.keymap.set('n', '<C-l>', ':<C-u>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-h>', ':<C-u>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<A-l>', ':<C-u>BufferLineMoveNext<CR>')
vim.keymap.set('n', '<A-h>', ':<C-u>BufferLineMovePrev<CR>')

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
-- vim.keymap.set('n', '$', 'g$')
-- vim.keymap.set('n', '0', 'g0')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')
vim.keymap.set('v', 'x', '"_x')
-- vim.keymap.set('n', 'd', '"_d')
-- vim.keymap.set('v', 'd', '"_d')
-- vim.keymap.set('n', 'dd', '"_dd')
-- vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set('n', 'M', '%')
-- vim.keymap.set('v', 'y', 'mzy`z')
-- vim.keymap.set('n', 'p', ']p`]')
-- vim.keymap.set('n', 'P', ']P`]')
vim.keymap.set('n', 'd<cr>', ':<C-u>vert Gdiffsplit<cr>')

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
-- vim.keymap.set('n', '<leader>e', "<cmd>lua require('fzf-lua').files({ cmd = 'fd --no-ignore' })<CR>")
vim.keymap.set('n', '<leader>e', "<cmd>FzfLua files<CR>")
vim.keymap.set('n', '<leader>g', "<cmd>FzfLua git_status<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>FzfLua buffers<CR>")
vim.keymap.set('n', '<leader>p', "<cmd>FzfLua grep<CR>")
vim.keymap.set('n', '<leader>/', "<cmd>FzfLua blines<CR>")

vim.keymap.set('n', '<leader>r', "<cmd>FzfLua lsp_references<CR>")
vim.keymap.set('n', '<leader>d', "<cmd>FzfLua lsp_definitions<CR>")
vim.keymap.set('n', '<leader>D', "<cmd>FzfLua lsp_declarations<CR>")
vim.keymap.set('n', '<leader>i', "<cmd>FzfLua lsp_implementations<CR>")
vim.keymap.set('n', '<leader>s', "<cmd>FzfLua lsp_document_symbols<CR>")
vim.keymap.set('n', '<leader>t', "<cmd>FzfLua lsp_typedefs<CR>")
vim.keymap.set('n', '<leader>a', "<cmd>FzfLua lsp_code_actions<CR>")
vim.keymap.set('n', '<leader>l', "<cmd>FzfLua lsp_document_diagnostics<CR>")
vim.keymap.set('n', '<leader>L', "<cmd>FzfLua lsp_workspace_diagnostics<CR>")

-- nb: fzf-lua picker --------------------------------------------------------
local function nb_picker()
  local fzf = require('fzf-lua')
  fzf.fzf_exec('nb list --no-color --no-indicator 2>/dev/null', {
    prompt  = 'nb> ',
    preview =
    "id=$(echo {} | grep -oE '^\\[([^]]+)\\]' | tr -d '[]'); nb show \"$id\" --print 2>/dev/null",
    winopts = { preview = { layout = 'horizontal', vertical = 'flex' } },
    actions = {
      -- Enter: ノートのファイルをバッファで開く
      ['default'] = function(selected)
        if not selected or not selected[1] then return end
        local id = selected[1]:match('^%[([^%]]+)%]')
        if not id then return end
        local path = vim.fn.system('nb show ' .. vim.fn.shellescape(id) .. ' --path'):gsub('\n', '')
        if path and path ~= '' then
          vim.cmd('edit ' .. vim.fn.fnameescape(path))
        end
      end,
      -- Ctrl-V: 垂直分割で開く
      ['ctrl-v'] = function(selected)
        if not selected or not selected[1] then return end
        local id = selected[1]:match('^%[([^%]]+)%]')
        if not id then return end
        local path = vim.fn.system('nb show ' .. vim.fn.shellescape(id) .. ' --path'):gsub('\n', '')
        if path and path ~= '' then
          vim.cmd('vsplit ' .. vim.fn.fnameescape(path))
        end
      end,
      -- Ctrl-N: 新規ノートを作成
      ['ctrl-n'] = function()
        vim.cmd('terminal nb add')
      end,
    },
  })
end
vim.keymap.set('n', '<leader>n', nb_picker, { desc = 'nb: open note' })
-- vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
-- vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>")

vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<CR>')
vim.keymap.set('n', 'gp', '<cmd>Gitsigns preview_hunk<CR>')
vim.keymap.set('n', 'gh', '<cmd>Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gu', '<cmd>Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gb', '<cmd>Gitsigns toggle_current_line_blame<CR>')

-- 'lambdalisue/fern.vim' ------------------------------------------------------
vim.keymap.set('n', '<C-\\>', ':<C-u>Fern . -drawer -toggle -width=50<CR>')
-- 'rapan931/lasterisk.nvim' ---------------------------------------------------
vim.keymap.set('n', '*', function() require("lasterisk").search() end)
vim.keymap.set('n', 'g*', function() require("lasterisk").search({ is_whole = false }) end)
vim.keymap.set('x', 'g*', function() require("lasterisk").search({ is_whole = false }) end)
vim.keymap.set("n", "<A-a>", [[<cmd>ToggleTerm dir='float'<CR>]])
vim.keymap.set("t", "<A-a>", [[<C-\><C-n><cmd>ToggleTerm dir='float'<CR>]])

-- colorscheme -----------------------------------------------------------------
-- vim.g.everforest_enable_italic = 0
-- vim.g.everforest_disable_italic_comment = 1
-- require('neosolarized').setup()
require('catppuccin').setup({
  flavour = "mocha",
  transparent_background = true,
  no_italic = true,
  no_bold = true,
  no_underline = true,
})
require("tokyonight").setup({
  transparent = true,
  style = "storm",
})
vim.cmd [[
" autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
autocmd ColorScheme * highlight link FloatBorder NormalFloat
autocmd ColorScheme * highlight Search guifg=#222240 guibg=#77A0E0

" colorscheme iceberg
" colorscheme nord
" colorscheme neosolarized
" colorscheme everforest
" colorscheme kanagawa
" colorscheme kanagawa-dragon
" colorscheme tokyonight
colorscheme catppuccin-nvim

highlight Comment guifg=#868fB9

highlight LspReferenceText  ctermbg=8 guibg=#305090
highlight LspReferenceRead  ctermbg=8 guibg=#305090
highlight LspReferenceWrite ctermbg=8 guibg=#305090

highlight link LspFloatWinNormal NormalFloat

highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850 gui=bold

highlight GitsignsCurrentLineBlame guifg=#BBBBBB guibg=none
]]

-- LspAttach
-- (1) Keymap
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format {async=true}<CR>', opts)

    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({ border = 'single', separator = true, max_height = 25, max_width = 120 })
    end, opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float({border = "single"})<CR>', opts)
    vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--   end
-- })

-- (2) Highlight Reference
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client:supports_method('textDocument/documentHighlight') then
      return
    end
    vim.cmd [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]]
  end,
})

vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('denols')
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)

-- =============================================================================
-- setup plugins
-- =============================================================================
-- require("lspsaga").setup({
--   lightbulb = {
--     enable = false,
--   },
--   symbol_in_winbar = {
--     enable = false,
--   },
--   outline = {
--     -- layout = 'float',
--     -- max_height = 0.85,
--     win_width = 60,
--     -- win_position = 'left',
--   },
-- })
-- require("symbols-outline").setup()
require('gitsigns').setup()
require("nvim-autopairs").setup({})
require('lualine').setup({
  options = {
    theme = 'iceberg_dark',
    -- theme = 'jellybeans',
  },
})
require("zen-mode").setup({
  window = {
    options = {
      number = false,
    },
  }
})
-- require('nvim-highlight-colors').setup({
--   enable_tailwind = true
-- })
-- require("copilot").setup()

require 'fzf-lua'.setup({'border-fused',
  fzf_opts = { ["--tmux"] = "center,90%,85%", ["--border"] = "sharp" },
  winopts = {
    height  = 0.95,
    width   = 0.90,
    border  = 'single',
    preview = {
      default = 'bat',
    },
  },
  lsp = {
    jump1 = false,
  },
})

require("bufferline").setup({
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    show_close_icon = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },
})

-- nvim-treesitter (main branch, Neovim 0.12+)
-- Parser install: :TSInstall all
require('nvim-treesitter').setup()
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    if ft == '' or ft == 'help' then return end
    pcall(vim.treesitter.start)
  end,
})

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
