" Vim plugin for auto-saving files on idle
" Author: Scior
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_autosave")
  finish
endif
let g:loaded_autosave = 1

" define and set paramaters
function! s:setDefaultValue(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

" save changed buffer
function! s:updateBuffer()
  if @% != ''
    up
  endif
endfunction

" params
call s:setDefaultValue("g:asv_enabled", 1)
call s:setDefaultValue("g:asv_delay", 1000)
call s:setDefaultValue("g:asv_backup", 1)
" call s:setDefaultValue("g:asv_max_size", 2048) " KBytes

" delay for saving
execute ':set updatetime='.g:asv_delay

if g:asv_enabled
  au CursorHold,CursorHoldI * nested call s:updateBuffer()
endif

" backup
if g:asv_backup
  let backup_filename = expand('%').'.~'
  au BufReadPost * nested silent! execute ':w'.backup_filename
  au VimLeavePre * nested call delete(backup_filename)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
