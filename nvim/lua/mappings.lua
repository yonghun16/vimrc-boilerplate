require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- ESC
map({"n", "v", "i"}, "<C-C>", "<ESC>")

-- Quit
map("n", "<C-q>", "<cmd>q<CR>")
map("n", "<leader>q", "<cmd>q<CR>", {desc = "Quit"})
map("n", "<leader>Q", "<cmd>q!<CR>", {desc = "Quit with save"})

-- Cursor movement
map({"n", "v"}, "<C-k>", "3k")
map({"n", "v"}, "<C-j>", "3j")
map({"n", "v"}, "<C-l>", "$")
map({"n", "v"}, "<C-h>", "^")
map({"n", "v"}, "<C-s-k>", "10k")
map({"n", "v"}, "<C-s-j>", "10j")

-- Screen movement
map({"n", "v"}, "<C-n>", "3<C-e>")
map({"n", "v"}, "<C-p>", "3<C-y>")
map({"n", "v"}, "<C-f>", "<C-d>")
map({"n", "v"}, "<C-d>", "<C-u>")

-- Window movement
map("n", "<D-k>", "<C-w>k")
map("n", "<D-j>", "<C-w>j")
map("n", "<D-l>", "<C-w>l")
map("n", "<D-h>", "<C-w>h")

-- Window resize
map("n", "<D-p>", "<C-w>2+")
map("n", "<D-n>", "<C-w>2-")
map("n", "<D-.>", "<C-w>2>")
map("n", "<D-,>", "<C-w>2<")
map("n", "<D-m>", "<C-w>=" )
map("n", "<D-S-c>", "<C-w>c" )

-- Sidebar
map("n", "<leader>h", "<cmd>NvimTreeToggle<CR>", {desc = "Nvimtree"})
map("n", "<leader>j", "<cmd>ToggleTerm size=15 direction=horizontal <CR>", {desc = "Terminal bottom"})
map("n", "<leader>k", "<cmd>Navbuddy<CR>", {desc = "Navbuddy"})
map("n", "<leader>l", "<cmd>SymbolsOutline<CR>", {desc = "Symbols Outline"})
map("n", "<leader>L", "<cmd>TagbarToggle<CR>", {desc = "Tagbar"})
map("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", {silent = true, desc="FZF file explorer"})
map("n", "<leader>,", "<cmd>ToggleTerm direction=float<CR>", {desc = "Terminal floating"})
map("n", "<leader><tab>", "<cmd>JABSOpen<CR>", {desc = "Buffers"})
map("n", "<leader><ESC>", "<cmd>Nvdash<CR>", {desc = "Nvdash"})

-- Terminal keymap using on <INSERT> Mode
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-f>", "<RIGHT>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><Right>C")
map("i", "<C-CR>", "<ESC>o")

-- <TERMINAL> Mode keymap
map("t", "<leader>,", "<cmd>ToggleTerm<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

-- Tab
map("n", "te", "<cmd>tabedit<CR>")
map("n", "tx", "<cmd>tabclose<CR>")
map("n", "tn", "<cmd>tabnext<CR>")
map("n", "tp", "<cmd>tabprevious<CR>")

-- Move Visual block (Up, Down, Indent, Outdent)
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Compile
map("n", "<leader>a", "<cmd>lua Compile()<CR>", {desc = "Compile"})

-- Toggle (Wrap, Foldcolumn, Codeium)
map("n", "tw", "<cmd>lua ToggleWrapCodes()<CR>")
map("n", "tf", "<cmd>lua ToggleFoldColumn()<CR>")
map("n", "tc", "<cmd>lua ToggleCodeium()<CR>")

-- Message (Message, Diagnostic, Keyword Manpage)
map("n", "mm", "<cmd>message<CR>")
map("n", "md", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "mk", "<cmd>lua vim.lsp.buf.hover()<CR>")

-- Highlight clear
map("n", "<leader><SPACE>", "<cmd>noh<CR>", {desc = "Highlight clear"})

-- Diffsplit
map("n", "<leader>d", ":vert diffsplit ", {desc = "Diffsplit"})

-- Git push
map("n", "<leader>g", "<cmd>w<CR><cmd>!git add * && git commit -m 'update' && git push<CR>", {desc = "git commit & push"})
