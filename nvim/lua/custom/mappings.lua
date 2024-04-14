---@type MappingsTable
local M = {}

-----------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------
--
-- 1. [ ~/.config/nvim/lua/core/mappings.lua ]
--    1) Comment out'<leader>ls', <leader>lf.
--    2) Replace <leader>ma to <leader>ta
--    3) Replace <leader>w to <leader>e
--
-- 2. [ ~/.config/nvim/lua/plugins/configs/cmp.lua ]
--    1) Comment out'<Tab>' and <S-Tab>  (to use <Tab> in codeium)
--
-----------------------------------------------------------------


M.general = {
  ---------------------------------------------------------------
  -- NORMAL Mode
  ---------------------------------------------------------------
  n = {
    -- <ESC> key
    ["<C-f>"] = { "<ESC>" },
    ["<C-c>"] = { "<ESC>" },

    -- Quit
    ["<leader>q"] = { ":q<CR>", "Quit" },
    ["<leader>Q"] = { ":q!<CR>", "Quit without save" },

    -- cursor movement
    ["<C-k>"] = { "3k" },
    ["<C-j>"] = { "3j" },
    ["<C-s-k>"] = { "10k" },
    ["<C-s-j>"] = { "10j" },
    ["<C-l>"] = { "$" },
    ["<C-h>"] = { "^" },
    -- page movement
    ["<C-n>"] = { "3<C-e>" },
    ["<C-p>"] = { "3<C-y>" },

    -- Split window
    ["ss"] = { "<cmd>split<CR>" },
    ["sv"] = { "<cmd>vsplit<CR>" },
    -- Move window
    ["sh"] = { "<C-w>h" },
    ["sk"] = { "<C-w>k" },
    ["sj"] = { "<C-w>j" },
    ["sl"] = { "<C-w>l" },
    -- Resize window
    ["<A-p>"] = { "<C-W>2+" },
    ["<A-n>"] = { "<C-W>2-" },
    ["<A-.>"] = { "<C-W>2>" },
    ["<A-,>"] = { "<C-W>2<" },
    ["<A-m>"] = { "<C-W>=" },
    ["<A-k>"] = { "<C-W>k<C-W>_" },
    ["<A-j>"] = { "<C-W>j<C-W>_" },
    ["<A-l>"] = { "<C-W>l<C-W>|" },
    ["<A-h>"] = { "<C-W>h<C-W>|" },

    -- Tab
    ["te"] = { ":tabedit " },
    ["tx"] = { "<cmd>tabclose<CR>" },
    ["tn"] = { "<cmd>tabnext<CR>" },
    ["tp"] = { "<cmd>tabprevious<CR>" },
    ["<A-t>"] = { "<cmd>tabnew<CR>" },
    ["<A-w>"] = { "<cmd>tabclose<CR>" },
    ["<C-q>"] = { "<cmd>tabnext<CR>" },
    ["<C-S-q>"] = { "<cmd>tabprevious<CR>" },

    -- Sidebar
    ["<leader>h"] = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
    ["<leader>j"] = { "<cmd>TroubleToggle<CR>", "Trouble" },
    ["<leader>k"] = { "<cmd>Navbuddy<CR>", "Navbuddy" },
    ["<leader>l"] = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" },
    ["<leader>L"] = { "<cmd>TagbarToggle<CR>", "Tagbar" },
    ["<leader>,"] = { "<cmd>ToggleTerm direction=float<CR>", "Terminal" },
    ["<leader><"] = {
      "<cmd>ToggleTerm size=10 direction=horizontal <CR>",
      "Terminal bottom",
    },
    ["<leader>."] = { "<cmd>NeoAIToggle<CR>", "NeoAI" },
    ["<leader><tab>"] = { "<cmd>JABSOpen<CR>", "Buffer Switcher" },
    ["<leader><ESC>"] = { "<cmd>Nvdash<CR>", "Nvdash" },

    -- Goto Preview (plugin)
    ["<leader>pd"] = { ":lua require('goto-preview').goto_preview_definition()<CR>" },
    ["<leader>pt"] = { ":lua require('goto-preview').goto_preview_type_definition()<CR>" },
    ["<leader>pi"] = { ":lua require('goto-preview').goto_preview_implementation()<CR>" },
    ["<leader>pD"] = { ":lua require('goto-preview').goto_preview_declaration()<CR>" },
    ["<leader>P"] = { ":lua require('goto-preview').close_all_win()<CR>" },
    ["<leader>pr"] = { ":lua require('goto-preview').goto_preview_references()<CR>" },
    -- Barbecue (plugins)
    ["<leader>b"] = { "<cmd>Barbecue toggle<CR>", "Barbecue toggle" },

    -- highlight clear
    ["<leader><SPACE>"] = { '<cmd>let @/=""<CR>', "Highlight clear" },

    -- Message
    ["<leader>m"] = { "<cmd>:messages<CR>", "Messages" },

    -- Compile
    ["<leader>a"] = { "<cmd>lua Compile()<CR>", "Compile" },

    -- Auto wrap
    ["<leader>z"] = { "<cmd>lua Toggle_wrap()<CR>", "Wrap" },

    -- Diffsplit
    ["<leader>d"] = { ":vert diffsplit ", "diffsplit" },

    -- Register
    ["<leader>r"] = { "<cmd>:reg<cr>", "Register" },

    -- Set the current path as the working path
    ["<leader>~"] = { "<cmd>:lcd %:p:h<CR>:echo expand('%:p:h')<CR>", "change workspace" },
  },

  ---------------------------------------------------------------
  -- V-LINE Mode
  ---------------------------------------------------------------
  v = {
    -- <ESC> key
    ["<C-f>"] = { "<ESC>" },

    -- cursor movement
    ["<C-k>"] = { "3k" },
    ["<C-j>"] = { "3j" },
    ["<C-s-k>"] = { "10k" },
    ["<C-s-j>"] = { "10j" },
    ["<C-l>"] = { "$" },
    ["<C-h>"] = { "^" },
    -- page movement
    ["<C-n>"] = { "3<C-e>" },
    ["<C-p>"] = { "3<C-y>" },

    -- Move selected row up or down
    ["<S-k>"] = { ":m '<-2<CR>gv=gv" },
    ["<S-j>"] = { ":m '>+1<CR>gv=gv" },
  },

  ---------------------------------------------------------------
  -- INSERT Mode
  ---------------------------------------------------------------
  i = {
    -- <ESC> key
    ["<C-f>"] = { "<ESC>" },

    -- Use terminal shortcuts in input mode
    ["<C-h>"] = { "<BACKSPACE>" },
    ["<C-l>"] = { "<RIGHT>" },
    ["<C-b>"] = { "<LEFT>" },
    ["<C-a>"] = { "<ESC>^i" },
    ["<C-e>"] = { "<ESC>$a" },
    ["<C-d>"] = { "<DEL>" },
    ["<C-u>"] = { "<ESC><RIGHT>d^i" },
    ["<C-k>"] = { "<ESC><RIGHT>C" },
    ["<C-CR>"] = { "<ESC>o" },
    ["<C-i>"] = { "<ESC>ui" },     -- undo
    ["<C-o>"] = { "<ESC><C-r>i" }, -- redo
  },

  ---------------------------------------------------------------
  -- COMMAND Mode
  ---------------------------------------------------------------
  c = {
    -- <ESC> key
    ["<C-f>"] = { "<ESC>" },
  },

  ---------------------------------------------------------------
  -- TERMINAL Mode
  ---------------------------------------------------------------
  t = {
    ["<ESC>"] = { "<C-\\><C-n>" },
    ["<C-l>"] = { "<RIGHT>" },
    ["<leader>,"] = { "<cmd>:ToggleTerm<CR>" },
    ["<c-w>h"] = { "<C-\\><C-n><C-w>h" },
    ["<c-w>j"] = { "<C-\\><C-n><C-w>j" },
    ["<c-w>k"] = { "<C-\\><C-n><C-w>k" },
    ["<c-w>l"] = { "<C-\\><C-n><C-w>l" },
  },
}

return M
