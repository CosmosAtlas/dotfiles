" vim configuration file
call plug#begin('~/.vim/plugged')

" More useful status line at bottom
Plug 'itchyny/lightline.vim'
" A quick wiki tool 
Plug 'vimwiki/vimwiki'
" A tool to draw boxes
Plug 'gyim/vim-boxdraw'
" A faster searc and navigation
Plug 'easymotion/vim-easymotion'
" Commenting
Plug 'tpope/vim-commentary'
" Git integration
Plug 'tpope/vim-fugitive'
" Dispatch for asynchronous
Plug 'tpope/vim-dispatch'
" Better repeating with '.'
Plug 'tpope/vim-repeat'
" Close brackets
Plug 'jiangmiao/auto-pairs'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'
" File browsers
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'} | 
    \ Plug 'Xuyuanp/nerdtree-git-plugin'
" Fast file search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
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
Plug 'nathanaelkane/vim-indent-guides'
" icons in file viewers
Plug 'ryanoasis/vim-devicons'
" asynchronous lint engine
Plug 'dense-analysis/ale'
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
" colering color codes
Plug 'chrisbra/Colorizer'
" send code blocks to live REPL
Plug 'jpalardy/vim-slime'
" Provide hints to shortcuts
Plug 'liuchengxu/vim-which-key'
" CSV editing
Plug 'chrisbra/csv.vim'
" better handle of open in browser
Plug 'tyru/open-browser.vim'
" Color Schemes ==============================================================
" Base16 color themes group
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'  " Lightline theme addon for base16
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

" Overall settings
set nu
set smartindent
set mouse=a
set hidden
set updatetime=300
set virtualedit=block

set signcolumn=yes

set ts=4 sw=4
set expandtab
set cursorline

set nocompatible

set encoding=utf-8


if (has("termguicolors"))
    " This is only necessary if you use "set termguicolors".
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


" lightline.vim
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'base16_gruvbox_dark_hard',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ }

augroup coc_lightline
    autocmd!
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

set t_Co=256

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

color afterglow

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
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd FileType tex setlocal spell
    autocmd BufRead,BufNewFile *.tex setlocal spell
augroup END

" Auto reload $MYVIMRC after modifying and saving
augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Always assume .tex files are latex file
let g:tex_flavor = "latex"


" vim-which-key
let g:mapleader = "\<Space>"
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")

" EasyMotion
map <Leader><Leader>s <Plug>(easymotion-sn)

" NerdTree
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

" vimtex
let g:vim_quickfix_open_on_warning = 0

" vimwiki
let g:vimwiki_list = [{
    \ 'path': '~/vimwiki',
    \ 'path_html': '~/vimwiki/site_html/'}]
" Disable overwriting filetype markdown
let g:vimwiki_global_ext = 0

" vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

" markdown-preview.nvim
let g:mkdp_browser = 'qutebrowser'
let g:mkdp_auto_close = 0
nmap <LocalLeader>mp <Plug>MarkdownPreviewToggle

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

" nvim-R
let g:R_assign = 0
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
            \ 'r': [],
            \ 'markdown': ['mdl'],
            \}
let g:ale_markdown_mdl_options = '-i -r MD002'
" let g:ale_r_lintr_options = 'lintr::with_defaults(line_length_linter = NULL, object_name_linter = NULL, object_usage_linter = NULL, object_length_linter = NULL, commented_code_linter = NULL)'

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


map <leader>hf :call FillLine('=')<CR>

" Personal Keymaps

" == File
let g:which_key_map['f'] = {
    \ 'name' : '+files' ,
    \ 's' : ':w',
    \ 'f' : ['Files' , 'fzf-files'], 
    \ 'd' : [':e $MYVIMRC', 'edit $MYVIMRC']
\ }

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

" === Color settngs ==========================================================
" Transparency
hi Normal guibg=NONE ctermbg=NONE
" No underline for current line number
hi CursorLineNr cterm=bold gui=bold
" Italic comments
hi Comment cterm=italic gui=italic
