set runtimepath+=~/.config/vim,~/.config/vim/after
syntax on
filetype plugin indent on

set path+=**
set wildmenu

set modeline
set modelines=5
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


nnoremap <C-n> :NERDTree %<CR>
" Permet de fermer vim si il ne reste que NERDTree d'ouvert
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "m",
    \ "Staged"    : "s",
    \ "Untracked" : "u",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "D",
    \ "Dirty"     : "X",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : 'i',
    \ "Unknown"   : "?"
    \ }


" On remappe les tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :tabclose<CR>
nnoremap <M-Left> :tabprevious<CR>
nnoremap <M-Right> :tabnext<CR>

" Et les splits
nnoremap <C-s>n :sp<CR>
nnoremap <C-s><S-n> :vsp<CR>
nnoremap <C-s><Up> :<wincmd k<CR>
nnoremap <C-s><Down> :wincmd j<CR>
nnoremap <C-s><Left> :wincmd h<CR>
nnoremap <C-s><Right> : wincmd l<CR>

" Configuration pour ALE
let b:ale_fixers = {
\   '*': [
\       'trim_whitespace', 
\       'remove_trailing_lines', 
\   ],
\   'python': [
\       'trim_whitespace', 
\       'remove_trailing_lines', 
\       'reorder-python-imports'
\   ],
\}
let b:ale_linters = {
\   'python': [
\       'flake8', 
\       'mypy'
\   ]
\}
nnoremap <C-f> :ALEFix<CR>

" Plugins
call plug#begin('~/.config/vim/plugged')
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

