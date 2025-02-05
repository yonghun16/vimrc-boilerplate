require "nvchad.options"

-- add yours here!

------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
--- cursorline
local o = vim.o
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    o.cursorlineopt = "both"
    o.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  callback = function()
    o.cursorlineopt = "both"
    o.cursorline = false
  end,
})

-- tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "c", "cpp", "java" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.bo.expandtab = true
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
-- fzf
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"

-- Codeium
vim.g.codeium_enabled = true
vim.keymap.set("i", "<C-S-f>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
vim.keymap.set("i", "<C-S-n>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
vim.keymap.set("i", "<C-S-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })

-- visual-multi
vim.cmd [[ let g:VM_maps = {} ]]
vim.cmd [[ let g:VM_maps["Find Under"] = '<C-S-/>' ]]
vim.cmd [[ let g:VM_maps["Find Subword Under"] = '<C-S-/>' ]] -- used in Visual Mode
vim.cmd [[ let g:VM_maps["Add Cursor At Pos"] = '<C-RIGHT>' ]]
-- Goto Next ],  Goto Prev [,  Skip Region q,  Remove Region Q

-- emmet-vim
vim.g.user_emmet_leader_key = ","

-- tagbar
vim.cmd [[ let g:tagbar_width = '30' ]]

-- indent-blankline
require("ibl").update {
  vim.api.nvim_set_hl(0, "IndentBlanklineChar", { underline = true }), -- function definitions (height -> underline)
}

-- snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })


------------------------------------------------------------------
-- Functions
------------------------------------------------------------------
-- Compile and Run
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
    local tsconfig_exists = vim.fn.filereadable "tsconfig.json" == 1
    if not tsconfig_exists then
      vim.fn.writefile({}, "tsconfig.json")
    end
    vim.cmd 'TermExec cmd="ts-node %<.ts"'
    -- vim.cmd ":! tsc % --outDir ~/bin"
    -- vim.cmd 'TermExec cmd="node ~/bin/%<.js"'
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

-- Git Commit and Push
function Commit_and_push()
  local commit_message = vim.fn.input "Commit message: " -- 사용자로부터 커밋 메시지 입력받기
  if commit_message == "" then
    print "Commit aborted: No message provided." -- 메시지가 비어 있으면 커밋 중단
    return
  end

  vim.cmd "write" -- 현재 파일 저장
  local git_command = string.format("!git add -A && git commit -m '%s' && git push", commit_message)
  vim.cmd(git_command) -- Git 명령 실행
end

-- Toggle Wrap codes
function ToggleWrapCodes()
  if vim.wo.wrap then
    vim.wo.wrap = false
  else
    vim.wo.wrap = true
  end
end

-- Toggle Foldcolumn
function ToggleFoldColumn()
  if vim.wo.foldcolumn == "0" then
    vim.wo.foldcolumn = "4"
    vim.wo.relativenumber = false
  else
    vim.wo.foldcolumn = "0"
    vim.wo.relativenumber = true
  end
end

-- Toggle Codeium
function ToggleAIAutoComplete()
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

-- Toogle Diagnostic quickfix list
function ToggleDiagnostics_qflist()
  local qf_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end

  if qf_open then
    vim.cmd "cclose"
  else
    vim.fn.setqflist {} -- 기존 Quickfix 리스트 초기화
    vim.diagnostic.setqflist() -- 새로운 LSP 진단 정보 추가
    vim.cmd "copen"
  end
end
