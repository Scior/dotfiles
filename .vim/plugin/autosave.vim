" Vim plugin for auto-saving on idle
" Author: Scior
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_autosave")
  finish
endif
let g:loaded_autosave = 1

set updatetime=1000

au CursorHold,CursorHoldI * nested w

let &cpo = s:save_cpo
unlet s:save_cpo
