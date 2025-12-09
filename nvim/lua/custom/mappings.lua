require "nvchad.mappings"

-- ================================================================
-- Environment
-- ================================================================
local map = vim.keymap.set
local api = require "nvim-tree.api"
local dap = require "dap"
local dapui = require "dapui"
vim.api.nvim_del_keymap("n", "<leader>n") -- toogle number line
vim.api.nvim_del_keymap("n", "<leader>gt") -- git status
vim.keymap.set("n", "s", "")

-- ================================================================
-- Escape, Quit
-- ================================================================
map({ "n", "i", "v", "c" }, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<leader>q", SafeQuitAll, { desc = "Safe quit all", noremap = true, silent = true })

-- ================================================================
-- Apply terminal keybindings in INSERT Mode
-- ================================================================
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

-- ================================================================
-- AI / Debugging
-- ================================================================
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
map("i", "<C-.>", function() -- Cycle completions
  vim.cmd "call codeium#CycleCompletions(1)"
end, { silent = true, desc = "Cycle Codeium completions forward" })
map("i", "<C-,>", function() -- Cycle completions
  vim.cmd "call codeium#CycleCompletions(-1)"
end, { silent = true, desc = "Cycle Codeium completions backward" })
map("i", "<C-x>", function() -- Clear completions
  vim.cmd "call codeium#Clear()"
end, { silent = true, desc = "Clear Codeium suggestion" })
map("n", "<C-i>", "<C-i>", { noremap = true, silent = true })
map("n", "<leader>ta", ToggleAIAutoComplete, { desc = "toggle AI AutoComplete" }) -- Toggle Codieum(WindSurf) On/Off

-- nvim-dap (Debugging)
map("n", "<leader>z", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" }) -- 중단점 설정/해제 (debug breakpoint)
map("n", "<leader><SPACE>", dap.continue, { desc = "Debug: Continue" }) -- 디버깅 시작 또는 계속 진행 (Start or Continue Debugging)
map("n", "<leader>db", function()
  dap.toggle_breakpoint(vim.fn.input "Breakpoint condition: ") -- 조건부 중단점 설정 (debug breakpoint conditional) -> 조건이 참(true)일 때만 실행을 멈춤.
end, { desc = "Debug: Toggle Conditional Breakpoint" })
map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" }) -- 한 줄 실행 (debug over)
map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" }) -- 함수 안으로 들어가기 (debug into)
map("n", "<leader>dk", dap.step_out, { desc = "Debug: Step Out" }) -- 현재 함수 빠져나가기 (debug out)
map("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" }) -- 디버깅 세션 종료 (debug quit)
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" }) -- 디버깅 UI 창 열기/닫기 (debug ui toggle)

-- ================================================================
-- Cursor, Screen, Block, Tab, Split
-- ================================================================
-- Cursor move
map({ "n", "v" }, "<C-h>", "^")
map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-k>", "5k")
map({ "n", "v" }, "<C-l>", "$")
map({ "n", "v" }, "<C-;>", "%")

-- Screen move
map({ "n", "v" }, "<C-n>", "5<C-e>")
map({ "n", "v" }, "<C-p>", "5<C-y>")
map({ "n", "v" }, "<C-.>", "6zl")
map({ "n", "v" }, "<C-,>", "6zh")

-- Visual block
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Tab move
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

-- Split window
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- ================================================================
-- Editor
-- ================================================================
-- Compile and Run
map("n", "<leader>a", Compile, { desc = "Code Compile" })
map("n", "<leader>A", CompileSingle, { desc = "Code Compile (single)" })

-- Reload
map("n", "<leader>R", ReloadAndLSPRestart, { desc = "reload File and Restart LSP" })

-- Diffsplit(파일 비교)
map("n", "<leader>v", ":vert diffsplit ", { desc = "Diffsplit (compare files)" })

-- Change root directory
map("n", "<leader>.", function()
  local path = vim.fn.expand "%:p:h"
  api.tree.change_root(path)
  vim.notify("NvimTree root changed to: " .. path, vim.log.levels.INFO)
end, { desc = "Change root to current file dir" })

-- Toggle FoldColumn
map("n", "<leader>tf", ToggleFoldColumn, { desc = "toggle FoldColumn" })

-- Toggle Transparency
map(
  "n",
  "<leader>tt",
  ":lua require('base46').toggle_transparency()<CR>",
  { noremap = true, silent = true, desc = "toggle Transparency" }
)

-- ================================================================
-- Sidebars (h, j, k, l)
-- ================================================================
-- Nvimtree (left side)
map("n", "<leader>h", function()
  vim.cmd "NvimTreeToggle"
end, { desc = "toggle Explorer" })

-- Nvimtree (left side: current file)
map("n", "<leader>H", function()
  api.tree.find_file { open = true, focus = true }
end, { desc = "find current File" })

-- Outline (left side)
map("n", "<leader>k", function()
  vim.cmd "Outline"
end, { desc = "toggle Outline" })

-- Terminal (bottom side)
map({ "n", "t" }, "<leader>j", function()
  vim.cmd "ToggleTerm size=10 direction=horizontal"
end, { desc = "Terminal (bottom)" })

-- terminal (floating)
map({ "n", "t" }, "<leader><leader>", function()
  vim.cmd "ToggleTerm direction=float"
end, { desc = "Terminal (floating)" })

-- Gemini (right side)
map("n", "<leader>l", function()
  require("custom.gemini").toggle()
end, { desc = "toggle Gemini CLI", noremap = true, silent = true })

-- ================================================================
-- Explorer
-- ================================================================
-- file explorer (fzf files)
map("n", "<leader>e", function()
  require("fzf-lua").files()
end, { desc = "find Files (fzf)" })

-- grep explorer (fzf grep)
map("n", "<leader>g", function()
  require("fzf-lua").grep()
end, { desc = "find Grep (fzf)" })

-- buffer explorer (fzf buffers)
map("n", "<leader><tab>", function()
  require("fzf-lua").buffers()
end, { desc = "find Buffers (fzf)" })

-- WhichKey
map("n", "<leader>s", function()
  vim.cmd "WhichKey <leader>"
end, { desc = "find Mappings" })

-- Diagnostics message
map("n", "sd", vim.diagnostic.open_float)

-- LSP signature help
map("n", "ss", vim.lsp.buf.signature_help)
