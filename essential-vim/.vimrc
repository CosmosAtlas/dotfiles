" vim: set foldmethod=marker foldlevel=0 nomodeline:
" =============================================================================
" Essential .vimrc of Wenhan Zhu (Cosmos) {{{
" =============================================================================
" The goal of this essential version is to not rely on external resources such
" as Python. Normally, it is not an issue, however, completion engines are the
" worst in this situation... (sadly).

set nocompatible

filetype indent plugin on
syntax enable

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" }}}
" =============================================================================
" VIM-PLUG Block {{{
" =============================================================================

" Auto install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source '~/.vimrc'
endif

call plug#begin('~/.vim/plugged')

" More useful status line at bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1


" better highlighting for searches
Plug 'romainl/vim-cool'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1  " Enable at default


" Fancy start page
Plug 'mhinz/vim-startify'
let g:startify_bookmarks = [
      \ {'v': '~/.vimrc'},
      \ {'z': '~/.zshrc'},
      \ ]
let g:startify_ascii = [
      \ '┐ ┬o┌┌┐  ┬─┐┌┐┐┐ ┬',
      \ '│┌┘││││  ├─  │ │││',
      \ '└┘ ┆┘ ┆  ┆   ┆ └┴┆',
      \ ]
let g:startify_custom_header = g:startify_ascii


Plug 'Yggdroot/indentLine'
let g:indentLine_enable = 1
let g:indentLine_concealcursor = ''
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['help', 'startify']
let g:indentLine_leadingSpaceChar = '·'


" Show git diff marks
Plug 'mhinz/vim-signify'


" vim colorschemes
Plug 'lifepillar/vim-gruvbox8'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'

"
" Functionality
"
Plug 'mbbill/undotree'
nnoremap <leader>ut :UndotreeToggle<CR>

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'junegunn/vim-peekaboo'

" visualize subsitute
Plug 'markonm/traces.vim'


Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 0
let delimitMate_nesting_quotes = ['"', '`']


" better handle of open in browser
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " Disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Change enclosings
Plug 'tpope/vim-surround'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" more text objects
Plug 'kana/vim-textobj-user' " Required by the following plugins to easily create text objects
Plug 'kana/vim-textobj-line'  " For selecting lines
Plug 'preservim/vim-textobj-sentence'  " For selecting sentences
Plug 'sgur/vim-textobj-parameter'  " For selecting function arguments

augroup textobj_sentence
  autocmd! FileType markdown,tex,mail,textile,text call textobj#sentence#init()
augroup END


" Provide hints to shortcuts
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
" Key mapping see [Key Mappings] part

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Simple autocompletion

Plug 'https://git.sr.ht/~ackyshake/VimCompletesMe.vim'

call plug#end()

" Plug-in settings that needs to be called after plug#end
call which_key#register('<Space>', 'g:which_key_map')

" }}}
" =============================================================================
" Basic Settings {{{
" =============================================================================
set number            " always show line numbers
set smartindent       " better indendation
set mouse=a           " allow mouse operations
set hidden            " allow switching buffers without saving

set updatetime=100
set virtualedit=block

set signcolumn=yes

set tabstop=2         " Default to 4 space tabs
set shiftwidth=2
set expandtab         " Replace tabs with spaces
set cursorline        " Highlight current line


set encoding=utf-8    " Use unicode as default encoding
scriptencoding utf-8

set textwidth=79      " Auto change to next line at column 80
set colorcolumn=+1    " Highlight column 81 to warn about line width
set formatoptions+=l  " Don't auto break line when I'm already on a long line
set formatoptions+=M  " Better format for CJK characters

set foldmethod=marker
set conceallevel=2

" Do not aggresive redraw when pasting large text
if has('arabic')
  set noarabicshape
endif

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

set list
set listchars=tab:▶\ ,eol:¬,trail:·,nbsp:␣

set splitright
set splitbelow

set history=200

" Exclude CJK characters from spell checks
set spelllang+=cjk

" Auto reload $MYVIMRC after modifying and saving
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $HOME/.vimrc nested source $HOME/.vimrc
augroup END

"
" Colors
"
set t_Co=256
set background=dark
colorscheme badwolf

"
" Temp file management
"

" Manage backups
if !exists('$VIMHOME')
  if has('win32') || has('win64')
    let $VIMHOME=$HOME.'/vimfiles'
  else
    let $VIMHOME=$HOME.'/.vim'
  endif
endif

set backupdir=$VIMHOME/tmpv/backup//
set directory=$VIMHOME/tmpv/swap//
set undodir=$VIMHOME/tmpv/undo//

set backup swapfile undofile

" Create backup dirs if not exist
for s:dir in [ &backupdir, &directory, &undodir ]
  if !isdirectory(s:dir)
    call mkdir(s:dir, 'p')
  endif
endfor

" Tip from: https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
augroup BackupOnSave
  autocmd!
  autocmd BufWritePre * let &bex = '@' . strftime("%F.%H-%M")
augroup END

" }}}
" =============================================================================
" Key Bindings {{{
" =============================================================================
map <leader>hf :call FillLine('=')<CR>
nnoremap <silent> <Leader>rv :source $HOME/.vimrc<CR>:echo "Reloaded MYVIMRC"<CR>

" == File
let g:which_key_map['e'] = {
      \ 'name' : '+edit files' ,
      \ 'd' : [':e ~/.vimrc', 'edit ~/.vimrc']
      \ }

" == Buffer manipulation
let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'n' : [':bn' , 'buffer-next'] ,
      \ 'p' : [':bp' , 'buffer-previous'] ,
      \ 'd' : [':bd' , 'buffer-delete'] ,
      \ }

" == Window manipulation
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ }

" }}}
" =============================================================================
" Functions {{{
" =============================================================================

" Function to fill a line with char
function! FillLine(str)
  " set tw to the desired total length
  let tw = &textwidth
  if tw==0 | let tw = 80 | endif
  " strip trailing spaces first
  .s/[[:space:]]*$//
  " calculate total number of 'str's to insert
  let reps = (tw - col('$')) / len(a:str)
  " insert them, if there's room, removing trailing spaces (though forcing
  " there to be one)
  if reps > 0
    .s/$/\=(' '.repeat(a:str, reps))/
  endif
endfunction

" }}}
" =============================================================================
" Experiments {{{
" =============================================================================


" }}}
