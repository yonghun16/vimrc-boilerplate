require "nvchad.mappings"

local map = vim.keymap.set


-- =====================================
-- 기본 키보드 동작 (Escape, Close, Quit)
-- =====================================
vim.api.nvim_del_keymap("n", "<leader>e")     -- for nvimtree
vim.api.nvim_del_keymap("n", "<leader>ds")    -- for diagnostics list

map({ "n", "i", "v", "c" }, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<leader>w", vim.cmd.bd, { desc = "close buffer", noremap = true, silent = true })
map("n", "<leader>q", vim.cmd.qa, { desc = "quit" })


-- =====================================
-- Insert 모드 / 입력 관련
-- =====================================
-- 기본 이동/편집
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-j>", "<ENTER>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><RIGHT>C")

-- 추가 편의 키
map("i", "<C-f>", "<C-RIGHT>")
map("i", "<C-v>", "<C-LEFT>")
map("i", "<C-CR>", "<ESC>o")
map("i", "<C-s>", "<ESC><C-s>")

-- Codeium / 자동완성
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true })
map("i", "<Tab>", "codeium#Accept()", { expr = true, silent = true, nowait = true, desc = "Accept Codeium suggestion" })
map("i", "<C-;>", "codeium#AcceptNextLine()", { expr = true, silent = true, nowait = true, desc = "Accept next line from Codeium" })
map("i", "<C-'>", "codeium#AcceptNextWord()", { expr = true, silent = true, nowait = true, desc = "Accept next word from Codeium" })
map("i", "<C-.>", "<Cmd>call codeium#CycleCompletions(1)<CR>", { silent = true, desc = "Cycle Codeium completions forward" })
map("i", "<C-,>", "<Cmd>call codeium#CycleCompletions(-1)<CR>", { silent = true, desc = "Cycle Codeium completions backward" })
map("i", "<C-x>", "<Cmd>call codeium#Clear()<CR>", { silent = true, desc = "Clear Codeium suggestion" })
map("n", "<C-i>", "<C-i>", { noremap = true, silent = true }) -- Separate <Tab> and <C-i>


-- =====================================
-- 커서 이동 & 화면 스크롤
-- =====================================
-- 커서 이동
map({ "n", "v" }, "<C-k>", "3k")
map({ "n", "v" }, "<C-j>", "3j")
map({ "n", "v" }, "<C-l>", "$")
map({ "n", "v" }, "<C-h>", "^")

-- 화면 스크롤
map({ "n", "v" }, "<C-n>", "3<C-e>")
map({ "n", "v" }, "<C-p>", "3<C-y>")
map({ "n", "v" }, "<C-S-l>", "6zl")
map({ "n", "v" }, "<C-S-h>", "6zh")


-- =====================================
-- 창(Window) 관리
-- =====================================
-- 분할창 이동
map("n", "<D-k>", "<C-w>k")
map("n", "<D-j>", "<C-w>j")
map("n", "<D-l>", "<C-w>l")
map("n", "<D-h>", "<C-w>h")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

-- 창 크기 조절
map("n", "<D-p>", "<C-w>2+")
map("n", "<D-n>", "<C-w>2-")
map("n", "<D-.>", "<C-w>2>")
map("n", "<D-,>", "<C-w>2<")
map("n", "<D-m>", "<C-w>=")

-- Tab 페이지
map("n", "te", vim.cmd.tabedit)
map("n", "tx", vim.cmd.tabclose)
map("n", "tn", vim.cmd.tabnext)
map("n", "tp", vim.cmd.tabprevious)


-- =====================================
-- 정보 표시 / LSP 관련
-- =====================================
map("n", "s", "")
map("n", "ss", ToggleNvDash, { desc = "NvDash screen", noremap = true, silent = true })
map("n", "sm", vim.cmd.message)
map("n", "sr", vim.cmd.reg)
map("n", "sd", vim.diagnostic.open_float)
map("n", "sk", vim.lsp.buf.hover)
map("n", "sl", vim.lsp.buf.signature_help)
map("n", "s<leader>", function() vim.cmd("WhichKey <leader>") end)


-- =====================================
-- Sidebar / Floating / Terminal
-- =====================================
map("n", "<leader>h", vim.cmd.NvimTreeToggle, { desc = "nvimtree" })
map("n", "<leader>H", vim.cmd.Outline, { desc = "outline" })
map({ "n", "t" }, "<leader><leader>", function() vim.cmd("ToggleTerm direction=float") end, { desc = "terminal(floating)" })
map({ "n", "t" }, "<leader>j", function() vim.cmd("ToggleTerm size=10 direction=horizontal") end, { desc = "terminal(bottom)" })
map("n", "<leader>k", vim.cmd.Navbuddy, { desc = "navbuddy" })
map("n", "<leader>t", vim.cmd.TagbarToggle, { desc = "tagbar" })
map("n", "<leader>l", function() require("custom.gemini").toggle() end, { desc = "Gemini CLI Toggle", noremap = true, silent = true })
map("n", "<leader>d", ToggleDiagnostics_qflist, { desc = "diagnostics list" })
map("n", "<leader>f", function() require('fzf-lua').files() end, { desc = "FZF file explorer" })
map("n", "<leader>g", function() require('fzf-lua').grep() end, { desc = "FZF grep explorer" })
map("n", "<leader><tab>", vim.cmd.JABSOpen, { desc = "show buffers" })


-- =====================================
-- 코드 관련
-- =====================================
map("n", "<leader>a", Compile, { desc = "compile" })
map("n", "tw", ToggleWrapCodes)
map("n", "tf", ToggleFoldColumn)
map("n", "z.", FoldColumnExpands, { noremap = true, silent = true })
map("n", "zmv", vim.cmd.mkview, { noremap = true, silent = true })
map("n", "zlv", vim.cmd.loadview, { noremap = true, silent = true })

-- Visual block 이동
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")


-- =====================================
-- AI / Auto complete
-- =====================================
map("n", "ta", ToggleAIAutoComplete)


-- =====================================
-- Git / 파일 관리
-- =====================================
map("n", "<leader>p", CommitAndPush, { desc = "Git commit and push" })
map("n", "<leader>v", ":vert diffsplit ", { desc = "diffsplit" })
map("n", "<leader>.", Sync_nvimtree_to_current_buffer, { desc = "Sync NvimTree to current buffer path" })


-- =====================================
-- 검색 / 정리
-- =====================================
map("n", "<leader><SPACE>", vim.cmd.noh, { desc = "clean search item" })
map("n", "<Leader>r", ReloadAndLSPRestart, { desc = "Reload file and restart LSP" })
