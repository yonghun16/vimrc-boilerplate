require "nvchad.options"

------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
-- tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "html",
    "css",
    "lua",
    "dart",
    "R",
  },
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
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 200

------------------------------------------------------------------
-- Plugin options
------------------------------------------------------------------

-- Neovide
if vim.g.neovide then
  vim.g.neovide_opacity = 0.97
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h17"
  vim.opt.termguicolors = true

  -- Neovide terminal color for solarized_osaka
  vim.g.terminal_color_0 = "#073642"
  vim.g.terminal_color_1 = "#DC322F"
  vim.g.terminal_color_2 = "#859900"
  vim.g.terminal_color_3 = "#B58900"
  vim.g.terminal_color_4 = "#268BD2"
  vim.g.terminal_color_5 = "#D33682"
  vim.g.terminal_color_6 = "#2AA198"
  vim.g.terminal_color_7 = "#EEE8D5"
  vim.g.terminal_color_8 = "#002B36"
  vim.g.terminal_color_9 = "#CB4B16"
  vim.g.terminal_color_10 = "#586E75"
  vim.g.terminal_color_11 = "#657B83"
  vim.g.terminal_color_12 = "#839496"
  vim.g.terminal_color_13 = "#6C71C4"
  vim.g.terminal_color_14 = "#93A1A1"
  vim.g.terminal_color_15 = "#FDF6E3"
end

-- fzf
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"

-- visual-multi
vim.cmd [[ let g:VM_maps = {} ]]
vim.cmd [[ let g:VM_maps["Find Under"] = 's/' ]]
vim.cmd [[ let g:VM_maps["Find Subword Under"] = 's/' ]]
vim.cmd [[ let g:VM_maps["Add Cursor Down"] = 'sj' ]]
vim.cmd [[ let g:VM_maps["Add Cursor Up"] = 'sk' ]]
vim.cmd [[ let g:VM_maps["Move Right"] = 'sl' ]]
vim.cmd [[ let g:VM_maps["Move Left"] = 'sh' ]]
vim.cmd [[ let g:VM_maps["Mouse Cursor"] = 's<LeftMouse>' ]]
vim.cmd [[ let g:VM_maps["Add Cursor At Pos"] = 's<CR>' ]]
vim.cmd [[ let g:VM_maps["Select Operator"] = 'ss' ]]

-- Codium(Windsurf)
vim.g.codeium_enabled = true

-- emmet-vim
vim.g.user_emmet_leader_key = ","

-- nvim-Tree
require("nvim-tree").setup {
  hijack_cursor = true,

  on_attach = function(bufnr)
    local api = require "nvim-tree.api"

    api.config.mappings.default_on_attach(bufnr) -- 기본 키맵 적용

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.del("n", "<C-k>", { buffer = bufnr }) -- Ctrl+k 제거
    vim.keymap.set("n", "K", api.node.show_info_popup, opts "Show Info") -- Shift+k 로 파일 정보 보기
    vim.keymap.set("n", "i", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "s", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "t", api.node.open.tab, opts "Open: New Tab")
  end,
}

-- tagbar
vim.g.tagbar_width = 30
vim.g.tagbar_left = 1

-- Tagbar를 왼쪽에 열기
vim.g.tagbar_left = 1

-- indent-blankline
require("ibl").update {
  vim.api.nvim_set_hl(0, "IndentBlanklineChar", { underline = true }), -- function definitions (height -> underline)
}

-- snippets
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/custom/snippets" }

------------------------------------------------------------------
-- Functions
------------------------------------------------------------------

