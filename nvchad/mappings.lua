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
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- Write, Quit
    ["<leader>q"] = { ":q<CR>", "quit" },
    ["<leader>w"] = { ":bd<CR>", "buffer delete" },

    -- ESC key
    ["<C-c>"] = { "<ESC>" },

    -- Quick integrated movement, page movement
    ["<C-k>"] = { "3k" },
    ["<C-j>"] = { "3j" },
    ["<C-l>"] = { "$" },
    ["<C-h>"] = { "^" },
    ["<C-n>"] = { "3<C-e>" },
    ["<C-p>"] = { "3<C-y>" },

    -- Sidebar
    ["<leader>h"] = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
    ["<leader>j"] = { "<cmd>TroubleToggle<CR>", "Trouble" },
    ["<leader>k"] = { "<cmd>Navbuddy<CR>", "Navbuddy" },
    ["<leader>l"] = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" },
    ["<leader>,"] = { "<cmd>ToggleTerm direction=float<CR>", "Terminal" },
    ["<leader><"] = {
      "<cmd>ToggleTerm size=10 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>a",
      "Terminal bottom",
    },
    ["<leader>."] = { "<cmd>NeoAIToggle<CR>", "NeoAI" },
    ["<leader><tab>"] = { "<cmd>ToggleBufExplorer<CR>", "ToggleBufExplorer" },

    -- Split window control (move, resize)
    ["<A-k>"] = { "<C-W>k<C-W>_" },
    ["<A-j>"] = { "<C-W>j<C-W>_" },
    ["<A-l>"] = { "<C-W>l<C-W>|" },
    ["<A-h>"] = { "<C-W>h<C-W>|" },
    ["<A-p>"] = { "<C-W>2+" },
    ["<A-n>"] = { "<C-W>2-" },
    ["<A-.>"] = { "<C-W>2>" },
    ["<A-,>"] = { "<C-W>2<" },
    ["<A-m>"] = { "<C-W>=" },

    -- Clean search (highlight remove)
    ["<leader><space>"] = { '<cmd>let @/=""<CR>', "No Highlight" },

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

    -- prettier
    ["<A-f>"] = { "<Plug>(Prettier)" },
    ["<leader>p"] = { "<Plug>(Prettier)", "Prettier" },
  },

  ---------------------------------------------------------------
  -- V-LINE Mode
  ---------------------------------------------------------------
  v = {
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
    -- Use terminal shortcuts in input mode
    ["<C-h>"] = { "<BACKSPACE>" },
    ["<C-f>"] = { "<RIGHT>" },
    ["<C-b>"] = { "<LEFT>" },
    ["<C-a>"] = { "<ESC>^i" },
    ["<C-e>"] = { "<ESC>$a" },
    ["<C-d>"] = { "<DEL>" },
    ["<C-u>"] = { "<ESC><RIGHT>d^i" },
    ["<C-k>"] = { "<ESC><RIGHT>C" },
    ["<C-CR>"] = { "<ESC>o" },
    ["<C-l>"] = { "<ESC>zza" },
    ["<C-i>"] = { "<ESC>ui" },
    ["<C-o>"] = { "<ESC><C-r>i" },
  },

  ---------------------------------------------------------------
  -- COMMAND Mode
  ---------------------------------------------------------------
  c = {},

  ---------------------------------------------------------------
  -- TERMINAL Mode
  ---------------------------------------------------------------
  t = {
    ["<ESC>"] = { "<C-\\><C-n>" },
    ["<leader>,"] = { "<cmd>:ToggleTerm<CR>" },
    ["<leader>j"] = { "<cmd>:ToggleTerm<CR>" },
  },
}

-- more keybinds!

return M
