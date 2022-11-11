function! example#IMEStateSaveEnable() abort
  if executable('fcitx5-remote')
    let g:fcitx_state = 1
    augroup IMEStateSave
      autocmd!
      autocmd InsertLeave * let g:fcitx_state = str2nr(system('fcitx5-remote'))
      autocmd InsertLeave * call system('fcitx5-remote -c')
      autocmd InsertEnter * call system(g:fcitx_state == 1 ? 'fcitx5-remote -c': 'fcitx5-remote -o')
    augroup END
  endif
endfunction

function! example#IMEStateSaveDisable() abort
  augroup IMEStateSave
    autocmd!
  augroup END
endfunction

function! example#IMEStateSaveToggle() abort
  if !exists('#IMEStateSave#InsertEnter')
    call example#IMEStateSaveEnable()
  else
    call example#IMEStateSaveDisable()
  endif
endfunction
