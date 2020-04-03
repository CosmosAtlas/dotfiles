call plug#begin('~/.vim/plugged')

" More useful status line at bottom
Plug 'bling/vim-airline'
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
" Close brackets
Plug 'Raimondi/delimitMate'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'
" File browsers
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" Fast file search
Plug 'ctrlpvim/ctrlp.vim'
" Vim latex support
Plug 'lervag/vimtex'
" Align text
Plug 'godlygeek/tabular'
" Base16 color themes group
Plug 'chriskempson/base16-vim'
" Auto completion
Plug 'ajh17/VimCompletesMe'
" Highlight HTML tags
Plug 'Valloric/MatchTagAlways'
" Change enclosings
Plug 'tpope/vim-surround'
" Nvim R
Plug 'jalvesaq/Nvim-R'
" Syntax checking
Plug 'scrooloose/syntastic'
" Rainbow!
Plug 'kien/rainbow_parentheses.vim'
" Markdown and tabular
Plug 'godlygeek/tabular'
" Easy alignment
Plug 'junegunn/vim-easy-align'
" Show diff
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" Indent line guides
Plug 'Yggdroot/indentLine'
" Nord color scheme
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Overall settings
set nu
set smartindent
set mouse=a
syntax on
filetype indent plugin on

set ts=4 sw=4
set expandtab

set nocompatible

set encoding=utf8

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
color nord

" Set highlight method for spellchecks
hi clear SpellBad
hi SpellBad cterm=underline

set list
set listchars=tab:▸\ ,eol:¬

set history=200

" EasyMotion
map <Leader><Leader>s <Plug>(easymotion-sn)
omap <Leader><Leader>s <Plug>(easymotion-sn)

" identLine

" Airline 
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='base16_nord'


map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" Control-P fuzzy finder
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:vimtex_latexmk_options = "-pdf -verbose -file-line-error -synctex=1"
let g:vimtex_latexmk_callback = 0

let g:polyglot_disabled = ['latex']

" Vim Markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'

" Rainbow!
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" nvim-R
let g:R_assign = 0

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Function to fill a line with char
function! FillLine( str )
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

map <leader>hf :call FillLine( '=' )<CR>
