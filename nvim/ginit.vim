colorscheme desert

if exists('g:GtkGuiLoaded')
  " neovim-gtk =============================================
  call rpcnotify(1, 'Gui', 'Font', 'M+ 1M medium 12')
else
  " neovim-qt ==============================================
  Guifont! M+ 1M medium:h12
endif
