require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Modify existing keymap
vim.api.nvim_del_keymap("n", "<leader>e")  -- for nvimtree
vim.api.nvim_del_keymap("n", "<leader>ds")  -- for diagnostics list
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true })  -- for Codeium(Disable Autocomplete)
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>", { noremap = true, silent = true })  -- Separate <Tab>and <C-i>

-- ESC
map({"n", "v", "i"}, "<C-c>", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>")

-- Quit
map("n", "<C-q>", "<cmd>q<CR>")
map("n", "<leader>q", "<cmd>q<CR>", { desc = "quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "quit with save" })

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

-- Split window movement
map("n", "<D-k>", "<C-w>k")
map("n", "<D-j>", "<C-w>j")
map("n", "<D-l>", "<C-w>l")
map("n", "<D-h>", "<C-w>h")

-- Split Window resizing
map("n", "<D-p>", "<C-w>2+")
map("n", "<D-n>", "<C-w>2-")
map("n", "<D-.>", "<C-w>2>")
map("n", "<D-,>", "<C-w>2<")
map("n", "<D-m>", "<C-w>=" )
map("n", "<D-S-c>", "<C-w>c" )

-- Tab page
map("n", "te", "<cmd>tabedit<CR>")
map("n", "tx", "<cmd>tabclose<CR>")
map("n", "tn", "<cmd>tabnext<CR>")
map("n", "tp", "<cmd>tabprevious<CR>")

-- Sidebar functions
map("n", "<leader>h", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree" })
map("n", "<leader>j", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "terminal(bottom)" })
map("n", "<leader>l", "<cmd>SymbolsOutline<CR>", { desc = "symbols outline" })
map("n", "<leader>L", "<cmd>TagbarToggle<CR>", { desc = "tagbar" })

-- Floating window functions
map("n", "<leader>k", "<cmd>Navbuddy<CR>", { desc = "navbuddy" })
map("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { desc="FZF file explorer" })
map("n", "<leader><leader>", "<cmd>ToggleTerm direction=float<CR>", { desc = "terminal(floating)" })
map("n", "<leader><tab>", "<cmd>JABSOpen<CR>", { desc = "show buffers" })

-- Show informations
map("n", "s", "")
map("n", "ss", "<cmd>Nvdash<CR>") -- Nvdash
map("n", "sm", "<cmd>message<CR>") -- Message
map("n", "sr", "<cmd>reg<CR>") -- Register
map("n", "sd", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Diagnostic
map("n", "sk", "<cmd>lua vim.lsp.buf.hover()<CR>") -- Keyword manpage
map("n", "sl", "<cmd>lua vim.lsp.buf.signature_help()<CR>") -- Lsp signature help 
map("n", "<leader>d", "<cmd>lua ToggleDiagnostics_qflist()<CR>" , { desc = "diagnostics list" })
map("n", "s<leader>", "<cmd>WhichKey <leader><CR>") -- leader key info

-- Toggle functions
map("n", "tw", "<cmd>lua ToggleWrapCodes()<CR>")  -- Wrap
map("n", "tf", "<cmd>lua ToggleFoldColumn()<CR>") -- Foldcolumn
map("n", "tc", "<cmd>lua ToggleCodeium()<CR>")  -- Codeium

-- Using Terminal keymap on <Insert> mode
map("i", "<C-h>", "<BACKSPACE>")
map("i", "<C-f>", "<RIGHT>")
map("i", "<C-b>", "<LEFT>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<ESC>$a")
map("i", "<C-d>", "<DEL>")
map("i", "<C-u>", "<ESC>d^xi")
map("i", "<C-k>", "<ESC><Right>C")
map("i", "<C-CR>", "<ESC>o")

-- <Terminal> mode key mappings
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<leader><leader>", "<cmd>ToggleTerm<CR>")
map("t", "<leader>j", "<cmd>ToggleTerm<CR>")

-- Move visual block (Up, Down, Indent, Outdent)
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Compile
map("n", "<leader>a", "<cmd>lua Compile()<CR>", { desc = "compile" })

-- Git push
map("n", "<leader>g", "<cmd>lua Commit_and_push()<CR>", { desc = "Git commit and push" })


-- Clean search item (highlight remove)
map("n", "<leader><SPACE>", "<cmd>noh<CR>", { desc = "clean search item" })

-- Vert Diffsplit
map("n", "<leader>v", ":vert diffsplit ", { desc = "diffsplit" })

-- Set the current path as the working path
map("n", "<leader>~", "<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>", { desc = "change the current path" })
