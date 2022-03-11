filetype indent plugin on
syntax enable

" leader as space
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Load plugins
lua require('plugins')

" Basic vim settings

set number
set smartindent
set mouse=a
set hidden

set updatetime=100
set virtualedit=block

set signcolumn=yes

set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set backspace=2

set encoding=utf-8
scriptencoding utf-8

set textwidth=79
set colorcolumn=+1
set formatoptions+=l  " Don't auto break line when I'm already on a long line
set formatoptions+=M  " Better CJK characters support

set foldmethod=marker

set clipboard=unnamedplus

set conceallevel=2

" Fix performance issue related to arabic
if has('arabic')
  set noarabicshape
endif

set termguicolors
set belloff=all

set t_Co=256
set background=dark
colorscheme catppuccin

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

set list
set listchars=tab:▶\ ,eol:¬,trail:·,nbsp:␣


" Keymappings

nnoremap <silent> <Leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <Leader>ep :e $HOME/.config/nvim/lua/plugins.lua<cr>
nnoremap <silent> <Leader>rv :source $MYVIMRC<cr>
