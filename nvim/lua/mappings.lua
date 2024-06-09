require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

---------------------------------------------------------------
-- NORMAL Mode
---------------------------------------------------------------
-- ESC
map({"n", "v", "c"}, "<C-f>", "<ESC>")

-- Quit, Quit without save
map("n", "<leader>q", ":q<CR>", {desc = "Quit"})
map("n", "<leader>Q", ":q!<CR>", {desc = "Quit with save"})

-- cursor movement
map("n", "<C-k>", "3k")
map("n", "<C-j>", "3j")
map("n", "<C-s-k>", "10k")
map("n", "<C-s-j>", "10j")
map("n", "<C-l>", "$")
map("n", "<C-h>", "^")
-- page movement
map("n", "<C-n>", "3<C-e>")
map("n", "<C-p>", "3<C-y>")

-- Split window
map("n", "ss", "<cmd>split<CR>")
map("n", "sv", "<cmd>vsplit<CR>")

-- Resize window
map("n", "<A-k>", "<C-w>2+")
map("n", "<A-j>", "<C-w>2-")
map("n", "<A-l>", "<C-w>2>")
map("n", "<A-h>", "<C-w>2<")
map("n", "<A-m>", "<C-w>=" )

-- Tab
map("n", "te", ":tabedit ")
map("n", "tx", "<cmd>tabclose<CR>")
map("n", "tn", "<cmd>tabnext<CR>")
map("n", "tp", "<cmd>tabprevious<CR>")

-- Sidebar
map("n", "<leader>h", "<cmd>NvimTreeToggle<CR>", {desc = "Nvim Tree"})
map("n", "<leader>j", "<cmd>ToggleTerm size=15 direction=horizontal <CR>", {desc = "Terminal bottom"})
map("n", "<leader>k", "<cmd>Navbuddy<CR>")
map("n", "<leader>l", "<cmd>SymbolsOutline<CR>", {desc = "Symbols Outline"})
map("n", "<leader>L", "<cmd>TagbarToggle<CR>", {desc = "Tagbar"})
map("n", "<leader>,", "<cmd>ToggleTerm direction=float<CR>", {desc = "Terminal floating"})
map("n", "<leader><tab>", "<cmd>JABSOpen<CR>", {desc = "Buffers"})
map("n", "<leader><ESC>", "<cmd>Nvdash<CR>")

-- Compile
map("n", "<leader>a", "<cmd>lua Compile()<CR>")

-- highlight clear
map("n", "<leader><SPACE>", '<cmd>let @/=""<CR>', {desc = "Highlight clear"})

-- Message
map("n", "<leader>m", "<cmd>:messages<CR>", {desc = "Messages"})

-- Compile
map("n", "<leader>a", "<cmd>lua Compile()<CR>", {desc = "Compile"})

-- Auto wrap
map("n", "<leader>z", "<cmd>lua Toggle_wrap()<CR>", {desc = "Wrap"})

-- Diffsplit
map("n", "<leader>d", ":vert diffsplit ", {desc = "diffsplit"})

-- Register
map("n", "<leader>r", "<cmd>:reg<cr>", {desc = "Register"})

---------------------------------------------------------------
-- INSERT Mode
---------------------------------------------------------------
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-f>", "<RIGHT>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><Right>C")
map("i", "<C-CR>", "<ESC>o")


---------------------------------------------------------------
-- V-LINE Mode
---------------------------------------------------------------
-- cursor movement
map("v", "<C-k>", "3k")
map("v", "<C-j>", "3j")
map("v", "<C-s-k>", "10k")
map("v", "<C-s-j>", "10j")
map("v", "<C-l>", "$")
map("v", "<C-h>", "^")
-- page movement
map("v", "<C-n>", "3<C-e>")
map("v", "<C-p>", "3<C-y>")

-- 위로 이동 아래로 이동
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- 들여쓰기, 내어쓰기
map("v", ">", ">gv")
map("v", "<", "<gv")


---------------------------------------------------------------
-- TERMINAL Mode
---------------------------------------------------------------
map("t", "<leader>,", "<cmd>:ToggleTerm<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

