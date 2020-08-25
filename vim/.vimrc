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
" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'gitbranch': 'FugitiveHead',
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

" coc.nvim =====================================================================


" == Modified from suggested settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" End of coc.nvim ==============================================================

" === Color settngs ============================================================
" Transparency
hi Normal guibg=NONE ctermbg=NONE
" No underline for current line number
hi CursorLineNr cterm=bold gui=bold
" Italic comments
hi Comment cterm=italic gui=italic
