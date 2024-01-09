--==============================================================================
--
--  File name   : config.lua for Lunarvim
--  Version     : 1.2.1
--  Last update : 2024. 1. 9
--  Maker       : yonghun16 (https://github.com/yonghun16/vimrc-boilerplate)
--
--==============================================================================


--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
lvim.plugins = {
  -- Plug
  {
    "preservim/tagbar", -- https://github.com/universal-ctags/ctags
    "easymotion/vim-easymotion",
    "farmergreg/vim-lastplace",
    "mg979/vim-visual-multi",
    "digitaltoad/vim-pug",
    "mattn/emmet-vim",
    "prettier/vim-prettier",   -- $npm install -g prettier)
    "sbdchd/neoformat",        -- for pretter
    "Mofiqul/vscode.nvim",     -- colorscheme VScode
    "NvChad/nvim-colorizer.lua",
    "Exafunction/codeium.vim", -- :Codeium Auth
  },
  --lazy.nvim
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "tpope/vim-surround",
  },
  -- {  -- codeium nvim버젼이 작동이 안됨.. 이유는 아직 모르겠음 추후 해결
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


--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------
-- Compile
function Compile()
  local filetype = vim.bo.filetype
  if filetype == "c" then
    vim.cmd('w')
    vim.cmd('! gcc -o ~/bin/%< %<.c')
    vim.cmd('terminal ~/bin/%<')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "cpp" then
    vim.cmd('w')
    vim.cmd('! g++ -o ~/bin/%< %<.cpp')
    vim.cmd('terminal ~/bin/%<')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "java" then
    vim.cmd('w')
    vim.cmd('! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('terminal java -cp ~/bin %<')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "python" then
    vim.cmd('w')
    vim.cmd('terminal python3 %<.py')
    vim.cmd('set norelativenumber nonu')
  elseif filetype == "javascript" then
    vim.cmd('w')
    vim.cmd('terminal node %<.js')
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
-- vim.cmd 'au BufWinEnter * silent! loadview'
-- vim.cmd 'au BufWinLeave * mkview'

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


--------------------------------------------------------------------------------
-- Basic options
--------------------------------------------------------------------------------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
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
--------------------------------------------------------------------------------
--
--  1. prettier를 위해 which key 'p'를 'P'로 변경
--    "~/.local/share/lunarvim/lvim/lua/lvim/core/which_key.lua"에서 수정
--
--  2. codeium을 위해 자동완성의 '<Tab>'을 '<C-m>'으로 변경
--    "~/.local/share/lunarvim/lvim/lua/lvim/core/cmp.lua"에서 수정
--    (<Tab>을 <C-m> 변경 후, cmp.select_next_item()와 <S-Tab>설정 전체 주석
--
--------------------------------------------------------------------------------
-- leader 키 설정
lvim.builtin.which_key.mappings["e"]       = {}
lvim.leader                                = ","

-- ESC 키를 <Ctrl+f>로 변경
lvim.keys.normal_mode["<C-f>"]             = "<ESC>"
lvim.keys.term_mode["<C-f>"]               = "<C-\\><C-n>"
lvim.keys.term_mode["<ESC>"]               = "<C-\\><C-n>"
lvim.keys.insert_mode["<C-f>"]             = "<ESC>"
lvim.keys.visual_mode["<C-f>"]             = "<ESC>"
lvim.keys.command_mode["<C-f>"]            = "<ESC>"

-- 빠른 커서 이동,  페이지 이동
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

-- 편집모드에서 터미널 단축키 사용 및 기타
lvim.keys.insert_mode["<C-l>"]             = "<RIGHT>"
lvim.keys.insert_mode["<C-b>"]             = "<LEFT>"
lvim.keys.insert_mode["<C-a>"]             = "<ESC>^i"
lvim.keys.insert_mode["<C-e>"]             = "<ESC>$a"
lvim.keys.insert_mode["<C-d>"]             = "<DEL>"
lvim.keys.insert_mode["<C-k>"]             = "<ESC><RIGHT>C"
lvim.keys.insert_mode["<C-u>"]             = "<ESC><RIGHT>d^i"
lvim.keys.insert_mode["<C-CR>"]            = "<ESC>o"
lvim.keys.insert_mode["<A-f>"]             = "<ESC><RIGHT>wi"
lvim.keys.insert_mode["<A-b>"]             = "<ESC>bi"

-- 영역지정 된 행을 위아래로 이동
lvim.keys.normal_mode["<A-k>"]             = false
lvim.keys.normal_mode["<A-j>"]             = false
lvim.keys.visual_mode["<S-j>"]             = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<S-k>"]             = ":m '<-2<CR>gv=gv"

-- 분할창 제어
-- (visual-multi 위해 lvim 기본 분할창 이동 단축키 삭제)
lvim.keys.normal_mode["<C-UP>"]            = false
lvim.keys.normal_mode["<C-DOWN>"]          = false
lvim.keys.normal_mode["<C-RIGHT>"]         = false
lvim.keys.normal_mode["<C-LEFT>"]          = false
-- (분할창 확대 이동)
lvim.keys.normal_mode["<A-k>"]             = "<C-W>k<C-W>_"
lvim.keys.normal_mode["<A-j>"]             = "<C-W>j<C-W>_"
lvim.keys.normal_mode["<A-l>"]             = "<C-W>l<C-W>|"
lvim.keys.normal_mode["<A-h>"]             = "<C-W>h<C-W>|"
-- (분할창 크기 조절)
lvim.keys.normal_mode["<A-p>"]             = "<C-W>2+"
lvim.keys.normal_mode["<A-n>"]             = "<C-W>2-"
lvim.keys.normal_mode["<A-.>"]             = "<C-W>2>"
lvim.keys.normal_mode["<A-,>"]             = "<C-W>2<"
lvim.keys.normal_mode["<A-m>"]             = "<C-W>="

-- 들여쓰기/ 내어쓰기
lvim.keys.visual_mode[">>"]                = ">gv"
lvim.keys.visual_mode["<<"]                = "<gv"

-- 버퍼
lvim.keys.normal_mode["<tab>"]             = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<s-tab>"]           = ":BufferLineCyclePrev<CR>"

-- 터미널 모드 단축키
lvim.keys.term_mode["<C-k>"]               = false
lvim.keys.term_mode["<C-j>"]               = false
lvim.keys.term_mode["<C-l>"]               = "<RIGHT>"
lvim.keys.term_mode["<C-h>"]               = false
lvim.keys.term_mode["<leader>,"]           =
"<cmd>:ToggleTerm size=10 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>"

-- 사이드바
lvim.builtin.which_key.mappings["k"]       = { "<cmd>Telescope buffers previewer=false<cr>", "Buffer list" }
lvim.builtin.which_key.mappings["h"]       = { "<cmd>:TagbarToggle<CR>", "Tagbar" }
lvim.builtin.which_key.mappings["l"]       = { "<cmd>NvimTreeToggle<CR>", "File Explorer" }
lvim.builtin.which_key.mappings["j"]       = {
  "<cmd>:ToggleTerm size=10 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>", "Terminal bottom" }

-- Terminal
lvim.builtin.which_key.mappings[","]       = { "<cmd>:ToggleTerm direction=float<CR>", "Terminal" }

-- Clean search (highlight)
lvim.builtin.which_key.mappings["<space>"] = { '<cmd>let @/=""<CR>', "No Highlight" }

-- Compile
lvim.builtin.which_key.mappings["a"]       = { '<cmd>lua Compile()<CR>', "Compile" }

-- Auto wrap
lvim.builtin.which_key.mappings["z"]       = { '<cmd>lua Toggle_wrap()<CR>', "Wrap" }

-- 파일비교(diffsplit)
lvim.builtin.which_key.mappings["d"]       = { ':vert diffsplit ', "diffsplit" }

-- 레지스터 보기
lvim.builtin.which_key.mappings["r"]       = { '<cmd>:reg<cr>', "Register" }

-- 현재 경로를 작업경로로 설정
lvim.builtin.which_key.mappings["~"]       = { '<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>', "change workspace" }
