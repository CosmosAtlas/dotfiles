" vim: set foldmethod=marker foldlevel=1 nomodeline:
" =============================================================================
" vimrc of Wenhan Zhu (Cosmos) {{{
" =============================================================================

set nocompatible

filetype indent plugin on
syntax enable

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" }}}
" =============================================================================
" VIM-PLUG Block {{{
" =============================================================================

" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source '~/.vimrc'
endif


" Configuration of plugins
call plug#begin('~/.vim/plugged')

" More useful status line at bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts=1

Plug 'ryanoasis/vim-devicons'

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
Plug 'vim/colorschemes'

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
Plug 'kana/vim-textobj-user'          " Required by the following plugins to easily create text objects
Plug 'kana/vim-textobj-line'          " For selecting lines
Plug 'preservim/vim-textobj-sentence' " For selecting sentences
Plug 'sgur/vim-textobj-parameter'     " For selecting function arguments

augroup textobj_sentence
  autocmd! FileType markdown,tex,mail,textile,text call textobj#sentence#init()
augroup END

" Vim latex support
Plug 'lervag/vimtex'

let g:vimtex_compiler_silent = 1  " silence warning about latexmk not found

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

" Diagnostics
Plug 'dense-analysis/ale'

let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['ruff']}
let g:ale_fixers = {'python': ['ruff', 'ruff_format']}
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 0
let g:ale_cursor_detail = 0

" Autocompletion
Plug 'girishji/vimcomplete'
let g:vimcomplete_tab_enable = 1

Plug 'yegappan/lsp'

Plug 'Vimjas/vim-python-pep8-indent'

" sending code
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" tags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]


Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>


call plug#end()

let lspServers = [#{
  \   name: 'pylsp',
  \   filetype: ['python'],
  \   path: 'pylsp',
  \   args: [],
  \   features: #{
  \       diagnostics: v:false
  \   }
  \ }, #{
  \   name: 'rustlang',
  \   filetype: ['rust'],
  \   path: 'rust-analyzer',
  \   args: [],
  \   syncInit: v:true
  \ }]

autocmd User LspSetup call LspAddServer(lspServers)

let lspOptions = #{
  \   aleSupport: v:true,
  \   autoComplete: v:true,
  \   autoHighlight: v:false,
  \   autoHighlightDiags: v:true,
  \   autoPopulateDiags: v:false,
  \   completionMatcher: 'case',
  \   completionMatcherValue: 1,
  \   diagSignErrorText: 'E>',
  \   diagSignHintText: 'H>',
  \   diagSignInfoText: 'I>',
  \   diagSignWarningText: 'W>',
  \   echoSignature: v:false,
  \   hideDisabledCodeActions: v:false,
  \   highlightDiagInline: v:true,
  \   hoverInPreview: v:false,
  \   ignoreMissingServer: v:false,
  \   keepFocusInDiags: v:true,
  \   keepFocusInReferences: v:true,
  \   completionTextEdit: v:true,
  \   diagVirtualTextAlign: 'above',
  \   diagVirtualTextWrap: 'default',
  \   noNewlineInCompletion: v:false,
  \   omniComplete: v:null,
  \   outlineOnRight: v:false,
  \   outlineWinSize: 20,
  \   semanticHighlight: v:true,
  \   showDiagInBalloon: v:true,
  \   showDiagInPopup: v:true,
  \   showDiagOnStatusLine: v:true,
  \   showDiagWithSign: v:true,
  \   showDiagWithVirtualText: v:false,
  \   showInlayHints: v:false,
  \   showSignature: v:true,
  \   snippetSupport: v:false,
  \   ultisnipsSupport: v:false,
  \   useBufferCompletion: v:false,
  \   usePopupInCodeAction: v:false,
  \   useQuickfixForLocations: v:false,
  \   vsnipSupport: v:false,
  \   bufferCompletionTimeout: 100,
  \   customCompletionKinds: v:false,
  \   completionKinds: {},
  \   filterCompletionDuplicates: v:false,
  \ }

autocmd User LspSetup call LspOptionsSet(lspOptions)


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
set formatoptions-=t " Disable auto change lines

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
      \ 't' : [':GitFiles' , 'find-vcs-files'] ,
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
      \ 'd' : [':LspDiag show' , 'toggle-lsp-diagnostics-list'] ,
      \ }

" == Code Actions
let g:which_key_map['g'] = {
      \ 'name' : '+toggles' ,
      \ 'd' : [':LspGotoDefinition' , 'lsp-goto-definition'] ,
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
