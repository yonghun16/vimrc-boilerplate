local plugins = {
  -- ================================================================
  -- Coding
  -- ================================================================
  -- LuaSnip (스니펫)
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load {
        paths = vim.fn.stdpath "config" .. "/lua/custom/snippets",
      }
    end,
  },

  -- neogen (함수/클래스 주석 자동 생성)
  {
    "danymat/neogen",
    config = true,
    cmd = "Neogen",
    -- version = "*"
  },

  -- nvim-cmp (코드 자동완성 및 제안)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function(_, opts)
      if opts.mapping then
        opts.mapping["<Tab>"] = nil
        opts.mapping["<S-Tab>"] = nil
      end
    end,
  },

  -- nvim-ts-autotag (닫는 태그 자동완성)
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- outline (코드 아웃라인 보기)
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    config = function()
      require("outline").setup {
        outline_window = {
          position = "left",
          width = 20,
        },
        show_numbers = false,
        show_relative_numbers = false,
        show_guides = true,
      }
    end,
  },
}

return plugins
