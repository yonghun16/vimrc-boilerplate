---@type MappingsTable
local M = {}


-----------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------
-- 1. Comment out'<leader>ls', <leader>lf.
-- 2. Replace <leader>w -> <leader>e
--    ( Modified from "~/.config/nvim/lua/core/mappings.lua" )
-- 3. Comment out'<Tab>' and <S-Tab>  (to use <Tab> in codeium)
--    ( Modified from "~/.config/nvim/lua/plugins/configs/cmp.lua" )
-----------------------------------------------------------------

M.general = {
  ---------------------------------------------------------------
  -- NORMAL Mode
  ---------------------------------------------------------------
  n = {
    -- ESC key
    ["<C-f>"] = { "<ESC>" },
    ["<C-c>"] = { "<ESC>" },

    -- Write, Quit
    ["<leader>w"] = { ":w<CR>", ":w" },
    ["<leader>q"] = { ":q<CR>", ":q" },
    ["<leader>Q"] = { ":q!<CR>", ":q!" },

    -- Quick integrated movement, page movement
    ["<C-k>"] = { "3k" },
    ["<C-j>"] = { "3j" },
    ["<C-l>"] = { "$" },
    ["<C-h>"] = { "^" },
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
    ["<A-t>"] = { "<cmd>tabnew<CR>" },
    ["<A-w>"] = { "<cmd>tabclose<CR>" },
    ["<C-q>"] = { "<cmd>tabnext<CR>" },
    ["<C-Q>"] = { "<cmd>tabprevious<CR>" },
    ["te"] = { ":tabedit " },
    ["tc"] = { "<cmd>tabclose<CR>" },
    ["tn"] = { "<cmd>tabnext<CR>" },
    ["tp"] = { "<cmd>tabprevious<CR>" },

    -- Compile
    ["<leader>a"] = { "<cmd>lua Compile()<CR>", "Compile" },

    -- Auto wrap
    ["<leader>z"] = { "<cmd>lua Toggle_wrap()<CR>", "Wrap" },

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
    ["<leader><tab>"] = { "<cmd>ToggleBufExplorer<CR>", "BufExplorer" },
    ["<leader><ESC>"] = { "<cmd>Nvdash<CR>", "Nvdash" },

    -- Goto Preview (plugin)
    ["<leader>pd"] = { ":lua require('goto-preview').goto_preview_definition()<CR>" },
    ["<leader>pt"] = { ":lua require('goto-preview').goto_preview_type_definition()<CR>" },
    ["<leader>pi"] = { ":lua require('goto-preview').goto_preview_implementation()<CR>" },
    ["<leader>pD"] = { ":lua require('goto-preview').goto_preview_declaration()<CR>" },
    ["<leader>P"] = { ":lua require('goto-preview').close_all_win()<CR>"},
    ["<leader>pr"] = { ":lua require('goto-preview').goto_preview_references()<CR>" },

    -- noice and Babecue (plugin)
    ["<leader>mh"] = { "<cmd>Noice history<CR>", "Noice history" },
    ["<leader>ml"] = { "<cmd>Noice last<CR>", "Noice last" },
    ["<C-m>"] = { "<cmd>Noice dismiss<CR>", "Noice dismiss" },
    ["<leader>mr"] = { "<cmd>Noice reset<CR>", "Noice reset" },
    ["<leader>me"] = { "<cmd>Noice enable<CR>", "Noice enable" },
    ["<leader>md"] = { "<cmd>Noice disable<CR>", "Noice disable" },
    ["<leader>mb"] = { "<cmd><CR>", "Babecue toggle" },

    -- Clean search
    ["<leader><space>"] = { '<cmd>let @/=""<CR>', "No Highlight" },

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
    -- ESC key
    ["<C-f>"] = { "<ESC>" },

    -- Quick integrated movement, page movement
    ["<C-k>"] = { "3k" },
    ["<C-j>"] = { "3j" },
    ["<C-l>"] = { "$" },
    ["<C-h>"] = { "^" },
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
    -- ESC key
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
    ["<C-i>"] = { "<ESC>ui" },
    ["<C-o>"] = { "<ESC><C-r>i" },
  },

  ---------------------------------------------------------------
  -- COMMAND Mode
  ---------------------------------------------------------------
  c = {
    -- ESC key
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

-- more keybinds!

return M
