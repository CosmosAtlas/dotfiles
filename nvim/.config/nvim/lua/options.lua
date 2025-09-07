local opt = vim.opt
local o = vim.o
local g = vim.g


o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }  -- for cleaner end of file look
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.hidden = true

o.number = true
o.numberwidth = 2
o.ruler = false

opt.shortmess:append "sI"  -- disable nvim intro

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400

o.updatetime = 250

opt.backspace = { 'indent', 'eol', 'start' }

o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
opt.fileencodings = {
  'utf-8',
  'gb2312', -- legacy CHS
  'gb18030', -- legacy CHS
  'pbk',
  'ucs-bom',
  'cp936',
}

opt.formatoptions:append {
  'l',  -- don't break a line with single letter word
  'M'  -- better CJK support
}
opt.formatoptions:remove {
  't',  -- disable auto changeline
}

o.termguicolors = true
o.belloff = 'all'

-- backup file saves
o.backup = true
o.swapfile = true
o.undofile = true
o.writebackup = true

-- visible chars
vim.o.list = true
vim.opt.listchars = {
  tab   = '·┈',
  -- eol   = '¬',
  trail = '·',
  nbsp  = '␣'
}

-- ensure VIMHOME exists
if vim.env.VIMHOME == nil then
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.env.VIMHOME = vim.env.HOME .. '/vimfiles'
  else
    vim.env.VIMHOME = vim.env.HOME .. '/.vim'
  end
end

o.backupdir = vim.env.VIMHOME .. '/tmp/backup//'
o.directory = vim.env.VIMHOME .. '/tmp/swap//'
o.undodir = vim.env.VIMHOME .. '/tmp/undo//'

for _, dir in pairs({o.backupdir, o.directory, o.undodir}) do
  if vim.fn.isdirectory(dir) ~= 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("BackupOnSave", { clear = true }),
  pattern = "*",
  callback = function()
    opt.bex = "@" .. os.date("%F.%H-%M")
  end
})

-- disable default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0


