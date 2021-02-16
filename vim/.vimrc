let g:mapleader = "\<Space>"
let g:maplocalleader = ","

set nocompatible " Enable all features

" [todo] Group plugins by use case
" vim plugged plugins
call plug#begin('~/.vim/plugged')

" Auto fcitx state switching
Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5' }
" Extended language packs
Plug 'sheerun/vim-polyglot'
" More useful status line at bottom
Plug 'vim-airline/vim-airline'
" A quick wiki tool 
Plug 'vimwiki/vimwiki'
" A tool to draw boxes
Plug 'gyim/vim-boxdraw'
" Figlets! Fancy multi-line ascii font!
Plug 'fadein/vim-FIGlet'
" Focused writing mode
Plug 'junegunn/goyo.vim'
" Wrapping help
Plug 'reedes/vim-pencil'
" Highlight current writing block (Best with goyo)
Plug 'junegunn/limelight.vim'
" A faster searc and navigation
Plug 'easymotion/vim-easymotion'
" Seeking faster
Plug 'justinmk/vim-sneak'
" Commenting
Plug 'tpope/vim-commentary'
" Git integration
Plug 'tpope/vim-fugitive'
" Dispatch for asynchronous
Plug 'tpope/vim-dispatch'
" Better repeating with '.'
Plug 'tpope/vim-repeat'
" better highlighting for searches
Plug 'romainl/vim-cool'
" Close brackets
Plug 'jiangmiao/auto-pairs'
" File browsers
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'} | 
    \ Plug 'Xuyuanp/nerdtree-git-plugin'
" Fast file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto complete
" Plug 'msgpack/msgpack-python'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'deoplete-plugins/deoplete-jedi'

" Vim latex support
Plug 'lervag/vimtex'
" Highlight HTML tags
Plug 'Valloric/MatchTagAlways'
" Change enclosings
Plug 'tpope/vim-surround'
" Nvim R
Plug 'jalvesaq/Nvim-R'
" Rainbow!
Plug 'kien/rainbow_parentheses.vim'
" Markdown and tabular
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Table mode edits
Plug 'dhruvasagar/vim-table-mode'
" Easy alignment
Plug 'junegunn/vim-easy-align'
" Show diff
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" more text objects
Plug 'wellle/targets.vim'
" Fancy start page
Plug 'mhinz/vim-startify'
" Indent line guides
Plug 'Yggdroot/indentLine'
" icons in file viewers
Plug 'ryanoasis/vim-devicons'
" asynchronous lint engine
Plug 'dense-analysis/ale'
" python sort imports
Plug 'fisadev/vim-isort'
" faster ctrlp
Plug 'FelikZ/ctrlp-py-matcher'
" modern generic interactive finder and dispatcher
Plug 'liuchengxu/vim-clap'
" Tags
Plug 'majutsushi/tagbar'
" Abbreviation expansions
Plug 'mattn/emmet-vim'
" pep8 python indenter
Plug 'Vimjas/vim-python-pep8-indent'
" coloring color codes
Plug 'chrisbra/Colorizer'
" Color selector
Plug 'KabbAmine/vCoolor.vim'
" send code blocks to live REPL
Plug 'jpalardy/vim-slime'
" Provide hints to shortcuts
Plug 'liuchengxu/vim-which-key'
" CSV editing
Plug 'chrisbra/csv.vim'
" better handle of open in browser
Plug 'tyru/open-browser.vim'
" Color Schemes ==============================================================
" Themes for airline
Plug 'vim-airline/vim-airline-themes'
" Base16 color themes group
Plug 'chriskempson/base16-vim'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

" Overall settings
set number " Show the number line
set smartindent
set mouse=a
set hidden
set updatetime=100
set virtualedit=block

set signcolumn=yes

set ts=4 sw=4 " Default to 4 space tabs
set expandtab " Replace tabs with spaces
set cursorline " Highlight current line

set encoding=utf-8 " Use unicode as default encoding

set textwidth=80 " Auto change to next line at column 80
set colorcolumn=+1 " Highlight column 81 to warn about line width
set fo+=mM " Make textwidth work with Chinese


if (has("termguicolors"))
    " This is only necessary if you use "set termguicolors".
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


" vim-airline
set laststatus=2
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1

set t_Co=256

set bg=dark

color gruvbox

filetype indent plugin on
syntax enable
" Set highlight method for spellchecks
hi clear SpellBad
hi SpellBad cterm=underline

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

set list
set listchars=tab:▸\ ,eol:¬

set history=200

" Spell check for latex and markdown
augroup spellCheck
    autocmd!
    autocmd FileType markdown,tex,vimwiki,asciidoc setlocal spell
    autocmd BufRead,BufNewFile *.md,*.tex setlocal spell
augroup END
" Exclude CJK characters from spell checks
set spelllang+=cjk

" vim-pencil
" Auto pencil
augroup pencil
  autocmd!
  autocmd FileType text         call pencil#init()
  autocmd FileType tex         call pencil#init()
augroup END

