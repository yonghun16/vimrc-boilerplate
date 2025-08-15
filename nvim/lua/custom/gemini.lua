local M = {}

-- 윈도우, 버퍼, 열림 상태
M.win = nil
M.buf = nil
M.is_open = false

function M.toggle()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    -- 윈도우가 열려있으면 숨기기
    vim.api.nvim_win_hide(M.win)
    M.is_open = false
  else
    if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
      -- 터미널 버퍼가 없으면 새로 생성
      M.buf = vim.api.nvim_create_buf(false, true)
      vim.cmd("rightbelow vsplit")
      M.win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(M.win, M.buf)
      vim.api.nvim_win_set_width(M.win, 60)
      vim.api.nvim_win_set_option(M.win, "winfixwidth", true)
      vim.fn.termopen("gemini")
      vim.cmd("startinsert")
    else
      -- 이미 존재하는 터미널 재사용
      vim.cmd("rightbelow vsplit")
      M.win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(M.win, M.buf)
      vim.api.nvim_win_set_width(M.win, 60)
      vim.api.nvim_win_set_option(M.win, "winfixwidth", true)
      vim.cmd("startinsert")
    end
    M.is_open = true
  end
end

return M
