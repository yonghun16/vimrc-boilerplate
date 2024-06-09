require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!


------------------------------------------------------------------
-- Language Setting
------------------------------------------------------------------
vim.cmd 'autocmd Filetype c setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype java setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype py setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype js setlocal ts=2 sw=2 expandtab'
vim.cmd 'autocmd Filetype ts setlocal ts=2 sw=2 expandtab'
vim.cmd 'autocmd Filetype pug setlocal ts=4 sw=4 expandtab'


------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.numberwidth = 4
vim.opt.updatetime = 200


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
