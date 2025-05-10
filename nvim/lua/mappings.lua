require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Modify existing keymap
vim.api.nvim_del_keymap("n", "<leader>e") -- for nvimtree
vim.api.nvim_del_keymap("n", "<leader>ds") -- for diagnostics list
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true }) -- for Codeium(Disable Autocomplete)
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>", { noremap = true, silent = true }) -- Separate <Tab>and <C-i>

-- <ESC> & Quit
map({ "n", "i", "v", "c" }, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<C-q>", "<cmd>q<CR>")
map("n", "<leader>q", "<cmd>q<CR>", { desc = "quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "quit with save" })

-- Using Terminal keymap on <Insert> mode
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-j>", "<ENTER>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><RIGHT>C")

-- Additional key on <Insert> mode
map("i", "<C-f>", "<C-RIGHT>")
map("i", "<C-v>", "<C-LEFT>")
map("i", "<C-CR>", "<ESC>o")
map("i", "<C-s>", "<ESC><C-s>")

-- Cursor movement
map({ "n", "v" }, "<C-k>", "3k")
map({ "n", "v" }, "<C-j>", "3j")
map({ "n", "v" }, "<C-l>", "$")
map({ "n", "v" }, "<C-h>", "^")

-- Screen movement
map({ "n", "v" }, "<C-n>", "3<C-e>")
map({ "n", "v" }, "<C-p>", "3<C-y>")
map({ "n", "v" }, "<C-f>", "<C-d>")
map({ "n", "v" }, "<C-d>", "<C-u>")
map({ "n", "v" }, "<C-S-l>", "6zl")
map({ "n", "v" }, "<C-S-h>", "6zh")

-- Split window movement
map("n", "<D-k>", "<C-w>k")
map("n", "<D-j>", "<C-w>j")
map("n", "<D-l>", "<C-w>l")
map("n", "<D-h>", "<C-w>h")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")

-- Split window resizing
map("n", "<D-p>", "<C-w>2+")
map("n", "<D-n>", "<C-w>2-")
map("n", "<D-.>", "<C-w>2>")
map("n", "<D-,>", "<C-w>2<")
map("n", "<D-m>", "<C-w>=")

-- Tab page
map("n", "te", "<cmd>tabedit<CR>")
map("n", "tx", "<cmd>tabclose<CR>")
map("n", "tn", "<cmd>tabnext<CR>")
map("n", "tp", "<cmd>tabprevious<CR>")

-- information displayed functions
map("n", "s", "")
map("n", "ss", "<cmd>Nvdash<CR>") -- Nvdash
map("n", "sm", "<cmd>message<CR>") -- Message
map("n", "sr", "<cmd>reg<CR>") -- Register
map("n", "sd", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Diagnostic
map("n", "sk", "<cmd>lua vim.lsp.buf.hover()<CR>") -- Keyword manpage
map("n", "sl", "<cmd>lua vim.lsp.buf.signature_help()<CR>") -- Lsp signature help
map("n", "s<leader>", "<cmd>WhichKey <leader><CR>") -- leader key info

-- Sidebars funtions
map({ "n", "t" }, "<leader>j", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "terminal(bottom)" })
map("n", "<leader>h", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree" })
map("n", "<leader>d", "<cmd>lua ToggleDiagnostics_qflist()<CR>", { desc = "diagnostics list" })
map("n", "<leader>l", "<cmd>SymbolsOutline<CR>", { desc = "symbols outline" })
map("n", "<leader>L", "<cmd>TagbarToggle<CR>", { desc = "tagbar" })

-- Floating windows functions
map({ "n", "t" }, "<leader><leader>", "<cmd>ToggleTerm direction=float<CR>", { desc = "terminal(floating)" })
map("n", "<leader>k", "<cmd>Navbuddy<CR>", { desc = "navbuddy" })
map("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "FZF file explorer" })
map("n", "<leader>g", "<cmd>lua require('fzf-lua').grep()<CR>", { desc = "FZF grep explorer" })
map("n", "<leader><tab>", "<cmd>JABSOpen<CR>", { desc = "show buffers" })

-- Folding
map("n", "tf", "<cmd>lua ToggleFoldColumn()<CR>")
map("n", "z.", "<cmd>lua FoldColumnExpands()<CR>", { noremap = true, silent = true })
map("n", "zvm", "<cmd>mkview<CR>", { noremap = true, silent = true })
map("n", "zvl", "<cmd>loadview<CR>", { noremap = true, silent = true })

-- Move visual block (Up, Down, Indent, Outdent)
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- AI Auto complete
map("n", "ta", "<cmd>lua ToggleAIAutoComplete()<CR>")

-- Codeium(windserf) keymap
map("i", "<Tab>", "codeium#Accept()", { expr = true, silent = true, nowait = true, desc = "Accept Codeium suggestion" })
map("i", "<C-;>", "codeium#AcceptNextLine()", { expr = true, silent = true, nowait = true, desc = "Accept next line from Codeium", })
map("i", "<C-'>", "codeium#AcceptNextWord()", { expr = true, silent = true, nowait = true, desc = "Accept next word from Codeium", })
map("i", "<C-.>", "<Cmd>call codeium#CycleCompletions(1)<CR>", { silent = true, desc = "Cycle Codeium completions forward", })
map("i", "<C-,>", "<Cmd>call codeium#CycleCompletions(-1)<CR>", { silent = true, desc = "Cycle Codeium completions backward", })
map("i", "<C-x>", "<Cmd>call codeium#Clear()<CR>", { silent = true, desc = "Clear Codeium suggestion", })

-- Compile
map("n", "<leader>a", "<cmd>lua Compile()<CR>", { desc = "compile" })

-- Wrap codes
map("n", "tw", "<cmd>lua ToggleWrapCodes()<CR>")

-- Git push
map("n", "<leader>p", "<cmd>lua Commit_and_push()<CR>", { desc = "Git commit and push" })

-- Clean search item (highlight remove)
map("n", "<leader><SPACE>", "<cmd>noh<CR>", { desc = "clean search item" })

-- Vert Diffsplit
map("n", "<leader>v", ":vert diffsplit ", { desc = "diffsplit" })

-- Set the current path as the working path
map("n", "<leader>~", "<cmd>:lcd %:p:h<CR>:echo expand('%:p:h')<CR>", { desc = "change the current path" })
