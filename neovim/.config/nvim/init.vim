filetype indent plugin on
syntax enable

" leader as space
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

set completeopt=menu,menuone,noselect

" use a variable to hold the system type
if has('unix')
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname ==? 'Linux'
    let g:sysop='linux'
  elseif (system('uname') ==? "Darwin\n")
    let g:sysop='mac'
  else
    let g:sysop='unix'
  endif
elseif has('win32') || has('win64')
  let g:sysop='win'
else
  let g:sysop='undefined'
endif

" Load plugins
lua require('plugins')

" Additional plugin setups

" vim-vsnip additional setup
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" slime config
let g:slime_target = "neovim"
" let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_python_ipython = 1

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

set splitright
set splitbelow

" Manage backups
if !exists('$VIMHOME')
  if has('win32') || has('win64')
    let $VIMHOME=$HOME.'/vimfiles'
  else
    let $VIMHOME=$HOME.'/.vim'
  endif
endif

set backupdir=$VIMHOME/tmp/backup//
set directory=$VIMHOME/tmp/swap//
set undodir=$VIMHOME/tmp/undo//

set backup swapfile undofile

" Create backup dirs if not exist
for s:dir in [ &backupdir, &directory, &undodir ]
  if !isdirectory(s:dir)
    call mkdir(s:dir, 'p')
  endif
endfor

" Tip from: https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
augroup BackupOnSave
  autocmd BufWritePre * let &bex = '@' . strftime("%F.%H-%M")
augroup END

" Keymappings

" Fast edit/reload for nvim config
nnoremap <silent> <Leader>ed :e $MYVIMRC<CR> :lua require("notify")("Loaded $MYVIMRC")<CR>
nnoremap <silent> <Leader>ep :e `=stdpath('config')..'/lua/plugins.lua'`<CR> :lua require("notify")("Loaded plugins.lua")<CR>
nnoremap <silent> <Leader>rv :source $MYVIMRC<CR> :lua require("notify")("VIMRC reloaded")<CR>

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" File browser
nnoremap <C-t> :NvimTreeFindFileToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" UndoTree
nnoremap <leader>ut :UndotreeToggle<CR>

" Move between splits with alt+mov key
for i in ['h', 'j', 'k', 'l', 'H', 'J', 'K', 'L']
    execute('noremap <A-' . i . '> <C-w>' . i)
    execute('inoremap <A-' . i . '> <Esc><C-w>' . i)
    execute('tnoremap <A-' . i . '> <C-\><C-n><C-w>' . i)
endfor

" Double tap ESC when pannicing
tnoremap <Esc><Esc> <C-\><C-N>