-- Safe Buffer Close
function SafeBufferClose()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    -- 변경사항이 있으면 확인 메시지
    local choice = vim.fn.confirm("There are unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then
      vim.cmd "write" -- 저장
      vim.cmd "bdelete" -- 버퍼 닫기
    elseif choice == 2 then
      vim.cmd "bdelete!" -- 저장하지 않고 강제 닫기
    else
      -- Cancel: 아무 것도 안 함
      return
    end
  else
    vim.cmd "bdelete" -- 변경사항 없으면 그냥 닫기
  end
end

-- Safe Quit
function SafeQuitAll()
  -- 저장되지 않은 버퍼가 있는지 확인
  local modified_bufs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].modified then
      table.insert(modified_bufs, buf)
    end
  end

  if #modified_bufs > 0 then
    local choice = vim.fn.confirm("There are unsaved changes. Save before quitting?", "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then
      vim.cmd "wa" -- 모든 버퍼 저장
      vim.cmd "qa" -- 종료
    elseif choice == 2 then
      vim.cmd "qa!" -- 저장하지 않고 종료
    else
      return -- Cancel: 종료 안 함
    end
  else
    vim.cmd "qa" -- 변경사항 없으면 그냥 종료
  end
end

-- Compile and Run
function Compile()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand "%:t:r" -- 파일 이름 (확장자 제외)
  local project_dir = vim.fn.expand "%:p:h" -- 현재 파일이 속한 디렉토리
  local filepath = vim.fn.expand "%:p" -- 전체 경로
  local bin_dir = os.getenv "HOME" .. "/bin"
  vim.fn.mkdir(bin_dir, "p") -- ~/bin 디렉토리 없으면 생성
  local binpath = bin_dir .. "/" .. filename

  vim.cmd "w" -- 항상 저장

  if filetype == "python" then
    vim.cmd(string.format('TermExec cmd="python3 %s"', filepath))
  elseif filetype == "javascript" then
    vim.cmd(string.format('TermExec cmd="node %s"', filepath))
  elseif filetype == "typescript" then
    local tsconfig_exists = vim.fn.filereadable "tsconfig.json" == 1
    if not tsconfig_exists then
      local tsconfig_content = {
        "{",
        '  "compilerOptions": {',
        '    "target": "ES2020",',
        '    "module": "ESNext",',
        '    "moduleResolution": "node",',
        '    "lib": ["ESNext", "Dom"],',
        '    "strict": true,',
        '    "skipLibCheck": true,',
        '    "esModuleInterop": true,',
        '    "forceConsistentCasingInFileNames": true',
        "  },",
        '  "include": ["src/**/*"],',
        '  "exclude": ["node_modules"]',
        "}",
      }
      vim.fn.writefile(tsconfig_content, "tsconfig.json")
    end
    -- ts-node로 직접 실행
    vim.cmd(string.format('TermExec cmd="ts-node %s"', filepath))
    -- 만약 ~/bin에 JS 파일로 컴파일 후 실행하고 싶으면 아래 주석 해제
    -- vim.cmd(string.format(":!tsc %s --outDir %s", filepath, bin_dir))
    -- vim.cmd(string.format('TermExec cmd="node %s/%s.js"', bin_dir, filename))
  elseif filetype == "c" then
    vim.cmd(string.format(":!gcc -o %s %s/*.c", binpath, project_dir))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  elseif filetype == "cpp" then
    vim.cmd(string.format(":!g++ -o %s %s/*.cpp", binpath, project_dir))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  elseif filetype == "java" then
    vim.cmd(string.format(":!javac -encoding utf-8 -d %s %s", bin_dir, filepath))
    vim.cmd(string.format('TermExec cmd="java -cp %s %s"', bin_dir, filename))
  else
    vim.cmd ':echo "This file is not a supported source file."'
  end
end

-- Reload and LSP Restart
function ReloadAndLSPRestart()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
    client:stop(true)
  end
  vim.defer_fn(function()
    vim.cmd "edit" -- 버퍼를 다시 로드하여 LSP 자동 attach 유도
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

-- Move Cursor to Center
function MoveCursorToCenter()
  local col = vim.fn.col "$" / 2
  vim.cmd.normal { args = { "0" .. math.floor(col) .. "l" }, bang = true }
end

-- Toggle Codium(Windsurf) 토글 함수
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

-- Gemini CLI 토글 함수
local gemini_term = nil -- 사이드바 터미널용 변수
function ToggleGemini()
  if gemini_term and vim.api.nvim_win_is_valid(gemini_term) then
    vim.api.nvim_win_close(gemini_term, true) -- 닫기
    gemini_term = nil
  else
    -- 오른쪽 vertical split에 터미널 열기
    vim.cmd "vsplit"
    vim.cmd "wincmd l" -- 오른쪽으로 이동
    vim.cmd "resize 45" -- 너비 조정

    -- 터미널 실행
    vim.cmd "terminal gemini chat"
    gemini_term = vim.api.nvim_get_current_win()
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
  local filetype = vim.bo[current_buf].filetype

  -- NvDash 화면인지 판별: 파일 이름이 없거나 특정 filetype인 경우
  if filetype == "alpha" or filetype == "dashboard" or filetype == "starter" then
    vim.cmd "b#" -- 이전 버퍼로 이동
  else
    vim.cmd "Nvdash" -- NvDash 열기
  end
end

-- NvimTree 현재 버퍼 파일 경로 기준으로 위치 맞추는 함수
function Sync_nvimtree_to_current_buffer()
  local api = require "nvim-tree.api"
  local filepath = vim.api.nvim_buf_get_name(0)
  local ft = vim.bo.filetype

  if filepath == "" or ft == "NvimTree" or ft == "nvimtree" then
    print "빈 버퍼거나 NvimTree 버퍼라서 리턴됨"
    return
  end

  local dir = vim.fn.fnamemodify(filepath, ":h")

  -- Neovim 현재 작업 디렉토리 변경
  vim.cmd("lcd " .. dir)
  print("Working directory changed: " .. dir)

  if api.tree.is_visible() then
    -- NvimTree가 열려 있으면 트리 루트만 변경
    api.tree.change_root(dir)
  end
  -- NvimTree가 닫혀있으면 열지 않고, 사용자가 수동으로 열도록 놔둠
end
