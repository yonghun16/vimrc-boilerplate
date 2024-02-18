---@type MappingsTable
local M = {}

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
--  1. Comment out'<leader>ls' and <leader>lf
--     Modified from "~/.config/nvim/lua/core/mappings.lua"
--  2. Comment out'<Tab>' and <S-Tab>  (to use <Tab> in codeium)
--     Modified from "~/.config/nvim/lua/plugins/configs/cmp.lua"
--------------------------------------------------------------------------------

M.general = {
  -- -------------------------------------------------------------
  -- NORMAL Mode
  -- -------------------------------------------------------------
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
    ["<leader>w"] = { ":w<CR>", "write" },
    ["<leader>wq"] = { ":wq<CR>", "write" },

    -- ESC key
    ["<C-f>"] = { "<ESC>"},

    -- Quick integrated movement, page movement
    ["<C-k>"] = {"3k"},
    ["<C-j>"] = {"3j"},
    ["<C-l>"] = {"$"},
    ["<C-h>"] = {"^"},
    ["<C-n>"] = {"3<C-e>"},
    ["<C-p>"] = {"3<C-y>"},

    -- Sidebar
    ["<leader>,"] = { "<cmd>:ToggleTerm direction=float<CR>", "Terminal" },
    ["<leader>l"] = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
    -- ["<leader>k"] = { "<cmd>: Barbecue toggle<CR>", "context nav" },
    ["<leader><tab>"] = { "<cmd>Telescope buffers previewer=false<cr>", "Buffer list" },
    ["<leader>h"] = { "<cmd>:TagbarToggle<CR>", "Tagbar" },
    ["<leader>j"] = { "<cmd>:ToggleTerm size=10 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>a", "Terminal bottom" },

    -- Split window control (move, resize)
    ["<D-k>"] = {"<C-W>k<C-W>_"},
    ["<D-j>"] = {"<C-W>j<C-W>_"},
    ["<D-l>"] = {"<C-W>l<C-W>|"},
    ["<D-h>"] = {"<C-W>h<C-W>|"},
    ["<D-p>"] = {"<C-W>2+"},
    ["<D-n>"] = {"<C-W>2-"},
    ["<D-.>"] = {"<C-W>2>"},
    ["<D-,>"] = {"<C-W>2<"},
    ["<D-m>"] = {"<C-W>="},

    ["<A-k>"] = {"<C-W>k<C-W>_"},
    ["<A-j>"] = {"<C-W>j<C-W>_"},
    ["<A-l>"] = {"<C-W>l<C-W>|"},
    ["<A-h>"] = {"<C-W>h<C-W>|"},
    ["<A-p>"] = {"<C-W>2+"},
    ["<A-n>"] = {"<C-W>2-"},
    ["<A-.>"] = {"<C-W>2>"},
    ["<A-,>"] = {"<C-W>2<"},
    ["<A-m>"] = {"<C-W>="},

    -- Clean search (highlight remove)
    ["<leader><space>"] = { '<cmd>let @/=""<CR>', "No Highlight" },

    -- Compile
    ["<leader>a"] = { "<cmd>lua Compile()<CR>", "Compile" },

    -- Auto wrap
    ["<leader>z"] = { '<cmd>lua Toggle_wrap()<CR>', "Wrap" },

    -- Diffsplit
    ["<leader>d"] = { ':vert diffsplit ', "diffsplit" },

    -- Register
    ["<leader>r"] = { '<cmd>:reg<cr>', "Register" },

    -- Set the current path as the working path
    ["<leader>~"] = { '<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>', "change workspace" },

    -- prettier
    ["<A-f>"] = {"<Plug>(Prettier)"},
    ["<leader>p"] = { '<Plug>(Prettier)', "Prettier" },

    -- Easymotion
    ["<leader>f"] = { '<Plug>(easymotion-f)', "easymotion-f" },
    ["<leader>F"] = { '<Plug>(easymotion-F)', "easymotion-F" },
  },

  -- -------------------------------------------------------------
  -- V-LINE Mode
  -- -------------------------------------------------------------
  v = {
    -- ESC key
    ["<C-f>"] = { "<ESC>"},

    -- Quick integrated movement, page movement
    ["<C-k>"] = {"3k"},
    ["<C-j>"] = {"3j"},
    ["<C-l>"] = {"$"},
    ["<C-h>"] = {"^"},
    ["<C-n>"] = {"3<C-e>"},
    ["<C-p>"] = {"3<C-y>"},

    -- Move selected row up or down
    ["<S-k>"] = {":m '<-2<CR>gv=gv"},
    ["<S-j>"] = {":m '>+1<CR>gv=gv"}

  },

  -- -------------------------------------------------------------
  -- INSERT Mode
  -- -------------------------------------------------------------
  i = {
    -- ESC key
    ["<C-f>"] = { "<ESC>"},

    -- Use terminal shortcuts in input mode
    ["<C-h>"]  = {"<BACKSPACE>"},
    ["<C-l>"]  = {"<RIGHT>"},
    ["<C-b>"]  = {"<LEFT>"},
    ["<C-a>"]  = {"<ESC>^i"},
    ["<C-e>"]  = {"<ESC>$a"},
    ["<C-d>"]  = {"<DEL>"},
    ["<C-u>"]  = {"<ESC><RIGHT>d^i"},
    ["<C-k>"]  = {"<ESC><RIGHT>C"},
    ["<C-CR>"] = {"<ESC>o"},
    ["<C-i>"]  = {"<ESC>ui"},
    ["<C-o>"]  = {"<ESC><C-r>i"},
  },

  -- -------------------------------------------------------------
  -- COMMAND Mode
  -- -------------------------------------------------------------
  c = {
    -- ESC key
    ["<C-f>"] = { "<ESC>"},
  },

  -- -------------------------------------------------------------
  -- TERMINAL Mode
  -- -------------------------------------------------------------
  t = {
    ["<ESC>"]     = {"<C-\\><C-n>"},
    ["<leader>,"] = {"<cmd>:ToggleTerm<CR>"},
    ["<leader>j"] = {"<cmd>:ToggleTerm<CR>"},
  }
}

-- more keybinds!

return M
