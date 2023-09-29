vim.g.slime_python_ipython = 1

vim.cmd[[
" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
if has('win32')
  fun! StartREPL(repl)
    execute 'terminal '.a:repl
    setlocal nonumber
    let t:term_id = b:terminal_job_id
    wincmd p
    execute 'let b:slime_config = {"jobid": "'.t:term_id . '"}'
  endfun

  noremap <silent> <LocalLeader>i :vsplit<bar>:call StartREPL('ipython')<CR>
endif

let g:slime_dont_ask_default = 1

"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" map <LocalLeader>s to start IPython
nnoremap <LocalLeader>s :SlimeSend1 ipython --matplotlib<CR>

" map <LocalLeader>r to run script
nnoremap <LocalLeader>r :IPythonCellRun<CR>

" map <LocalLeader>R to run script and time the execution
nnoremap <LocalLeader>R :IPythonCellRunTime<CR>

" map <LocalLeader>c to execute the current cell
nnoremap <LocalLeader>c :IPythonCellExecuteCell<CR>

" map <LocalLeader>C to execute the current cell and jump to the next cell
nnoremap <LocalLeader>C :IPythonCellExecuteCellJump<CR>

" map <LocalLeader>l to clear IPython screen
nnoremap <LocalLeader>l :IPythonCellClear<CR>

" map <LocalLeader>x to close all Matplotlib figure windows
nnoremap <LocalLeader>x :IPythonCellClose<CR>

" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>

" map <LocalLeader>h to send the current line or current selection to IPython
nmap <LocalLeader>h <Plug>SlimeLineSend
xmap <LocalLeader>h <Plug>SlimeRegionSend

" map <LocalLeader>p to run the previous command
nnoremap <LocalLeader>p :IPythonCellPrevCommand<CR>

" map <LocalLeader>Q to restart ipython
nnoremap <LocalLeader>Q :IPythonCellRestart<CR>

" map <LocalLeader>d to start debug mode
nnoremap <LocalLeader>d :SlimeSend1 %debug<CR>

" map <LocalLeader>q to exit debug mode or IPython
nnoremap <LocalLeader>q :SlimeSend1 exit<CR>

" map <F9> and <F10> to insert a cell header tag above/below and enter insert mode
nmap <LocalLeader>O :IPythonCellInsertAbove<CR>a
nmap <LocalLeader>o :IPythonCellInsertBelow<CR>a

" also make <F9> and <F10> work in insert mode
imap <F9> <C-o>:IPythonCellInsertAbove<CR>
imap <F10> <C-o>:IPythonCellInsertBelow<CR>
]]
