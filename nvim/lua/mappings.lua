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
-- Insert 모드 / 입력 관련
-- =====================================
-- 터미널 단축키 적용
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-j>", "<ENTER>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><RIGHT>C")
map("i", "<C-f>", "<C-RIGHT>")
map("i", "<C-v>", "<C-LEFT>")
map("i", "<C-CR>", "<ESC>o")
map("i", "<C-s>", "<ESC><C-s>")

-- Codeium(WindSurf) / 자동완성
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true })
map("i", "<Tab>", "codeium#Accept()", { expr = true, silent = true, nowait = true, desc = "Accept Codeium suggestion" })
map("i", "<C-;>", "codeium#AcceptNextLine()", { expr = true, silent = true, nowait = true, desc = "Accept next line from Codeium" })
map("i", "<C-'>", "codeium#AcceptNextWord()", { expr = true, silent = true, nowait = true, desc = "Accept next word from Codeium" })
map("i", "<C-.>", function() vim.cmd("call codeium#CycleCompletions(1)") end, { silent = true, desc = "Cycle Codeium completions forward" })
map("i", "<C-,>", function() vim.cmd("call codeium#CycleCompletions(-1)") end, { silent = true, desc = "Cycle Codeium completions backward" })
map("i", "<C-x>", function() vim.cmd("call codeium#Clear()") end, { silent = true, desc = "Clear Codeium suggestion" })
map("n", "<C-i>", "<C-i>", { noremap = true, silent = true })

-- Toggle Codieum(WindSurf) On/Off
map("n", "ta", ToggleAIAutoComplete)


-- =====================================
-- 커서 이동 & 화면 스크롤
-- =====================================
map({ "n", "v" }, "<C-k>", "5k")
map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-l>", "$")
map({ "n", "v" }, "<C-h>", "^")
map({ "n", "v" }, "<C-n>", "5<C-e>")
map({ "n", "v" }, "<C-p>", "5<C-y>")
map({ "n", "v" }, "<C-S-l>", "6zl")
map({ "n", "v" }, "<C-S-h>", "6zh")


-- =====================================
-- 분할 창(Split Window) / Tab 관리
-- =====================================
-- Terminal mode 분할 창 이동
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

-- Normal mode 분할 창 이동, 크기 조절 (karabiner 에서 설정해야함)
-- map("n", "<D-k>", "<C-w>k")
-- map("n", "<D-j>", "<C-w>j")
-- map("n", "<D-l>", "<C-w>l")
-- map("n", "<D-h>", "<C-w>h")
-- map("n", "<D-p>", "<C-w>3+")
-- map("n", "<D-n>", "<C-w>3-")
-- map("n", "<D-.>", "<C-w>15>")
-- map("n", "<D-,>", "<C-w>15<")
-- map("n", "<D-m>", "<C-w>=")

-- Tab 관리
map("n", "te", function() vim.cmd("tabedit") end)
map("n", "tx", function() vim.cmd("tabclose") end)
map("n", "tn", function() vim.cmd("tabnext") end)
map("n", "tp", function() vim.cmd("tabprevious") end)


-- =====================================
-- 편집 관련
-- =====================================
-- 컴파일 & 런
map("n", "<leader>a", Compile, { desc = "compile" })

-- 폴딩 관련
map("n", "tw", ToggleWrapCodes)
map("n", "tf", ToggleFoldColumn)
map("n", "z.", FoldColumnExpands, { noremap = true, silent = true })
map("n", "zmv", function() vim.cmd("mkview") end, { noremap = true, silent = true })
map("n", "zlv", function() vim.cmd("loadview") end, { noremap = true, silent = true })

-- Visual block 이동
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- 검색 초기화 / 새로고침
map("n", "<leader><SPACE>", function() vim.cmd("noh") end, { desc = "clean search item" })
map("n", "<Leader>r", ReloadAndLSPRestart, { desc = "Reload file and restart LSP" })


-- Git push
map("n", "<leader>p", CommitAndPush, { desc = "Git commit and push" })

-- 파일 비교
map("n", "<leader>v", ":vert diffsplit ", { desc = "diffsplit" })

-- 현재 파일 위치를 작업 디렉토리로 바꾸기
map("n", "<leader>.", Sync_nvimtree_to_current_buffer, { desc = "Sync NvimTree to current buffer path" })


-- =====================================
-- 정보 표시 / LSP 관련
-- =====================================
map("n", "s", "")
map("n", "ss", ToggleNvDash, { desc = "NvDash screen", noremap = true, silent = true })
map("n", "sm", function() vim.cmd("message") end)
map("n", "sr", function() vim.cmd("reg") end)
map("n", "sd", vim.diagnostic.open_float)
map("n", "sk", vim.lsp.buf.hover)
map("n", "sl", vim.lsp.buf.signature_help)
map("n", "s<leader>", function() vim.cmd("WhichKey <leader>") end)


-- =====================================
-- Sidebar / Floating / Terminal
-- =====================================
vim.api.nvim_del_keymap("n", "<leader>e")     -- for nvimtree
vim.api.nvim_del_keymap("n", "<leader>ds")    -- for diagnostics list
map("n", "<leader>h", function() vim.cmd("NvimTreeToggle") end, { desc = "nvimtree" })
map({ "n", "t" }, "<leader><leader>", function() vim.cmd("ToggleTerm direction=float") end, { desc = "terminal(floating)" })
map({ "n", "t" }, "<leader>j", function() vim.cmd("ToggleTerm size=10 direction=horizontal") end, { desc = "terminal(bottom)" })
map("n", "<leader>k", function() vim.cmd("Outline") end, { desc = "outline" })
map("n", "<leader>K", function() vim.cmd("TagbarToggle") end, { desc = "tagbar" })
map("n", "<leader>l", function() require("custom.gemini").toggle() end, { desc = "Gemini CLI Toggle", noremap = true, silent = true })
map("n", "<leader>d", ToggleDiagnostics_qflist, { desc = "diagnostics list" })
map("n", "<leader>f", function() require('fzf-lua').files() end, { desc = "FZF file explorer" })
map("n", "<leader>g", function() require('fzf-lua').grep() end, { desc = "FZF grep explorer" })
map("n", "<leader><tab>", function() vim.cmd("JABSOpen") end, { desc = "show buffers" })

