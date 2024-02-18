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
    "folke/lsp-colors.nvim", lazy = false
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false
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
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },


  {
    "MunifTanjim/nui.nvim",
  },

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
            ["select_up"] = "<C-k>",
            ["select_down"] = "<C-j>",
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
