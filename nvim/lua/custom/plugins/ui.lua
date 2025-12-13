local plugins = {
  -- ================================================================
  -- UI
  -- ================================================================
  -- neoscroll.nvim (부드러운 스크롤)
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
      hide_cursor = true,
      easing = "quadratic",
    },
  },
}

return plugins
