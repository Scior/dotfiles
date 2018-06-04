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

call neobundle#end()

" Required:
filetype plugin indent on

" solarized
let g:solarized_termcolors=256
set background=light
colorscheme solarized
syntax enable

" AutoSaveVim
let g:asv_delay = 500
