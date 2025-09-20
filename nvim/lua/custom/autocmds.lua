require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local o = vim.o

-- CursorLine: 포커스 창에서만 활성화
autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    o.cursorlineopt = "both"
    o.cursorline = true
  end,
})

autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    o.cursorlineopt = "both"
    o.cursorline = false
  end,
})

-- TypeScript: ts_ls 자동 시작
autocmd("BufWritePost", {
  pattern = "*.ts",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- filetype이 typescript가 아니면 설정
    if vim.bo.filetype ~= "typescript" then
      vim.bo.filetype = "typescript"
    end

    -- 이미 ts_ls가 연결되어 있는지 확인
    local has_tsclient = false
    for _, client in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
      if client.name == "ts_ls" then
        has_tsclient = true
        break
      end
    end

    -- 연결되어 있지 않으면 ts_ls 시작
    if not has_tsclient then
      vim.cmd "LspStart ts_ls"
    end
  end,
})
