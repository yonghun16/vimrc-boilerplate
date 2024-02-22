------------------------------------------------------------------
-- Autocmd Rules
------------------------------------------------------------------
vim.cmd 'au BufEnter * call v:lua.BufEnter_f()'
vim.cmd 'au BufLeave * call v:lua.BufLeave_f()'

function BufEnter_f()
  if (vim.bo.buftype == "terminal"
      or vim.bo.buftype == "nofile"
      or vim.o.filetype == "tagbar"
      or vim.o.filetype == "NvimTree"
      or vim.o.filetype == "dashboard"
      ) then
    vim.cmd('set norelativenumber')
  else
    vim.cmd('set relativenumber')
  end
end

function BufLeave_f()
  vim.cmd('set norelativenumber')
end

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


------------------------------------------------------------------
-- Language Setting
------------------------------------------------------------------
vim.cmd 'autocmd Filetype pug setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype c setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype java setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype py setlocal ts=4 sw=4 expandtab'


------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
vim.g.mapleader = ","
vim.o.guifont = "Hack Nerd Font:h16"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.numberwidth = 4
vim.cmd([[ let g:neovide_input_macos_alt_is_meta=v:true ]])


------------------------------------------------------------------
-- Vimscript Plugins Setting
------------------------------------------------------------------
-- tagbar
vim.cmd([[ let g:tagbar_position = 'topleft vertical' ]])
vim.cmd([[ let g:tagbar_width = '30' ]])

-- visual-multi
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor At Pos"]   = '<C-RIGHT>' ]])

-- emmet-vim
vim.cmd([[ let g:user_emmet_leader_key=',' ]])

------------------------------------------------------------------
-- Functions
------------------------------------------------------------------
-- Compile
function Compile()
  local filetype = vim.bo.filetype
  if filetype == "c" then
    vim.cmd('w')
    vim.cmd(':! gcc -o ~/bin/c_code %<.c')
    vim.cmd('TermExec cmd="~/bin/c_code"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "cpp" then
    vim.cmd('w')
    vim.cmd(':! g++ -o ~/bin/cpp_code %<.cpp')
    vim.cmd('TermExec cmd="~/bin/cpp_code"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "java" then
    vim.cmd('w')
    vim.cmd(':! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('TermExec cmd="java -cp ~/bin %"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "python" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="python3 %<.py"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "javascript" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="node %<.js"')
    vim.cmd('set norelativenumber nonu')
  else
    vim.cmd(':echo "This file is not source"')
  end
end

-- Auto Wrap
function Toggle_wrap()
  vim.cmd('set wrap!')
end
