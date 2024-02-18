local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  ---------------------------------------------------------------------------
  -- VimScript Plugins
  ---------------------------------------------------------------------------
  {"farmergreg/vim-lastplace", lazy = false },
  {"preservim/tagbar", lazy = false}, -- https://github.com/universal-ctags/ctags
  {"mg979/vim-visual-multi", lazy = false},
  {"digitaltoad/vim-pug", lazy = false},
  {"mattn/emmet-vim", lazy = false},
  {"tpope/vim-surround", lazy = false},
  {"prettier/vim-prettier", lazy = false},   -- $npm install -g prettier)
  {"sbdchd/neoformat", lazy = false},        -- for prettier
  {"Exafunction/codeium.vim", lazy = false}, -- :Codeium Auth

  ---------------------------------------------------------------------------
  -- Lua Plugins
  ---------------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    lazy = false
  },

  {
    "RRethy/vim-illuminate",
    lazy = false
  },

  {
    "Tastyep/structlog.nvim",
    lazy = false
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false
  },

  {
    "folke/lsp-colors.nvim", lazy = false
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        on_attach = "default",
        view = {
          side = "right",
        }
      }
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- {  -- codeium nvim 버전 작동 안됨... 이유는 아직 모르겠음... 추후 해결
  --   "Exafunction/codeium.nvim", -- :Codeium Auth
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({
  --     })
  --   end
  -- },
  -- table.insert(lvim.plugins, {
  --   "zbirenbaum/copilot-cmp", -- :Copilot setup
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
  --       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
  --     end, 100)
  --   end,
  -- })


  -- {"SmiteshP/nvim-navic"},
  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   version = "*",
  --   dependencies = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   opts = {
  --   },
  --   lazy = false
  -- },
}

return plugins
