--==============================================================================
--
--  File name   : config.lua for Lunarvim
--  Version     : 1.2.4
--  Last update : 2024. 2. 17
--  Maker       : yonghun16 (https://github.com/yonghun16/vimrc-boilerplate)
--
--==============================================================================


--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
lvim.plugins = {
  -- VimScript Plugins
  {
    "preservim/tagbar", -- https://github.com/universal-ctags/ctags
    "easymotion/vim-easymotion",
    "farmergreg/vim-lastplace",
    "mg979/vim-visual-multi",
    "digitaltoad/vim-pug",
    "mattn/emmet-vim",
    "tpope/vim-surround",
    "prettier/vim-prettier",   -- $npm install -g prettier)
    "sbdchd/neoformat",        -- for prettier
    "Exafunction/codeium.vim", -- :Codeium Auth
  },

  -- Lua Plugins
  { "Mofiqul/vscode.nvim" },
  { "NvChad/nvim-colorizer.lua" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { 'MunifTanjim/nui.nvim' },
  { 'Bryley/neoai.nvim' }
  -- {  -- codeium nvim 버전 작동 안됨... 이유는 아직 모르겠음... 추후 해결
  --   "Exafunction/codeium.nvim", -- :Codeium Auth
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({
  --     })
  --   end
  -- },
  -- table.insert(lvim.plugins, {
  --   "zbirenbaum/copilot-cmp", -- :Copilot setup
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
  --       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
  --     end, 100)
  --   end,
  -- })
}


--------------------------------------------------------------------------------
-- Plugins Setting & Key mapping
--------------------------------------------------------------------------------
-- tagbar
vim.cmd([[ let g:tagbar_position = 'topleft vertical' ]])
vim.cmd([[ let g:tagbar_width = '30' ]])

-- visual-multi
-- (Removing lvim default shortcuts)
lvim.keys.normal_mode["<C-UP>"]    = false
lvim.keys.normal_mode["<C-DOWN>"]  = false
lvim.keys.normal_mode["<C-RIGHT>"] = false
lvim.keys.normal_mode["<C-LEFT>"]  = false
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor At Pos"]   = '<C-RIGHT>' ]])

-- emmet-vim
vim.cmd([[ let g:user_emmet_leader_key=',' ]])

-- nvim-colorizer.lua
require 'colorizer'.setup {
  user_default_options = {
    css_fn = false,
    css = true,
    scss = true
  }
}

-- prettier
lvim.keys.normal_mode["<A-f>"] = "<Plug>(Prettier)"
lvim.builtin.which_key.mappings["p"] = { '<Plug>(Prettier)', "Prettier" }

-- Easymotion
lvim.builtin.which_key.mappings["f"] = { '<Plug>(easymotion-f)', "easymotion-f" }
lvim.builtin.which_key.mappings["F"] = { '<Plug>(easymotion-F)', "easymotion-F" }


