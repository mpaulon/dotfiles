set runtimepath+=~/.config/vim,~/.config/vim/after
syntax on
filetype plugin indent on

set path+=**
set wildmenu

set modelines=0
set ruler
set wrap
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set encoding=utf-8
set hlsearch

hi Comment ctermfg=LightBlue
hi Search guibg=chartreuse

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:netrw_home="~/.cache/vim"
set viminfo+='1000,n~/.cache/vim/viminfo

" Installation de vim-plug
if empty(glob('~/.config/vim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif




" Plugins
call plug#begin('~/.config/vim/plugged')
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

