require "nvchad.mappings"
local map = vim.keymap.set

local api = require "nvim-tree.api"
local dap = require "dap"
local dapui = require "dapui"

-- =====================================
-- Escape, Close, Quit
-- =====================================
map({ "n", "i", "v", "c" }, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<leader>w", SafeBufferClose, { desc = "Safe close buffer", noremap = true, silent = true })
map("n", "<leader>q", SafeQuitAll, { desc = "Safe quit all", noremap = true, silent = true })
map("v", "<leader>y", ":<C-U> '<,'>w !termux-clipboard-set<CR><CR>", { desc = "Copy selection to Android clipboard" })

-- =====================================
-- AI, 터미널 단축키 적용
-- =====================================
-- 터미널 단축키 적용
map("i", "<C-h>", "<BS>")
map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")
map("i", "<C-a>", "<C-\\><C-o>^")
map("i", "<C-e>", "<C-\\><C-o>$")
map("i", "<C-d>", "<Del>")
map("i", "<C-u>", "<C-\\><C-o>d^")
map("i", "<C-w>", "<C-\\><C-o>dB")
map("i", "<C-k>", "<C-\\><C-o>d$")
map("i", "<C-CR>", "<Esc>o")
map("i", "<C-j>", "<CR>")
map("i", "<C-s>", "<Esc><C-s>")

-- Codeium(WindSurf) / 자동완성
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true })
map("i", "<Tab>", "codeium#Accept()", { expr = true, silent = true, nowait = true, desc = "Accept Codeium suggestion" })
map(
  "i",
  "<C-;>",
  "codeium#AcceptNextLine()",
  { expr = true, silent = true, nowait = true, desc = "Accept next line from Codeium" }
)
map(
  "i",
  "<C-'>",
  "codeium#AcceptNextWord()",
  { expr = true, silent = true, nowait = true, desc = "Accept next word from Codeium" }
)
map("i", "<C-.>", function()
  vim.cmd "call codeium#CycleCompletions(1)"
end, { silent = true, desc = "Cycle Codeium completions forward" })
map("i", "<C-,>", function()
  vim.cmd "call codeium#CycleCompletions(-1)"
end, { silent = true, desc = "Cycle Codeium completions backward" })
map("i", "<C-x>", function()
  vim.cmd "call codeium#Clear()"
end, { silent = true, desc = "Clear Codeium suggestion" })
map("n", "<C-i>", "<C-i>", { noremap = true, silent = true })
map("n", "ta", ToggleAIAutoComplete) -- Toggle Codieum(WindSurf) On/Off

-- =====================================
-- Cursor, Screen, Tab
-- =====================================
-- 커서 이동
map("n", "s", "")
map({ "n", "v" }, "<C-h>", "^")
map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-k>", "5k")
map({ "n", "v" }, "<C-l>", "$")
map({ "n", "v" }, "<C-m>", MoveCursorToCenter, { noremap = true, silent = true })
map({ "n", "v" }, "<C-;>", "%")

-- 화면 이동
map({ "n", "v" }, "<C-n>", "5<C-e>")
map({ "n", "v" }, "<C-p>", "5<C-y>")
map({ "n", "v" }, "<C-.>", "6zl")
map({ "n", "v" }, "<C-,>", "6zh")

-- Tab 이동
map("n", "te", function() -- new tab
  vim.cmd "tabedit"
end)
map("n", "tt", function() -- new tab to terminal
  vim.cmd "tabedit"
  vim.cmd "terminal"
  vim.api.nvim_feedkeys("i", "n", false)
end)
map("n", "tx", function() -- tab close
  vim.cmd "tabclose"
end)
map("n", "tn", function() -- tab next
  vim.cmd "tabnext"
end)
map("n", "tp", function() -- tab previous
  vim.cmd "tabprevious"
end)

-- =====================================
-- Split window, tmux pane
-- =====================================
-- Split window
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
-- map("n", "<D-h>", "<C-w>h")
-- map("n", "<D-j>", "<C-w>j")
-- map("n", "<D-k>", "<C-w>k")
-- map("n", "<D-l>", "<C-w>l")
-- map("n", "<D-p>", "<C-w>4+")
-- map("n", "<D-n>", "<C-w>4-")
-- map("n", "<D-.>", "<C-w>15>")
-- map("n", "<D-,>", "<C-w>15<")
-- map("n", "<D-m>", "<C-w>=")

-- tmux pane
-- <A-l> = right move
-- <A-h> = left move
-- <A-j> = down move
-- <A-k> = up move
-- <A-.> = increase width
-- <A-,> = decrease width
-- <A-p> = decrease height
-- <A-n> = increase height

-- =====================================
-- Editor
-- =====================================
-- 컴파일 & 런
map("n", "<leader>a", Compile, { desc = "Compile" })
map("n", "<leader>A", CompileSingle, { desc = "Compile single" })

