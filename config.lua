--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    "preservim/tagbar", -- https://github.com/universal-ctags/ctags
    "easymotion/vim-easymotion",
    "farmergreg/vim-lastplace",
    "mg979/vim-visual-multi",
  },
}

--------------------------------------------------------------------------------
-- Plugins setting
--------------------------------------------------------------------------------
-- tagbar
vim.cmd([[ let g:tagbar_position = 'topleft vertical' ]])
vim.cmd([[ let g:tagbar_width = '30' ]])

-- visual-multi
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor Up"]   = '<C-Up>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor Down"]   = '<C-Down>' ]])

--------------------------------------------------------------------------------
-- Function
--------------------------------------------------------------------------------
function Compile()
  vim.cmd('w')
  local filetype = vim.bo.filetype
  if filetype == "c" then
    vim.cmd('! gcc -o ~/bin/%< %<.c')
    vim.cmd('! ~/bin/%<')
  elseif filetype == "cpp" then
    vim.cmd('! g++ -o ~/bin/%< %<.cpp')
    vim.cmd('! ~/bin/%<')
  elseif filetype == "java" then
    vim.cmd('! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('! java -cp ~/bin %<')
  elseif filetype == "python" then
    vim.cmd('! python3 %<.py')
  elseif filetype == "javascript" then
    vim.cmd('! node %<.js')
  end
end

--------------------------------------------------------------------------------
-- Autocmd Rules
--------------------------------------------------------------------------------
vim.cmd 'au BufEnter * call v:lua.BufEnter_f()'

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

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = { "*.*" },
  command = "set norelativenumber",
})

--------------------------------------------------------------------------------
-- Basic options
--------------------------------------------------------------------------------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3


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

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
-- leader 키 설정
lvim.leader = ","

-- 쓰지 않는 단축키 삭제
lvim.keys.term_mode["<C-k>"] = false
lvim.keys.term_mode["<C-j>"] = false
lvim.keys.term_mode["<C-l>"] = false
lvim.keys.term_mode["<C-h>"] = false
lvim.builtin.which_key.mappings["e"] = {}

-- ESC 키를 편하게 <Ctrl+f>로 변경
lvim.keys.normal_mode["<C-f>"] = "<ESC>"
lvim.keys.term_mode["<C-f>"] = "<ESC>"
lvim.keys.insert_mode["<C-f>"] = "<ESC>"
lvim.keys.normal_mode["<ESC>"] = "<C-\\><C-n>"
lvim.keys.term_mode["<ESC>"] = "<C-\\><C-n>"
lvim.keys.insert_mode["<ESC>"] = "<C-\\><C-n>"

-- 입력모드에서 터미널 단축키 사용 및 기타
lvim.keys.insert_mode["<C-l>"] = "<RIGHT>"
lvim.keys.insert_mode["<C-b>"] = "<LEFT>"
lvim.keys.insert_mode["<C-a>"] = "<ESC>^i"
lvim.keys.insert_mode["<C-e>"] = "<ESC>$a"
lvim.keys.insert_mode["<C-d>"] = "<DEL>"
lvim.keys.insert_mode["<C-k>"] = "<ESC><RIGHT>C"
lvim.keys.insert_mode["<C-ENTER>"] = "<ESC>o"

-- 빠른 커서 이동,  페이지 이동
lvim.keys.normal_mode["<C-k>"] = "3k"
lvim.keys.normal_mode["<C-j>"] = "3j"
lvim.keys.normal_mode["<C-l>"] = "$"
lvim.keys.normal_mode["<C-h>"] = "^"
lvim.keys.normal_mode["<C-n>"] = "<C-e><down><Up><C-e><down><up><C-e>"
lvim.keys.normal_mode["<C-p>"] = "<C-y><up><down><C-y><up><down><C-y>"

-- 사이드바
lvim.builtin.which_key.mappings["k"] = { "<cmd>Telescope buffers previewer=false<cr>", "Buffers" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>:TagbarToggle<CR>", "Tagbar" }
lvim.builtin.which_key.mappings["l"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
lvim.builtin.which_key.mappings["j"] = {
  "<cmd>:ToggleTerm size=13 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>",
  "Terminal bottom" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>:ToggleTerm direction=float<CR>", "Terminal" }

-- Buffer
lvim.keys.normal_mode["<tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<s-tab>"] = ":BufferLineCyclePrev<CR>"

-- 영역지정 된 행을 위아래로 이동,  들여쓰기/ 내어쓰기
lvim.keys.visual_mode["<S-j>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<S-k>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode[">>"] = ">gv"
lvim.keys.visual_mode["<<"] = "<gv"

-- Clean search (highlight)
lvim.builtin.which_key.mappings["<space>"] = { '<cmd>let @/=""<CR>', "No Highlight" }

-- Compile
lvim.builtin.which_key.mappings["a"] = { '<cmd>lua Compile()<CR>', "Compile" }

-- 분할하기,  파일비교
lvim.builtin.which_key.mappings["s"] = { '<cmd>:split<CR>', "split" }
lvim.builtin.which_key.mappings["v"] = { '<cmd>:vsplit<CR>', "vsplit" }
lvim.builtin.which_key.mappings["d"] = { ':vert diffsplit ', "diffsplit" }

-- 레지스터 보기
lvim.builtin.which_key.mappings["r"] = { '<cmd>:reg<cr>', "Register" }

-- Easymotion
lvim.builtin.which_key.mappings["f"] = { '<Plug>(easymotion-f)', "easymotion-f" }
lvim.builtin.which_key.mappings["F"] = { '<Plug>(easymotion-F)', "easymotion-F" }

-- 현재 경로를 작업경로로 설정
lvim.builtin.which_key.mappings[","] = { '<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>', "change workspace" }
