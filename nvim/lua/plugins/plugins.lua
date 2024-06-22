local overrides = require "configs.overrides"

---------------------------------------------------------------------------
-- Addtional plugins
---------------------------------------------------------------------------
-- $ brew install fd universal-ctags fzf ripgrep pyright black

local plugins = {
  -------------------------------------------
  -- 문법 플러그인
  -------------------------------------------
  -- vim-codeium (AI 자동완성)
  {
    "Exafunction/codeium.vim", -- :Codeium Auth
    event = "VimEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<s-space>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-s-n>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-s-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    end,
  },

  -- vim-pug (pug문법 사용)
  {
    "digitaltoad/vim-pug",
    event = "FileType pug",
  },

  -- emmet-vim (emmet 문법 사용)
  {
    "mattn/emmet-vim",
    event = "FileType html",
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

  -- vim-visual-multi (멀티 커서)
  {
    "mg979/vim-visual-multi",
    event = "vimEnter",
  },

  -------------------------------------------
  -- 사이드 바 출력 플러그인
  -------------------------------------------
  -- fzf (fzf 파일 탐색기 보기)
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
        opts = overrides.navbuddy,
      },
    },
  },

  -- symbols-outline (코드 아웃라인 보기)
  {
    "simrat39/symbols-outline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
    opts = overrides.jabs,
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
    event = "VimEnter",
  },

  -------------------------------------------
  -- 상태 표시 플러그인
  -------------------------------------------
  -- barbecue (상단 요소 정보 표시)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configurations go here
    },
    event = "BufReadPre",
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
