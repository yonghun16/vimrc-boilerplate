------------------------------------------------------------------
-- Autocmd Rules
------------------------------------------------------------------
-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--


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
-- vim.g.codeium_enabled = false -- Codeium Off
vim.g.mapleader = ","
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.numberwidth = 4
vim.opt.updatetime = 200

------------------------------------------------------------------
-- NeoVide Options
------------------------------------------------------------------
if vim.g.neovide then
  -- font
  vim.o.guifont = "JetBrainsMono Nerd Font:style=Regular,Regular:h16"

  -- alt key used
  vim.cmd([[ let g:neovide_input_macos_alt_is_meta=v:true ]])

  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

  -- set the refresh rate
  vim.api.nvim_set_var("neovide_refresh_rate", 75)

  -- zoom
  vim.keymap.set("", "<C-=>",
    function()
      -- find & get current font size
      local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
      font_size = tostring(tonumber(font_size) + 1)
      -- update the font size
      vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
    end,
    { noremap = true }
  )

  -- dezoom
  vim.keymap.set("", "<C-->",
    function()
      -- find & get current font size
      local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
      if tonumber(font_size) > 1 then
        font_size = tostring(tonumber(font_size) - 1)
        -- update the font size
        vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
      end
    end,
    { noremap = true }
  )
end

-- detecting if the terminal colors are defined (the 0-th one at least)
if (vim.fn.exists("g:neovide") == 1 and vim.fn.exists("g:terminal_color_0") == 0) then
  vim.api.nvim_set_var("terminal_color_0", '#352F2A')
  vim.api.nvim_set_var("terminal_color_1", '#B65C60')
  vim.api.nvim_set_var("terminal_color_2", '#78997A')
  vim.api.nvim_set_var("terminal_color_3", '#EBC06D')
  vim.api.nvim_set_var("terminal_color_4", '#9AACCE')
  vim.api.nvim_set_var("terminal_color_5", '#B380B0')
  vim.api.nvim_set_var("terminal_color_6", '#86A3A3')
  vim.api.nvim_set_var("terminal_color_7", '#A38D78')
  vim.api.nvim_set_var("terminal_color_8", '#4D453E')
  vim.api.nvim_set_var("terminal_color_9", '#F17C64')
  vim.api.nvim_set_var("terminal_color_10", '#99D59D')
  vim.api.nvim_set_var("terminal_color_11", '#EBC06D')
  vim.api.nvim_set_var("terminal_color_12", '#9AACCE')
  vim.api.nvim_set_var("terminal_color_13", '#CE9BCB')
  vim.api.nvim_set_var("terminal_color_14", '#88B3B2')
  vim.api.nvim_set_var("terminal_color_15", '#C1A78E')
end


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
