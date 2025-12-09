require "nvchad.options"

------------------------------------------------------------------
-- Basic options
------------------------------------------------------------------
-- tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "html",
    "css",
    "lua",
    "dart",
    "R",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- number line
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- scroll
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

-- folding
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- etc
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 200
vim.opt.wrap = false

------------------------------------------------------------------
-- Plugin options
------------------------------------------------------------------
-- codium(Windsurf)
vim.g.codeium_enabled = true

-- emmet-vim
vim.g.user_emmet_leader_key = ","

-- fzf
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"

-- indent-blankline
require("ibl").update {
  vim.api.nvim_set_hl(0, "IndentBlanklineChar", { underline = true }), -- function definitions (height -> underline)
}

-- nvim-Tree
require("nvim-tree").setup {
  hijack_cursor = true,

  on_attach = function(bufnr)
    local api = require "nvim-tree.api"

    api.config.mappings.default_on_attach(bufnr) -- 기본 키맵 적용

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.del("n", "<C-k>", { buffer = bufnr }) -- Ctrl+k 제거
    vim.keymap.set("n", "K", api.node.show_info_popup, opts "Show Info") -- Shift+k 로 파일 정보 보기
    vim.keymap.set("n", "i", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "s", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "t", api.node.open.tab, opts "Open: New Tab")
  end,
}

-- snippets
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/custom/snippets" }

-- visual-multi
vim.cmd [[ let g:VM_maps = {} ]]
vim.cmd [[ let g:VM_maps["Find Under"] = 's/' ]]
vim.cmd [[ let g:VM_maps["Find Subword Under"] = 's/' ]]
vim.cmd [[ let g:VM_maps["Add Cursor Down"] = 'sj' ]]
vim.cmd [[ let g:VM_maps["Add Cursor Up"] = 'sk' ]]
vim.cmd [[ let g:VM_maps["Move Right"] = 'sl' ]]
vim.cmd [[ let g:VM_maps["Move Left"] = 'sh' ]]
vim.cmd [[ let g:VM_maps["Mouse Cursor"] = 's<LeftMouse>' ]]
vim.cmd [[ let g:VM_maps["Add Cursor At Pos"] = 's<CR>' ]]
vim.cmd [[ let g:VM_maps["Select Operator"] = 'ss' ]]

