-------------------------------------------
-- Manually install additional plugins
-------------------------------------------
-- $ brew install fd universal-ctags luarocks fzf ripgrep
-- :MasonInstall stylua black prettier clang-format google-java-format shfmt

local plugins = {
  -------------------------------------------
  -- 편집 보조 플러그인
  -------------------------------------------
  -- vim-codeium (AI 자동완성)
  {
    "Exafunction/codeium.vim", -- :Codeium Auth
    event = "VimEnter",
  },

  -- vim-visual-multi (멀티 커서)
  {
    "mg979/vim-visual-multi",
    event = "vimEnter",
  },

  -- vim-illuminate (단어 하이라이트)
  {
    "RRethy/vim-illuminate",
    event = "VimEnter",
  },

  -- vim-lastplace (커서 마지막 위치 저장)
  {
    "farmergreg/vim-lastplace",
    lazy = false,
  },

  -- which-key.nvim (키 맵핑 보기)
  {
    "folke/which-key.nvim",
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    keys = {
      {
        "<leader>",
        function() end,
      },
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    event = "VeryLazy",
  },

  -------------------------------------------
  -- 문법 플러그인
  -------------------------------------------
  -- formatter.nvim (코드 포맷팅)
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = { require("formatter.filetypes.lua").stylua },
          python = { require("formatter.filetypes.python").black, require("formatter.filetypes.python").isort },
          javascript = { require("formatter.filetypes.javascript").prettier },
          typescript = { require("formatter.filetypes.typescript").prettier },
          html = { require("formatter.filetypes.html").prettier },
          css = { require("formatter.filetypes.css").prettier },
          c = { require("formatter.filetypes.c").clangformat },
          cpp = { require("formatter.filetypes.cpp").clangformat },
          java = { require("formatter.filetypes.java").google_java_format },
          sh = { require("formatter.filetypes.sh").shfmt },
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
      }
    end,
    event = "BufWritePre",
  },

  -- vim-snippets (코드 스니펫) https://github.com/honza/vim-snippets/tree/master/snippets
  {
    "honza/vim-snippets",
    event = "BufRead",
  },

  -- vim-pug (pug문법 사용)
  {
    "digitaltoad/vim-pug",
    event = "FileType pug",
  },

  -- emmet-vim (emmet 문법 사용)
  {
    "mattn/emmet-vim",
    event = "FileType html,javascript,javascriptreact",
  },


  -------------------------------------------
  -- 사이드 바 플러그인
  -------------------------------------------
  -- fzf (fzf 파일 탐색기 보기)
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.nvim" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {
        keymap = {
          builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-d>"] = "preview-page-up",
          },
        },
      }
    end,
  },

  -- nvim-navbuddy (코드 네비게이터 보기)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        config = function()
          require("nvim-navbuddy").setup {
            lsp = {
              auto_attach = true,
            },
            window = {
              size = "90%", -- Or table format example: { height = "40%", width = "100%"}
            },
            mappings = {
              ["<leader>k"] = require("nvim-navbuddy.actions").close(),
            },
          }
        end,
      },
    },
  },

  -- symbols-outline (코드 아웃라인 보기)
  {
    "simrat39/symbols-outline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.nvim" },
    config = function()
      require("symbols-outline").setup()
    end,
    cmd = "SymbolsOutline",
  },

  -- tagbar (코드 태그 보기)
  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
  },

  -- JABS.nvim (버퍼 리스트 보기)
  {
    "matbme/JABS.nvim",
    config = function()
      require("jabs").setup {
        position = { "center", "center" },
        width = 80,
        height = 20,
        border = "single",
        sort_mru = true,

        -- Options for preview window
        preview = {
          width = 90,
          height = 40,
          border = "single",
        },

        -- Default symbols
        symbols = {
          current = "C", -- default 
          alternate = "A", -- default 
          ro = "R", -- default 
        },

        -- Keymaps
        keymap = {
          close = "dd", -- Close buffer. Default D
          preview = "p", -- Open buffer preview. Default P
        },
      }
    end,
    cmd = "JABSOpen",
  },

  -- toggleterm.nvim (터미널 보기)
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        shade_terminals = true,
        start_in_insert = true,
        direction = "float",
      }
    end,
    version = "*",
    event = "VeryLazy",
  },

  -- barbecue (상단 요소 정보 표시)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.nvim",
    },
    opts = {
      -- configurations go here
    },
    event = "VimEnter",
  },

  -------------------------------------------
  -- 의존성 플러그인
  -------------------------------------------
  -- nvim-navic (for barbecue, navbuddy)
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup()
    end,
  },
  -- nui.nvim (for navbuddy)
  { "MunifTanjim/nui.nvim" },
}

return plugins
