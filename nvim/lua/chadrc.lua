-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

-- chadrc.lua

---@type ChadrcConfig
local M = {}

-- 1. 상태 저장 파일 경로 설정
local state_file = vim.fn.stdpath "data" .. "/transparency_state"
local is_transparent = true -- 파일이 없을 때 기본값 (투명)

-- 2. 파일이 존재하면 읽어서 상태(true/false) 확인
if vim.fn.filereadable(state_file) == 1 then
  local content = vim.fn.readfile(state_file)
  if content[1] == "false" then
    is_transparent = false
  end
end

M.base46 = {
  theme = "solarized_osaka",

  -- 3. 읽어온 값 적용
  transparency = is_transparent,

  hl_override = {
    CursorLine = { bg = "#00212e" },
    StatusLine = { bg = "#00212e" },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    NormalFloat = { bg = "#021923" },

    -- 읽어온 값에 따라 배경색 결정
    Normal = { bg = is_transparent and "NONE" or "#00121a" },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