------------------------------------------------------------------
-- Functions
------------------------------------------------------------------
-- Safe Quit
function SafeQuitAll()
  -- 저장되지 않은 버퍼가 있는지 확인
  local modified_bufs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].modified then
      table.insert(modified_bufs, buf)
    end
  end

  if #modified_bufs > 0 then
    local choice = vim.fn.confirm("There are unsaved changes. Save before quitting?", "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then
      vim.cmd "wa" -- 모든 버퍼 저장
      vim.cmd "qa" -- 종료
    elseif choice == 2 then
      vim.cmd "qa!" -- 저장하지 않고 종료
    else
      return -- Cancel: 종료 안 함
    end
  else
    vim.cmd "qa" -- 변경사항 없으면 그냥 종료
  end
end

-- Compile and Run
function Compile()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand "%:t:r" -- 파일 이름 (확장자 제외)
  local project_dir = vim.fn.expand "%:p:h" -- 현재 파일이 속한 디렉토리
  local filepath = vim.fn.expand "%:p" -- 전체 경로
  local bin_dir = os.getenv "HOME" .. "/bin"
  vim.fn.mkdir(bin_dir, "p") -- ~/bin 디렉토리 없으면 생성
  local binpath = bin_dir .. "/" .. filename

  vim.cmd "w" -- 항상 저장

  if filetype == "python" then
    vim.cmd(string.format('TermExec cmd="python3 %s"', filepath))
  elseif filetype == "javascript" then
    vim.cmd(string.format('TermExec cmd="node %s"', filepath))
  elseif filetype == "typescript" then
    local tsconfig_exists = vim.fn.filereadable "tsconfig.json" == 1
    if not tsconfig_exists then
      local tsconfig_content = {
        "{",
        '  "compilerOptions": {',
        '    "target": "ES2020",',
        '    "module": "ESNext",',
        '    "moduleResolution": "node",',
        '    "lib": ["ESNext", "Dom"],',
        '    "strict": true,',
        '    "skipLibCheck": true,',
        '    "esModuleInterop": true,',
        '    "forceConsistentCasingInFileNames": true',
        "  },",
        '  "include": ["src/**/*"],',
        '  "exclude": ["node_modules"]',
        "}",
      }
      vim.fn.writefile(tsconfig_content, "tsconfig.json")
    end
    -- ts-node로 직접 실행
    vim.cmd(string.format('TermExec cmd="ts-node %s"', filepath))
    -- 만약 ~/bin에 JS 파일로 컴파일 후 실행하고 싶으면 아래 주석 해제
    -- vim.cmd(string.format(":!tsc %s --outDir %s", filepath, bin_dir))
    -- vim.cmd(string.format('TermExec cmd="node %s/%s.js"', bin_dir, filename))
  elseif filetype == "c" then
    vim.cmd(string.format(":!gcc -o %s %s/*.c", binpath, project_dir))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  elseif filetype == "cpp" then
    vim.cmd(string.format(":!g++ -o %s %s/*.cpp", binpath, project_dir))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  elseif filetype == "java" then
    vim.cmd(string.format(":!javac -encoding utf-8 -d %s %s", bin_dir, filepath))
    vim.cmd(string.format('TermExec cmd="java -cp %s %s"', bin_dir, filename))
  else
    vim.cmd ':echo "This file is not a supported source file."'
  end
end

-- Compile and Run (single file)
function CompileSingle()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand "%:t:r" -- 파일 이름 (확장자 제외)
  local filepath = vim.fn.expand "%:p" -- 전체 경로
  local bin_dir = os.getenv "HOME" .. "/bin"
  vim.fn.mkdir(bin_dir, "p") -- ~/bin 없으면 생성
  local binpath = bin_dir .. "/" .. filename

  vim.cmd "w" -- 항상 저장

  if filetype == "c" then
    -- 현재 파일만 컴파일
    vim.cmd(string.format(":!gcc -o %s %s", binpath, filepath))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  elseif filetype == "cpp" then
    vim.cmd(string.format(":!g++ -o %s %s", binpath, filepath))
    vim.cmd(string.format('TermExec cmd="%s"', binpath))
  else
    vim.cmd ':echo "This file is not supported for single file compile."'
  end
end

-- Reload (and LSP Restart)
function ReloadAndLSPRestart()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
    client:stop(true)
  end
  vim.defer_fn(function()
    vim.cmd "edit" -- 버퍼를 다시 로드하여 LSP 자동 attach 유도
  end, 100)
end

-- Toggle Codium(Windsurf)
function ToggleAIAutoComplete()
  if vim.g.codeium_enabled == nil or vim.g.codeium_enabled == false then
    vim.g.codeium_enabled = true
    vim.cmd "CodeiumEnable"
    print "Codeium enabled"
  else
    vim.g.codeium_enabled = false
    vim.cmd "CodeiumDisable"
    print "Codeium disabled"
  end
end

-- Toggle Gemini CLI
local gemini_term = nil
function ToggleGemini()
  if gemini_term and vim.api.nvim_win_is_valid(gemini_term) then
    vim.api.nvim_win_close(gemini_term, true)
    gemini_term = nil
  else
    vim.cmd "vsplit"
    vim.cmd "wincmd l" -- 오른쪽으로 이동
    vim.cmd "resize 45" -- 너비 조정
    vim.cmd "terminal gemini chat"
    gemini_term = vim.api.nvim_get_current_win()
  end
end

-- Toggle Dynamic Foldcolumn
local MIN_FOLDCOL = 0
local MAX_FOLDCOL = 6
local foldcolumn_visible = false

local function get_max_fold_level()
  local max_level = 0
  for lnum = 1, vim.fn.line "$" do
    local level = vim.fn.foldlevel(lnum)
    if level > max_level then
      max_level = level
    end
  end
  return math.min(max_level, MAX_FOLDCOL)
end

function ToggleFoldColumn()
  if not foldcolumn_visible then
    vim.wo.foldcolumn = tostring(math.max(get_max_fold_level(), 1))
    vim.wo.relativenumber = false
    foldcolumn_visible = true
  else
    vim.wo.foldcolumn = tostring(MIN_FOLDCOL)
    vim.wo.relativenumber = true
    foldcolumn_visible = false
  end
end
