require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


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
vim.cmd('set rtp+=/opt/homebrew/opt/fzf')
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h16"

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
    -- vim.cmd('set norelativenumber nonu')
  elseif filetype == "cpp" then
    vim.cmd('w')
    vim.cmd(':! g++ -o ~/bin/cpp_code %<.cpp')
    vim.cmd('TermExec cmd="~/bin/cpp_code"')
  elseif filetype == "java" then
    vim.cmd('w')
    vim.cmd(':! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('TermExec cmd="java -cp ~/bin %"')
  elseif filetype == "python" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="python3 %<.py"')
  elseif filetype == "javascript" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="node %<.js"')
  elseif filetype == "typescript" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="tsc %<.ts && node %<.js && rm -f %<.js"')
  else
    vim.cmd(':echo "This file is not source"')
  end
end

-- Auto Wrap
function Toggle_wrap()
  vim.cmd('set wrap!')
end
