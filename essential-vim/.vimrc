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

" Better file browsing

" Fast file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" send code blocks to live REPL
Plug 'jpalardy/vim-slime'
let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': get(split($TMUX, ','), 0), 'target_pane': ':.1'}
let g:slime_python_ipython = 1

" Language Specifics
"

" Aggregator of syntax files
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']
" Vim latex support
Plug 'lervag/vimtex', {'for': ['latex', 'tex']}
Plug 'rbonvall/vim-textobj-latex'
let g:tex_flavor = 'latex'
let g:vim_quickfix_open_on_warning = 0
let g:vimtex_view_method = 'zathura'

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


" Better pandoc
Plug 'vim-pandoc/vim-pandoc'
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#fdc = 0
let g:pandoc#formatting#textwidth = 79
let g:pandoc#formatting#mode = 'h'
let g:pandoc#syntax#codeblocks#embeds#langs = ['make', 'python', 'bash=sh']
" Way better syntax for markdown documents, like lightyears ahead of the ugly
" and problematic default...
Plug 'vim-pandoc/vim-pandoc-syntax'
  augroup pandoc_syntax
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    autocmd FileType vimwiki set syntax=markdown.pandoc
  augroup END

" pep8 python indenter
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug', 'markdown.pandoc']}
let g:mkdp_filetypes = ['markdown', 'wiki', 'markdown.pandoc']

Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|' " Defaults to markdown table style

" fast expanding for html
Plug 'mattn/emmet-vim', {'for': ['html']}

Plug 'chrisbra/csv.vim', {'for': ['csv']}
Plug 'baskerville/vim-sxhkdrc'



" Autocompletion

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 200
" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_diagnostics_float_delay = 200

if executable('pyls')
  " pip install python-language-server
  augroup textobj_sentence
    autocmd! User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
  augroup END
endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

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

"
" Colors
"
set t_Co=256
set background=dark
colorscheme badwolf

" My highlight preferences (to overwrite the colorscheme)
" Transparency
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
" No underline for current line number
hi CursorLineNr cterm=bold gui=bold
" Italic comments
hi Comment cterm=italic gui=italic
" Custom spell error with underline
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

set list
set listchars=tab:▶\ ,eol:¬,trail:·,nbsp:␣

set history=200

" Spell check for latex and markdown
augroup textSpecial
  autocmd!
  autocmd FileType markdown.pandoc setlocal foldlevel=99 " Technically disabling folding
  autocmd FileType markdown.pandoc,markdown,tex,asciidoc,mail setlocal spell
  autocmd FileType markdown.pandoc,markdown,asciidoc,mail setlocal formatoptions+=t
  autocmd FileType tex setlocal formatoptions-=t
  autocmd BufRead,BufNewFile *.md,*.tex setlocal spell
augroup END

" Exclude CJK characters from spell checks
set spelllang+=cjk

" Auto reload $MYVIMRC after modifying and saving
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $HOME/.vimrc nested source $HOME/.vimrc
augroup END

" }}}
" =============================================================================
" Key Bindings {{{
" =============================================================================
map <leader>hf :call FillLine('=')<CR>

" == File
let g:which_key_map['f'] = {
      \ 'name' : '+files' ,
      \ 'f' : ['Files' , 'fzf-files'],
      \ 'd' : [':e $MYVIMRC', 'edit $MYVIMRC'],
      \ 'v' : [':e ~/.vimrc', 'edit ~/.vimrc']
      \ }

" == Modes
let g:which_key_map['m'] = {
      \ 'name' : '+modes' ,
      \ 'm' : [':MarkdownPreview', 'Toggle markdown preview']
      \}

" == Buffer manipulation
let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'n' : [':bn' , 'buffer-next'] ,
      \ 'p' : [':bp' , 'buffer-previous'] ,
      \ 'd' : [':bd' , 'buffer-delete'] ,
      \ 'f' : ['Buffers', 'fzf-buffer']
      \ }

" == Window manipulation
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ 'f' : ['Windows'    , 'fzf-window']            ,
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

" Get Syntax highlight groups
" Source: https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}

" =============================================================================
" Experiments {{{
" =============================================================================


" }}}
