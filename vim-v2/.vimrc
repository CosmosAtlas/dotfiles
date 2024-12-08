" vim: set foldmethod=marker foldlevel=1 nomodeline:
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
Plug 'rafi/awesome-vim-colorschemes'

"
" Functionality
"
Plug 'mbbill/undotree'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

" Visually show register contents
Plug 'junegunn/vim-peekaboo'

" visualize subsitute
Plug 'markonm/traces.vim'


Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 0
let delimitMate_nesting_quotes = ['"', '`']

" fzf fast searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


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

" Vim latex support
Plug 'lervag/vimtex'
Plug 'rbonvall/vim-textobj-latex'
let g:tex_flavor = 'latex'
let g:vim_quickfix_open_on_warning = 0
" let g:vimtex_view_method = 'zathura'

let g:vimtex_compiler_latexmk = {
      \ 'build_dir': 'build',
      \ 'options' : [
        \ '-pdf',
        \ '-shell-escape',
        \ '-synctex=1',
        \ '-verbose',
        \ '-file-line-error',
        \ ],
      \}


" Provide hints to shortcuts
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
" Key mapping see [Key Mappings] part

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Autocompletion
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-filter-matcher_head'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'shun/ddc-vim-lsp'
Plug 'Shougo/ddc-source-around'

Plug 'Shougo/pum.vim'
Plug 'Shougo/ddc-ui-pum'
Plug 'Shougo/ddc-source-omni'


call plug#end()

" Auto completion setup

call ddc#custom#patch_global('ui', 'pum')

call ddc#custom#patch_global('sources', ['around', 'vim-lsp', 'omni'])

call ddc#custom#patch_global('sourceOptions', #{
      \  _: #{
      \    matchers: ['matcher_head'],
      \  }
      \})

call ddc#custom#patch_global('sourceOptions', #{
      \   around: #{ mark: 'A' },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   around: #{ maxSize: 500 },
      \ })

call ddc#custom#patch_global('sources', ['vim-lsp'])
call ddc#custom#patch_global('sourceOptions', #{
    \   vim-lsp: #{
    \     matchers: ['matcher_head'],
    \     mark: 'lsp',
    \   },
    \ })

call ddc#custom#patch_global('sourceOptions', #{
      \   omni: #{ mark: 'O' },
      \ })

" Use vimtex
call vimtex#init()
call ddc#custom#patch_filetype(['tex'], 'sourceOptions', #{
      \   omni: #{
      \     forceCompletionPattern: g:vimtex#re#deoplete,
      \   },
      \ })
call ddc#custom#patch_filetype(['tex'], 'sourceParams', #{
      \   omni: #{ omnifunc: 'vimtex#complete#omnifunc' },
      \ })

call ddc#enable()

imap <silent><expr> <TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<TAB>'
imap <silent><expr> <S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-TAB>'
imap <silent><expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
imap <silent><expr> <Esc> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<Esc>'

inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

" Plug-in settings that needs to be called after plug#end
call which_key#register('<Space>', 'g:which_key_map')

" }}}
" =============================================================================
" Basic Settings {{{
" =============================================================================
set number           " always show line numbers
set smartindent      " better indendation
set mouse=a          " allow mouse operations
set hidden           " allow switching buffers without saving

set updatetime=100
set virtualedit=block

set signcolumn=yes

set tabstop=2        " Default to 4 space tabs
set shiftwidth=2
set expandtab        " Replace tabs with spaces
set cursorline       " Highlight current line


set encoding=utf-8   " Use unicode as default encoding
scriptencoding utf-8

set textwidth=79     " Auto change to next line at column 80
set colorcolumn=+1   " Highlight column 81 to warn about line width
set formatoptions+=l " Don't auto break line when I'm already on a long line
set formatoptions+=M " Better format for CJK characters

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

"
" Colors
"

" set t_Co=256
set termguicolors
set background=dark
colorscheme ayu

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
nnoremap <silent> <Leader>ed :e $MYVIMRC<CR> :echom "Editing $MYVIMRC"<CR>
nnoremap <silent> <Leader>rv :source $MYVIMRC<CR> :echom "Reloaded MYVIMRC"<CR>

" == Buffer manipulation
let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'b' : [':Buffers' , 'buffer-select'] ,
      \ 'n' : [':bn' , 'buffer-next'] ,
      \ 'p' : [':bp' , 'buffer-previous'] ,
      \ 'd' : [':bd' , 'buffer-delete'] ,
      \ }

" == Buffer manipulation
let g:which_key_map['f'] = {
      \ 'name' : '+files' ,
      \ 'f' : [':Files' , 'find-files'] ,
      \ 'g' : [':Rg' , 'grep-files'] ,
      \ }

" == Window manipulation
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ }

" == Toggles
let g:which_key_map['t'] = {
      \ 'name' : '+toggles' ,
      \ 'c' : [':Colors' , 'toggle-colorschemes'] ,
      \ 'u' : [':UndotreeToggle' , 'toggle-undo-history'] ,
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
