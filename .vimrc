set number
set title
set cursorline
set autoindent
set smartindent
set encoding=utf-8
set showcmd

set tabstop=4
set expandtab
set shiftwidth=4
set backspace=indent,eol,start

set clipboard=unnamed,autoselect

set hlsearch

set history=10000
inoremap jk <ESC>

" NeoBundle
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

call neobundle#end()

" Required:
filetype plugin indent on

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" solarized
syntax enable
set background=dark
colorscheme solarized

augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | execute "%!xxd -r" | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" AutoSaveVim
let g:asv_delay = 500
