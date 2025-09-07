--
-- Basics (within vim) {{{
--

-- for nvim-tree setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- just to be explicit
vim.cmd('filetype indent plugin on')
vim.cmd('syntax enable')


-- setup leader keys
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

vim.g.mapleader      = ' '
vim.g.maplocalleader = ','

-- vim behaviors
vim.o.number      = true
vim.o.mouse       = 'a'
vim.o.smartindent = true
vim.o.hidden      = true

vim.o.updatetime  =100
vim.o.virtualedit = 'block'

vim.o.signcolumn = 'yes'

vim.o.tabstop     = 2
vim.o.shiftwidth  = 2
vim.o.expandtab   = true
vim.o.cursorline  = true
vim.opt.backspace = {'indent', 'eol', 'start'}

-- explicit encoding declarations
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.opt.fileencodings={
  'utf-8',
  'gb2312',  -- windows CHN format
  'gb18030', -- same as previous
  'pbk',
  'ucs-bom',
  'cp936',
  'latin1'
}

vim.o.textwidth = 79
vim.opt.colorcolumn:append {'+1'}
vim.opt.formatoptions:append {
  'l',
  'M' -- better CJK support
}
vim.opt.formatoptions:remove {
  't',  -- disable auto changeline
}

vim.o.foldmethod = 'marker'
vim.o.clipboard  = 'unnamedplus'

vim.o.conceallevel = 2

vim.o.termguicolors = true
vim.o.belloff       = 'all'

vim.o.list = true
vim.opt.listchars = {
  tab   = '▶ ',
  eol   = '¬',
  trail = '·',
  nbsp  = '␣'
}

vim.o.splitright = true
vim.o.splitbelow = true

if vim.env.VIMHOME == nil then
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.env.VIMHOME = vim.env.HOME .. '/vimfiles'
  else
    vim.env.VIMHOME = vim.env.HOME .. '/.vim'
  end
end

vim.o.backupdir = vim.env.VIMHOME .. '/tmp/backup//'
vim.o.directory = vim.env.VIMHOME .. '/tmp/swap//'
vim.o.undodir   = vim.env.VIMHOME .. '/tmp/undo//'

vim.o.backup      = true
vim.o.swapfile    = true
vim.o.undofile    = true
vim.o.writebackup = true

for _, dir in pairs({vim.o.backupdir, vim.o.directory, vim.o.undodir}) do
  if vim.fn.isdirectory(dir) ~= 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

vim.cmd([[
  augroup BackupOnSave
    autocmd BufWritePre * let &bex = '@' . strftime("%F.%H-%M")
  augroup END
]])

-- Key bindings

-- quick editing and reloading config file
vim.api.nvim_set_keymap('n', '<Leader>ed', ':e $MYVIMRC<CR> :echom "Editing $MYVIMRC"<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>rv', ':source $MYVIMRC<CR> :echom "$MYVIMRC reloaded"<CR>', { silent = true })

-- for panic exiting terminal insert mode
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-N>', {silent = true })

-- remove trailing whitespace
-- note: the double '\' is for escaping lua string limitation
vim.api.nvim_set_keymap('n', '<Leader>ds', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>', {silent = true })

-- Move between splits with alt+mov key
vim.cmd([[
for i in ['h', 'j', 'k', 'l', 'H', 'J', 'K', 'L']
    execute('noremap <A-' . i . '> <C-w>' . i)
    execute('inoremap <A-' . i . '> <Esc><C-w>' . i)
    execute('tnoremap <A-' . i . '> <C-\><C-n><C-w>' . i)
endfor
]])

--
-- End of basics }}}
--

--
-- My functionalities {{{
--

-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile' }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })

--
-- }}}
--

--
-- Plugins via Lazy.nvim {{{
--

-- bootstraping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = { import = 'plugins' },
  change_detection = { notify = false },
})

require('wk-keybinds')

--
-- End of plugins }}}
--
