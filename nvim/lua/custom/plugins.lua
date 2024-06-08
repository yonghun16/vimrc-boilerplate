local overrides = require("custom.configs.overrides")

---------------------------------------------------------------------------
-- Addtional plugins
---------------------------------------------------------------------------
-- $ brew install fd
-- $ brew install universal-ctags
-- $ brew install ripgrep
-- $ brew install pyright
-- $ brew install black
-- $ brew install jdtls

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
---@type NvPluginSpec[]
local plugins = {
  -- vim-codeium
  {
    "Exafunction/codeium.vim", -- :Codeium Auth
    event = "BufEnter",
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<RIGHT>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-s-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-s-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  },

  -- JABS.nvim
  {
    "matbme/JABS.nvim",
    opts = overrides.jabs,
    cmd = "JABSOpen",
  },

  -- vim-lastplace
  {
    "farmergreg/vim-lastplace",
    lazy = false
  },

  -- vim-pug
  {
    "digitaltoad/vim-pug",
    event = "FileType pug",
  },

  -- emmet-vim
  {
    "mattn/emmet-vim",
    event = "FileType html",
  },

  -- vim-surround
  {
    "tpope/vim-surround",
    event = "VimEnter",
  },

  -- vim-visual-multi
  {
    "mg979/vim-visual-multi",
    event = "vimEnter",
  },

  -- barbecue
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

  -- goto-preview
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup()
    end,
  },

  -- symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("symbols-outline").setup()
    end,
    cmd = "SymbolsOutline",
  },

  {
    "preservim/tagbar",
    cmd = "TagbarToggle"
  },

  -- nvim-navic
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup()
    end
  },

  -- toggleterm.nvim
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

  -- vim-illuminate
  {
    "RRethy/vim-illuminate",
    event = "VimEnter",
  },

  -- structlog.nvim
  {
    "Tastyep/structlog.nvim",
    event = "VimEnter",
  },

  -- nvim-ts-context-commentstring
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VimEnter",
  },

  -- lsp-colors.nvim
  {
    "folke/lsp-colors.nvim",
    event = "VimEnter",
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
  },

  -- nvim-navbuddy
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = overrides.navbuddy
      }
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  -- mason-null-ls.nvim
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "black" }
      })

      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
        },
      })
    end
  },

  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  -- nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- conform.nvim
  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- nui.nvim
  {
    "MunifTanjim/nui.nvim",
  },

  -- NeoAI
  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
    },
    config = function()
      require("neoai").setup({
        ui = {
          output_popup_text = "NeoAI",
          input_popup_text = "Prompt",
          width = 30,               -- As percentage eg. 30%
          output_popup_height = 80, -- As percentage eg. 80%
          submit = "<Enter>",       -- Key binding to submit the prompt
        },
        models = {
          {
            name = "openai",
            model = "gpt-3.5-turbo",
            params = nil,
          },
        },
        register_output = {
          ["g"] = function(output)
            return output
          end,
          ["c"] = require("neoai.utils").extract_code_snippets,
        },
        inject = {
          cutoff_width = 75,
        },
        prompts = {
          context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
                .. "messages. Here is the code/text that I want to refer "
                .. "to in our upcoming conversations:\n\n"
                .. context
          end,
        },
        mappings = {
          ["select_up"] = "<A-]>",
          ["select_down"] = "<A-[]>",
        },
        open_ai = {
          api_key = {
            env = "OPENAI_API_KEY",
            value = nil,
          },
        },
        shortcuts = {
          {
            name = "textify",
            key = "<leader>as",
            desc = "fix text with AI",
            use_context = true,
            prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
              ]],
            modes = { "v" },
            strip_function = nil,
          },
          {
            name = "gitcommit",
            key = "<leader>ag",
            desc = "generate git commit message",
            use_context = false,
            prompt = function()
              return [[
                  Using the following git diff generate a consise and
                  clear git commit message, with a short title summary
                  that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
            end,
            modes = { "n" },
            strip_function = nil,
          },
        },
      })
    end,
  },
}

return plugins