-- Neoai
require("neoai").setup({
  -- Below are the default options, feel free to override what you would like changed
  ui = {
    output_popup_text = "NeoAI",
    input_popup_text = "Prompt",
    width = 30,               -- As percentage eg. 30%
    output_popup_height = 80, -- As percentage eg. 80%
    submit = "<Enter>",       -- Key binding to submit the prompt
  },
  models = {
    {
      name = "openai",
      model = "gpt-3.5-turbo",
      params = nil,
    },
  },
  register_output = {
    ["g"] = function(output)
      return output
    end,
    ["c"] = require("neoai.utils").extract_code_snippets,
  },
  inject = {
    cutoff_width = 75,
  },
  prompts = {
    context_prompt = function(context)
      return "Hey, I'd like to provide some context for future "
          .. "messages. Here is the code/text that I want to refer "
          .. "to in our upcoming conversations:\n\n"
          .. context
    end,
  },
  mappings = {
    ["select_up"] = "<C-k>",
    ["select_down"] = "<C-j>",
  },
  open_ai = {
    api_key = {
      env = "OPENAI_API_KEY",
      value = nil,
      -- `get` is is a function that retrieves an API key, can be used to override the default method.
      -- get = function() ... end

      -- Here is some code for a function that retrieves an API key. You can use it with
      -- the Linux 'pass' application.
      -- get = function()
      --     local key = vim.fn.system("pass show openai/mytestkey")
      --     key = string.gsub(key, "\n", "")
      --     return key
      -- end,
    },
  },
  shortcuts = {
    {
      name = "textify",
      key = "<leader>as",
      desc = "fix text with AI",
      use_context = true,
      prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
      modes = { "v" },
      strip_function = nil,
    },
    {
      name = "gitcommit",
      key = "<leader>ag",
      desc = "generate git commit message",
      use_context = false,
      prompt = function()
        return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
      end,
      modes = { "n" },
      strip_function = nil,
    },
  },
})

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------
-- Compile
function Compile()
  local filetype = vim.bo.filetype
  if filetype == "c" then
    vim.cmd('w')
    vim.cmd(':! gcc -o ~/bin/c_code %<.c')
    vim.cmd('TermExec cmd="~/bin/c_code"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "cpp" then
    vim.cmd('w')
    vim.cmd(':! g++ -o ~/bin/cpp_code %<.cpp')
    vim.cmd('TermExec cmd="~/bin/cpp_code"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "java" then
    vim.cmd('w')
    vim.cmd(':! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('TermExec cmd="java -cp ~/bin %"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "python" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="python3 %<.py"')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "javascript" then
    vim.cmd('w')
    vim.cmd('TermExec cmd="node %<.js"')
    vim.cmd('set norelativenumber nonu')
  else
    vim.cmd(':echo "This file is not source"')
  end
end

-- Auto Wrap
function Toggle_wrap()
  vim.cmd('set wrap!')
end

--------------------------------------------------------------------------------
-- Autocmd Rules
--------------------------------------------------------------------------------
vim.cmd 'au BufEnter * call v:lua.BufEnter_f()'
vim.cmd 'au BufLeave * call v:lua.BufLeave_f()'

function BufEnter_f()
  if (vim.bo.buftype == "terminal"
      or vim.bo.buftype == "nofile"
      or vim.o.filetype == "tagbar"
      or vim.o.filetype == "NvimTree"
      or vim.o.filetype == "dashboard"
      ) then
    vim.cmd('set norelativenumber')
  else
    vim.cmd('set relativenumber')
  end
end

function BufLeave_f()
  vim.cmd('set norelativenumber')
end

--------------------------------------------------------------------------------
-- Language Setting
--------------------------------------------------------------------------------
vim.cmd 'autocmd Filetype pug setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype c setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype java setlocal ts=4 sw=4 expandtab'
vim.cmd 'autocmd Filetype py setlocal ts=4 sw=4 expandtab'


--------------------------------------------------------------------------------
-- Basic options
--------------------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
lvim.colorscheme = "vscode"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.auto_install = true
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
vim.cmd('set viewdir=~/.vim/view')


--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
--  1. Change which key 'p' to 'P' (to write p as prettier)
--     Modified from "~/.local/share/lunarvim/lvim/lua/lvim/core/which_key.lua"
--
--  2. Comment out'<Tab>' and <S-Tab>  (to use <Tab> in codeium)
--     Modified from "~/.local/share/lunarvim/lvim/lua/lvim/core/cmp.lua"
--------------------------------------------------------------------------------

-- leader key and ESC key
lvim.leader                                = ","
lvim.keys.normal_mode["<C-f>"]             = "<ESC>"
lvim.keys.insert_mode["<C-f>"]             = "<ESC>"
lvim.keys.visual_mode["<C-f>"]             = "<ESC>"
lvim.keys.command_mode["<C-f>"]            = "<ESC>"

-- Quick integrated movement, page movement
lvim.keys.normal_mode["<C-k>"]             = "3k"
lvim.keys.normal_mode["<C-j>"]             = "3j"
lvim.keys.normal_mode["<C-l>"]             = "$"
lvim.keys.normal_mode["<C-h>"]             = "^"
lvim.keys.normal_mode["<C-n>"]             = "3<C-e>"
lvim.keys.normal_mode["<C-p>"]             = "3<C-y>"
lvim.keys.visual_mode["<C-k>"]             = "3k"
lvim.keys.visual_mode["<C-j>"]             = "3j"
lvim.keys.visual_mode["<C-l>"]             = "$"
lvim.keys.visual_mode["<C-h>"]             = "^"
lvim.keys.visual_mode["<C-n>"]             = "3<C-e>"
lvim.keys.visual_mode["<C-p>"]             = "3<C-y>"

-- Use terminal shortcuts in input mode
lvim.keys.insert_mode["<C-l>"]             = "<RIGHT>"
lvim.keys.insert_mode["<C-b>"]             = "<LEFT>"
lvim.keys.insert_mode["<C-a>"]             = "<ESC>^i"
lvim.keys.insert_mode["<C-e>"]             = "<ESC>$a"
lvim.keys.insert_mode["<C-d>"]             = "<DEL>"
lvim.keys.insert_mode["<C-u>"]             = "<ESC><RIGHT>d^i"
lvim.keys.insert_mode["<C-k>"]             = "<ESC><RIGHT>C"
lvim.keys.insert_mode["<C-CR>"]            = "<ESC>o"
lvim.keys.insert_mode["<C-i>"]             = "<ESC>ui"
lvim.keys.insert_mode["<C-o>"]             = "<ESC><C-r>i"

-- Terminal mode shortcut keys
lvim.keys.term_mode["<C-h>"]               = false
lvim.keys.term_mode["<C-k>"]               = false
lvim.keys.term_mode["<C-j>"]               = false
lvim.keys.term_mode["<C-l>"]               = false
lvim.keys.term_mode["<ESC>"]               = "<C-\\><C-n>"
lvim.keys.term_mode["<leader>,"]           = "<cmd>:ToggleTerm<CR>"
lvim.keys.term_mode["<leader>j"]           = "<cmd>:ToggleTerm<CR>"
lvim.builtin.which_key.mappings[","]       = { "<cmd>:ToggleTerm direction=float<CR>", "Terminal" }

-- Sidebar
lvim.builtin.which_key.mappings["e"]       = {} -- disable "File Explorer"
lvim.builtin.which_key.mappings["l"]       = { "<cmd>NvimTreeToggle<CR>", "File Explorer" }
lvim.builtin.which_key.mappings["k"]       = { "<cmd>Telescope buffers previewer=false<cr>", "Buffer list" }
lvim.builtin.which_key.mappings["h"]       = { "<cmd>:TagbarToggle<CR>", "Tagbar" }
lvim.builtin.which_key.mappings["j"]       = {
  "<cmd>:ToggleTerm size=10 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>a", "Terminal bottom" }

-- Split window control (move, resize)
lvim.keys.normal_mode["<A-k>"]             = "<C-W>k<C-W>_"
lvim.keys.normal_mode["<A-j>"]             = "<C-W>j<C-W>_"
lvim.keys.normal_mode["<A-l>"]             = "<C-W>l<C-W>|"
lvim.keys.normal_mode["<A-h>"]             = "<C-W>h<C-W>|"
lvim.keys.normal_mode["<A-p>"]             = "<C-W>2+"
lvim.keys.normal_mode["<A-n>"]             = "<C-W>2-"
lvim.keys.normal_mode["<A-.>"]             = "<C-W>2>"
lvim.keys.normal_mode["<A-,>"]             = "<C-W>2<"
lvim.keys.normal_mode["<A-m>"]             = "<C-W>="

-- Move selected row up or down
lvim.keys.visual_mode["<S-k>"]             = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode["<S-j>"]             = ":m '>+1<CR>gv=gv"

-- buffer
lvim.keys.normal_mode["<tab>"]             = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<s-tab>"]           = ":BufferLineCyclePrev<CR>"

-- Clean search (highlight remove)
lvim.builtin.which_key.mappings["<space>"] = { '<cmd>let @/=""<CR>', "No Highlight" }

-- Compile
lvim.builtin.which_key.mappings["a"]       = { '<cmd>lua Compile()<CR>', "Compile" }

-- Auto wrap
lvim.builtin.which_key.mappings["z"]       = { '<cmd>lua Toggle_wrap()<CR>', "Wrap" }

-- Diffsplit
lvim.builtin.which_key.mappings["d"]       = { ':vert diffsplit ', "diffsplit" }

-- Register
lvim.builtin.which_key.mappings["r"]       = { '<cmd>:reg<cr>', "Register" }

-- Set the current path as the working path
lvim.builtin.which_key.mappings["~"]       = { '<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>', "change workspace" }
