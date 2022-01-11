" vim: set foldmethod=marker foldlevel=0 nomodeline:
" =============================================================================
" .vimrc of Wenhan Zhu (Cosmos) {{{
" =============================================================================
" Auto load vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plugInstall
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

filetype indent plugin on
syntax enable

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" use uname to test which os is currently running on
" mainly used to get away with the linux/mac sharing has('unix') problem
" trim to remove the '\n' from command output
let g:uname = trim(system('uname'))


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
let delimitMate_expand_cr = 1
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


" asynchronous lint engine
Plug 'dense-analysis/ale'
let g:ale_linters = {
      \ 'python': ['flake8'],
      \ 'r': ['lintr'],
      \ 'markdown': ['mdl'],
      \ 'vim': ['vint'],
      \ 'cpp': ['clangd'],
      \}
let g:ale_cpp_clang_options = '-std=c++14 -isystem /usr/include/c++/11.1.0 -I/usr/include/c++/11.1.0 -I/usr/include/ -I/usr/include/qt/'
let g:ale_markdown_mdl_options = '-i -r \~MD002 -r \~MD026'
let g:ale_r_lintr_options = 'lintr::with_defaults(line_length_linter = NULL, object_name_linter = NULL, object_usage_linter = NULL, object_length_linter = NULL, commented_code_linter = NULL)'
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['yapf'],
      \ 'r': ['styler']
      \}

" Provide hints to shortcuts
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
" Key mapping see [Key Mappings] part

" Alternative wiki provider
Plug 'lervag/wiki.vim'
let g:wiki_filetypes = ['wiki']
let g:wiki_link_target_type = 'md'
let g:wiki_root = '~/vimwiki/content/'

augroup wikiAsMarkdown
  autocmd!
  autocmd BufEnter *.wiki :setlocal filetype=markdown.pandoc
augroup END

augroup vimwikiUpdate
  autocmd!
  " Make sure this window's working dir is the wiki repo dir
  autocmd BufRead ~/vimwiki/content/index.wiki Gcd
  " Also do a git pull whenever index.md is opened
  autocmd BufRead ~/vimwiki/content/index.wiki :Dispatch git pull
  " After writing to any file in the wiki dir, add all files in the repo, commit and push
  autocmd BufWritePost ~/vimwiki/* :Dispatch git add .;git commit -m "auto-commit-and-push";git push
augroup END

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

Plug 'ludovicchabant/vim-gutentags'
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
let g:tagbar_type_r = {
      \ 'ctagstype' : 'r',
      \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
        \ ]
        \ }


" Better file browsing
Plug 'justinmk/vim-dirvish'

" Fast file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto fcitx state switching
" Only enable on linux systems
if g:uname ==? 'Linux'
  Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5' }
  Plug 'wellle/tmux-complete.vim'
endif

" send code blocks to live REPL
Plug 'jpalardy/vim-slime'
let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': get(split($TMUX, ','), 0), 'target_pane': ':.1'}
let g:slime_python_ipython = 1

"
" Auto Completion {{{
"
" Load these two anyway to avoid being removed during neovim plugin maintenance
" via :PlugClean
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang'
" Snippets
Plug 'Shougo/neosnippet.vim'
  let g:neosnippet#scope_aliases = {}
  let g:neosnippet#scope_aliases['vimwiki'] = 'markdown'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" }}}

"
" Language Specifics
"

" Aggregator of syntax files
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']
" Vim latex support
Plug 'lervag/vimtex'
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


" deoplete python extension via jedi
Plug 'deoplete-plugins/deoplete-jedi'
" python sort imports
Plug 'fisadev/vim-isort', {'on': 'Isort'}
" pep8 python indenter
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}

Plug 'jalvesaq/Nvim-R', {'for': ['R']}
" Use tmux for split
let g:R_assign = 0
let R_external_term = 1
let R_in_buffer = 0
let R_source = '/home/cosmos/Scripts/tmux_split.vim'
let r_indent_align_args = 0

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug', 'markdown.pandoc']}
let g:mkdp_filetypes = ['markdown', 'wiki', 'markdown.pandoc']

Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|' " Defaults to markdown table style

" fast expanding for html
Plug 'mattn/emmet-vim', {'for': ['html']}

Plug 'chrisbra/csv.vim', {'for': ['csv']}
Plug 'baskerville/vim-sxhkdrc'

call plug#end()

" Plug-in settings that needs to be called after plug#end
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
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
