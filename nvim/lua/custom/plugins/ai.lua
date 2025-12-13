local plugins = {
  -------------------------------------------
  -- AI
  -------------------------------------------
  -- windsuf.vim (AI 코드 자동완성)
  -- :Codeium Auth
  {
    "Exafunction/windsurf.vim",
    event = { "InsertEnter", "BufReadPost" },
    init = function()
      vim.g.codeium_enabled = true
    end,
  },
}

return plugins
