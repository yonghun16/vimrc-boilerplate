require "nvchad.options"

-- add yours here!

------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
-- cursorline
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

-- Lsp ts_ls 설정(js에서 ts로 파일변경 시 적용)
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.ts",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- filetype이 잘못되었으면 typescript로 설정
    if vim.bo.filetype ~= "typescript" then
      vim.bo.filetype = "typescript"
    end

    -- ts_ls 클라이언트가 연결되어 있는지 확인
    local has_tsclient = false
    for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client.name == "ts_ls" then
        has_tsclient = true
        break
      end
    end

    -- 없으면 ts_ls 시작
    if not has_tsclient then
      vim.cmd("LspStart ts_ls")
    end
  end,
})

-- tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "json", "html", "css", "lua", "dart", "R" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- number line
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- scroll
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

-- folding
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- etc
vim.opt.wrap = false
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h16"
vim.opt.updatetime = 200


------------------------------------------------------------------
-- Plugin options
------------------------------------------------------------------
-- fzf
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"

-- visual-multi
vim.cmd [[ let g:VM_maps = {} ]]
vim.cmd [[ let g:VM_maps["Find Under"] = '<C-x>/' ]]
vim.cmd [[ let g:VM_maps["Find Subword Under"] = '<C-x>/' ]] -- used in Visual Mode
vim.cmd [[ let g:VM_maps["Add Cursor At Pos"] = '<C-RIGHT>' ]]
-- Goto Next ],  Goto Prev [,  Skip Region q,  Remove Region Q

-- Codium(Windserf)
vim.g.codeium_enabled = true

-- emmet-vim
vim.g.user_emmet_leader_key = ","

-- nvim-Tree
require("nvim-tree").setup({
  hijack_cursor = true,

  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    api.config.mappings.default_on_attach(bufnr) -- 기본 키맵 적용

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.del("n", "<C-k>", { buffer = bufnr })  -- Ctrl+k 제거
    vim.keymap.set("n", "K", api.node.show_info_popup, opts("Show Info")) -- Shift+k 로 파일 정보 보기
  end,
})

-- tagbar
vim.g.tagbar_width = 30

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
local tsconfig = {
  '{',
  '  "compilerOptions": {',
  '    "target": "ES2020",',
  '    "module": "ESNext",',
  '    "moduleResolution": "node",',
  '    "lib": ["ESNext", "Dom"],',
  '    "strict": true,',
  '    "skipLibCheck": true,',
  '    "esModuleInterop": true,',
  '    "forceConsistentCasingInFileNames": true',
  '  },',
  '  "include": ["src/**/*"],',
  '  "exclude": ["node_modules"]',
  '}'
}

function Compile()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd "w"
    vim.cmd 'TermExec cmd="python3 %<.py"'
  elseif filetype == "javascript" then
    vim.cmd "w"
    vim.cmd 'TermExec cmd="node %<.js"'
  elseif filetype == "typescript" then
    vim.cmd "w"
    local tsconfig_exists = vim.fn.filereadable "tsconfig.json" == 1
    if not tsconfig_exists then
      vim.fn.writefile(tsconfig, "tsconfig.json")
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

-- Reload and LSP Restart
function ReloadAndLSPRestart()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    client:stop(true)
  end
  vim.defer_fn(function()
    vim.cmd("edit") -- 버퍼를 다시 로드하여 LSP 자동 attach 유도
  end, 100)
end

-- Git Commit and Push
function CommitAndPush()
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

-- Toggle AI Auto Complete (using Codium)
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

-- Foldcolumn Expands
function FoldColumnExpands()
  if vim.wo.foldcolumn == "4" then
    vim.wo.foldcolumn = "8"
  elseif vim.wo.foldcolumn == "8" then
    vim.wo.foldcolumn = "4"
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

-- Toggle NvDash
function ToggleNvDash()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_name = vim.api.nvim_buf_get_name(current_buf)
  local filetype = vim.bo[current_buf].filetype

  -- NvDash 화면인지 판별: 파일 이름이 없거나 특정 filetype인 경우
  if current_name == "" or filetype == "alpha" or filetype == "dashboard" or filetype == "starter" then
    vim.cmd("b#")  -- 이전 버퍼로 이동
  else
    vim.cmd("Nvdash")  -- NvDash 열기
  end
end
