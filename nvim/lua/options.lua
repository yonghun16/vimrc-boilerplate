require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
-- tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "c", "cpp", "java" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- number line
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- scroll
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

-- folding
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"

-- etc
vim.opt.wrap = false
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h16"
vim.opt.updatetime = 200

------------------------------------------------------------------
-- Plugin options
------------------------------------------------------------------
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"
vim.g.codeium_enabled = true

------------------------------------------------------------------
-- Functions
------------------------------------------------------------------
-- Compile & Run
function Compile()
  local filetype = vim.bo.filetype

  if filetype == "python" then
    vim.cmd "w"
    vim.cmd 'TermExec cmd="python3 %<.py"'
    -- vim.cmd('set norelativenumber nonu')
  elseif filetype == "javascript" then
    vim.cmd "w"
    vim.cmd 'TermExec cmd="node %<.js"'
  elseif filetype == "typescript" then
    vim.cmd "w"
    vim.cmd ":! tsc %<.ts --outDir ~/bin"
    vim.cmd 'TermExec cmd="node ~/bin/%<.js"'
  elseif filetype == "c" then
    vim.cmd "w"
    vim.cmd ":! gcc -o ~/bin/% %<.c"
    vim.cmd 'TermExec cmd="~/bin/%"'
  elseif filetype == "cpp" then
    vim.cmd "w"
    vim.cmd ":! g++ -o ~/bin/% %<.cpp"
    vim.cmd 'TermExec cmd="~/bin/%"'
  elseif filetype == "java" then
    vim.cmd "w"
    vim.cmd ":! javac -encoding utf-8 -d ~/bin %<.java"
    vim.cmd 'TermExec cmd="java -cp ~/bin %"'
  else
    vim.cmd ':echo "This file is not a source file."'
  end
end

-- Toggle Wrap codes
function ToggleWrapCodes()
  if vim.wo.wrap then
    vim.wo.wrap = false
    print "Line wrapping disabled"
  else
    vim.wo.wrap = true
    print "Line wrapping enabled"
  end
end

-- Toggle Foldcolumn
function ToggleFoldColumn()
  if vim.wo.foldcolumn == "0" then
    vim.wo.foldcolumn = "3"
    vim.wo.relativenumber = false
    print "Foldcolumn enabled"
  else
    vim.wo.foldcolumn = "0"
    vim.wo.relativenumber = true
    print "Foldcolumn disabled"
  end
end

-- Toggle Codeium
function ToggleCodeium()
  if vim.g.codeium_enabled == nil or vim.g.codeium_enabled == false then
    vim.g.codeium_enabled = true
    vim.cmd "CodeiumEnable"
    print "Codeium enabled"
  else
    vim.g.codeium_enabled = false
    vim.cmd "CodeiumDisable"
    print "Codeium disabled"
  end
end