-- Folding
map("n", "tw", ToggleWrapCodes)
map("n", "tf", ToggleFoldColumn)
map("n", "z.", FoldColumnExpands, { noremap = true, silent = true })
map("n", "zmv", function()
  vim.cmd "mkview"
end, { noremap = true, silent = true })
map("n", "zlv", function()
  vim.cmd "loadview"
end, { noremap = true, silent = true })

-- Visual block 이동
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- 새로고침
map("n", "<leader>r", ReloadAndLSPRestart, { desc = "Reload file and restart LSP" })

-- Git push
map("n", "<leader>p", CommitAndPush, { desc = "Git commit and push" })

-- 파일 비교
map("n", "<leader>v", ":vert diffsplit ", { desc = "Diffsplit" })

-- 현재 파일 위치로 트리 이동
map("n", "<leader>.", function()
  if api.tree.is_visible() then
    api.tree.toggle()
    api.tree.find_file { open = true }
  else
    api.tree.find_file { open = true }
  end
end, { desc = "Smart NvimTree Find File" })

-- 현재 파일의 디렉토리를 루트로 변경
map("n", "<leader>>", function()
  local path = vim.fn.expand "%:p:h"
  api.tree.change_root(path)
  vim.notify("NvimTree root changed to: " .. path, vim.log.levels.INFO)
end, { desc = "NvimTree: change root to current file dir" })

-- toggle transparency
map(
  "n",
  "<leader>tt",
  ":lua require('base46').toggle_transparency()<CR>",
  { noremap = true, silent = true, desc = "Toggle Background Transparency" }
)

-- Diagnostics
map("n", "sd", vim.diagnostic.open_float)

-- LSP signature help
map("n", "ss", vim.lsp.buf.signature_help)

-- WhichKey (mappings explorer)
map("n", "<leader>s", function()
  vim.cmd "WhichKey <leader>"
end, { desc = "Show mappings" })

-- =====================================
-- Debugging
-- =====================================
map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" }) -- 중단점 설정/해제 (debug breakpoint)
map("n", "<leader><SPACE>", dap.continue, { desc = "Debug: Continue" }) -- 디버깅 시작 또는 계속 진행 (Start or Continue Debugging)
map("n", "<leader>db", function()
  dap.toggle_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debug: Toggle Conditional Breakpoint" }) -- 조건부 중단점 설정 (debug breakpoint conditional) 조건이 참(true)일 때만 실행을 멈춥니다.
map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" }) -- 한 줄 실행 (debug over)
map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" }) -- 함수 안으로 들어가기 (debug into)
map("n", "<leader>dk", dap.step_out, { desc = "Debug: Step Out" }) -- 현재 함수 빠져나가기 (debug out)
map("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" }) -- 디버깅 세션 종료 (debug quit)
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" }) -- 디버깅 UI 창 열기/닫기 (debug ui toggle)

-- =====================================
-- Sidebars (h, j, k, l)
-- =====================================
vim.api.nvim_del_keymap("n", "<leader>e") -- for nvimtree
map("n", "<leader>h", function() -- nvimtree (left side)
  vim.cmd "NvimTreeToggle"
end, { desc = "File explorer" })
map("n", "<leader>k", function() -- outline (left side)
  vim.cmd "Outline"
end, { desc = "Outline" })
map("n", "<leader>K", function() -- tagbar (left side)
  vim.cmd "TagbarToggle"
end, { desc = "Tagbar" })
map({ "n", "t" }, "<leader>j", function() -- terminal(bottom side)
  vim.cmd "ToggleTerm size=10 direction=horizontal"
end, { desc = "Terminal(bottom)" })
map("n", "<leader>J", ToggleDiagnostics_qflist, { desc = "Diagnostics message" }) -- Diagnostics message (bottom side)
map({ "n", "t" }, "<leader><leader>", function() -- terminal(floating)
  vim.cmd "ToggleTerm direction=float"
end, { desc = "Terminal(floating)" })
map("n", "<leader>l", function() -- Gemini (right side)
  require("custom.gemini").toggle()
end, { desc = "Gemini CLI Toggle", noremap = true, silent = true })

-- =====================================
-- Explorer
-- =====================================
map("n", "<leader>f", function() -- FZF (file explorer)
  require("fzf-lua").files()
end, { desc = "FZF file" })
map("n", "<leader>g", function() -- FZF grep (word explorer)
  require("fzf-lua").grep()
end, { desc = "FZF grep" })
map("n", "<leader><tab>", function() -- JABS (buffer explorer)
  vim.cmd "JABSOpen"
end, { desc = "Show buffers" })
map("n", "<leader>n", ToggleNvDash, { -- NvDash (front Screen)
  desc = "NvDash screen",
  noremap = true,
  silent = true,
})