" Auto reload $MYVIMRC after modifying and saving
augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
        autocmd BufWritePost $HOME/.vimrc nested source $HOME/.vimrc
augroup END

" Always assume .tex files are latex file
let g:tex_flavor = "latex"

" goyo.vim & limelight.vim
augroup goyo_lime
    autocmd!
    autocmd User GoyoEnter Limelight
    " autocmd User GoyoEnter IndentGuidesDisable
    autocmd User GoyoEnter set nonu
    autocmd User GoyoEnter set nolist
    autocmd User GoyoLeave Limelight!
    " autocmd User GoyoEnter IndentGuidesEnable
    autocmd User GoyoLeave set nu
    autocmd User GoyoLeave set list
augroup END

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'gray'
let g:limelight_paragraph_span = 0
let g:limelight_priority = -1

" vim-which-key
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")

" EasyMotion
map <Leader><Leader>s <Plug>(easymotion-sn)

" vcoolor
let g:vcoolor_disable_mappings = 1

" NerdTree
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" vim-startify
let g:startify_bookmarks = [
            \ {'v': '~/.vimrc'},
            \ '~/.zshrc'
            \ ]

let g:startify_ascii = [
            \ '┐ ┬o┌┌┐  ┬─┐┌┐┐┐ ┬',
            \ '│┌┘││││  ├─  │ │││',
            \ '└┘ ┆┘ ┆  ┆   ┆ └┴┆',
            \ ]
let g:startify_custom_header = g:startify_ascii + startify#fortune#boxed()

" vimtex
let g:vim_quickfix_open_on_warning = 0

" vimwiki
let g:vimwiki_list = [{
    \ 'path': '~/vimwiki',
    \ 'path_html': '~/vimwiki/site_html/'}]
" Disable overwriting filetype markdown
let g:vimwiki_global_ext = 0

" deoplete.nvim
let g:deoplete#enable_at_startup = 1

" vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

" markdown-preview.nvim
let g:mkdp_browser = 'qutebrowser'
let g:mkdp_auto_close = 0

" vim-table-mode Enbale markdown-compatible tables
let g:table_mode_corner='|'

" Rainbow!
augroup rainbow_parentheses
    autocmd!
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
augroup END

" auto-pairs
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsCenterLine = 0

" Nvim-R
let g:R_assign = 0
let R_external_term = 1
let R_in_buffer = 0
let R_source = '/home/cosmos/Scripts/tmux_split.vim'
let r_indent_align_args = 0

" open-browser.vim
let g:netrw_nogx = 1 " Disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" ale
let g:ale_linters = {
            \ 'python': ['flake8'],
            \ 'r': ['lintr'],
            \ 'markdown': ['mdl'],
            \}
let g:ale_markdown_mdl_options = '-i -r \~MD002'
let g:ale_r_lintr_options = 'lintr::with_defaults(line_length_linter = NULL, object_name_linter = NULL, object_usage_linter = NULL, object_length_linter = NULL, commented_code_linter = NULL)'

let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['yapf'], 
            \ 'r': ['styler']
            \}

" vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_python_ipython = 1


" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Personal functions ===========================================================

" Function to fill a line with char
function! FillLine(str)
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" Open Stack Overflow question/answer link based on selected id
function! OpenSOById()
    let s:urlTemplate = "https://stackoverflow.com/q/%"
    let s:browser = "xdg-open"
    let s:idUnderCursor = expand("<cword>")
    let s:url = substitute(s:urlTemplate, "%", s:idUnderCursor, "g")
    let s:cmd = "silent! !" . s:browser . " " . s:url
    execute s:cmd
endfunction

" indentLine
let g:indentLine_enable = 1
let g:indentLine_concealcursor = ''
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['help']
let g:indentLine_leadingSpaceChar = '·'



" Personal Keymaps
map <leader>hf :call FillLine('=')<CR>
map <leader>gs :call OpenSOById()<CR>

" == File
let g:which_key_map['f'] = {
    \ 'name' : '+files' ,
    \ 's' : ':w',
    \ 'f' : ['Files' , 'fzf-files'], 
    \ 'd' : [':e $MYVIMRC', 'edit $MYVIMRC'],
    \ 'v' : [':e ~/.vimrc', 'edit ~/.vimrc']
\ }

" == Modes
let g:which_key_map['m'] = {
    \ 'name' : '+modes' ,
    \ 'g' : ['Goyo', 'Toggle goyo'],
    \ 'c' : ['ColorToggle', 'Toggle hex coloring'],
    \ 'm' : ['MarkdownPreview', 'Toggle markdown preview']
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

" Tagbar
nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" deoplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
call deoplete#custom#option('smart_case', v:true)

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#enable_snipmate_compatibility = 1

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2
endif

" Customized highlight settings ================================================
" Transparency
hi Normal guibg=NONE ctermbg=NONE
" No underline for current line number
hi CursorLineNr cterm=bold gui=bold
" Italic comments
hi Comment cterm=italic gui=italic
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl
" Disable special syntax for TODO todo in comments
hi clear Todo
hi link Todo Comment
