require "nvchad.mappings"

local map = vim.keymap.set

-- =====================================
-- 기본 종료 동작 (Escape, Close, Quit)
-- =====================================
map({ "n", "i", "v", "c" }, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<leader>w", SafeBufferClose, { desc = "Safe close buffer", noremap = true, silent = true })
map("n", "<leader>q", SafeQuitAll, { desc = "Safe quit all", noremap = true, silent = true })

-- =====================================
-- Insert 모드 입력
-- =====================================
-- 터미널 단축키 적용
map("i", "<C-h>", "<BS>")
map("i", "<C-w>", "<C-\\><C-o>dB")
map("i", "<C-b>", "<Left>")
map("i", "<C-a>", "<C-\\><C-o>^")
map("i", "<C-e>", "<C-\\><C-o>$")
map("i", "<C-d>", "<Del>")
map("i", "<C-j>", "<CR>")
map("i", "<C-u>", "<C-\\><C-o>d^")
map("i", "<C-k>", "<C-\\><C-o>d$")
map("i", "<C-f>", "<Right>")
map("i", "<C-CR>", "<Esc>o")
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
-- 커서 이동 / 화면 이동
-- =====================================
-- 커서 이동
map("n", "s", "")
map({ "n", "v" }, "<C-l>", "L")
map({ "n", "v" }, "<C-h>", "H")
map({ "n", "v" }, "<C-m>", "M")
map({ "n", "v" }, "<C-k>", "5k")
map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "sl", "$")
map({ "n", "v" }, "sh", "^")
map({ "n", "v" }, "sm", function()
  local col = vim.fn.col "$" / 2
  vim.cmd.normal { args = { "0" .. math.floor(col) .. "l" }, bang = true }
end, { noremap = true, silent = true })
map({ "n", "v" }, "sk", "{")
map({ "n", "v" }, "sj", "}")
map({ "n", "v" }, "sg", "%")

-- 화면 이동
map({ "n", "v" }, "<C-n>", "5<C-e>")
map({ "n", "v" }, "<C-p>", "5<C-y>")
map({ "n", "v" }, "<C-S-l>", "6zl")
map({ "n", "v" }, "<C-S-h>", "6zh")

-- =====================================
-- 분할 창 이동 / Tab 이동
-- =====================================
-- Terminal mode 분할 창 이동
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

-- Normal mode 분할 창 이동, 크기 조절 (karabiner에서 설정해야함)
-- map("n", "<D-k>", "<C-w>k")
-- map("n", "<D-j>", "<C-w>j")
-- map("n", "<D-l>", "<C-w>l")
-- map("n", "<D-h>", "<C-w>h")
-- map("n", "<D-p>", "<C-w>4+")
-- map("n", "<D-n>", "<C-w>4-")
-- map("n", "<D-.>", "<C-w>15>")
-- map("n", "<D-,>", "<C-w>15<")
-- map("n", "<D-m>", "<C-w>=")

-- Tab 이동
map("n", "te", function()
  vim.cmd "tabedit"
end)
map("n", "tt", function()
  vim.cmd "tabedit"
  vim.cmd "terminal"
  vim.api.nvim_feedkeys("i", "n", false)
end)
map("n", "tx", function()
  vim.cmd "tabclose"
end)
map("n", "tn", function()
  vim.cmd "tabnext"
end)
map("n", "tp", function()
  vim.cmd "tabprevious"
end)

-- =====================================
-- 편집 관련
-- =====================================
-- 컴파일 & 런
map("n", "<leader>a", Compile, { desc = "compile" })

-- 폴딩 관련
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

-- 검색 초기화 / 새로고침
map("n", "<C-BS>", function()
  vim.cmd "noh"
end, { desc = "clean search item" })
map("n", "<leader>r", ReloadAndLSPRestart, { desc = "Reload file and restart LSP" })

-- Git push
map("n", "<leader>p", CommitAndPush, { desc = "Git commit and push" })

-- 파일 비교
map("n", "<leader>v", ":vert diffsplit ", { desc = "diffsplit" })

-- 현재 파일 위치를 작업 디렉토리로 바꾸기
map("n", "<leader>.", Sync_nvimtree_to_current_buffer, { desc = "Sync NvimTree to current buffer path" })

-- =====================================
-- 디버깅
-- =====================================
local dap = require "dap"
local dapui = require "dapui"

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" }) -- 중단점 설정/해제 (debug breakpoint)
vim.keymap.set("n", "<leader><SPACE>", dap.continue, { desc = "Debug: Continue" }) -- 디버깅 시작 또는 계속 진행 (Start or Continue Debugging)
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debug: Toggle Conditional Breakpoint" }) -- 조건부 중단점 설정 (debug breakpoint conditional) 조건이 참(true)일 때만 실행을 멈춥니다.
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" }) -- 한 줄 실행 (debug over)
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" }) -- 함수 안으로 들어가기 (debug into)
vim.keymap.set("n", "<leader>dk", dap.step_out, { desc = "Debug: Step Out" }) -- 현재 함수 빠져나가기 (debug out)
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" }) -- 디버깅 세션 종료 (debug quit)
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" }) -- 디버깅 UI 창 열기/닫기 (debug ui toggle)

-- =====================================
-- Split, Floating, Hover Windows
-- =====================================
vim.api.nvim_del_keymap("n", "<leader>e") -- for nvimtree

-- Split
map("n", "<leader>h", function() -- nvimtree
  vim.cmd "NvimTreeToggle"
end, { desc = "nvimtree" })
map({ "n", "t" }, "<leader>j", function() -- terminal(split)
  vim.cmd "ToggleTerm size=10 direction=horizontal"
end, { desc = "terminal(bottom)" })
map("n", "<leader>k", function() -- outline
  vim.cmd "Outline"
end, { desc = "outline" })
map("n", "<leader>K", function() -- tagbar
  vim.cmd "TagbarToggle"
end, { desc = "tagbar" })
map("n", "<leader>l", function() -- Gemini
  require("custom.gemini").toggle()
end, { desc = "Gemini CLI Toggle", noremap = true, silent = true })
map("n", "<leader>dd", ToggleDiagnostics_qflist, { desc = "diagnostics list" }) -- diagnostics Split

-- Floating
map("n", "<leader>s", ToggleNvDash, { desc = "NvDash screen", noremap = true, silent = true }) -- NvDash
map({ "n", "t" }, "<leader><leader>", function() -- terminal(floating)
  vim.cmd "ToggleTerm direction=float"
end, { desc = "terminal(floating)" })
map("n", "<leader>f", function() -- FZF
  require("fzf-lua").files()
end, { desc = "FZF file explorer" })
map("n", "<leader>g", function() -- FZF grep
  require("fzf-lua").grep()
end, { desc = "FZF grep explorer" })
map("n", "<leader><tab>", function() -- JABS
  vim.cmd "JABSOpen"
end, { desc = "show buffers" })
map("n", "s<leader>", function() -- WhichKey
  vim.cmd "WhichKey <leader>"
end)

-- Hover
map("n", "sd", vim.diagnostic.open_float) -- diagnostics
map("n", "ss", vim.lsp.buf.hover) -- lsp hover
map("n", "sf", vim.lsp.buf.signature_help) -- lsp signature help
