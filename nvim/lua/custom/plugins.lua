local overrides = require("custom.configs.overrides")

---------------------------------------------------------------------------
-- plugin keymapping options
---------------------------------------------------------------------------
-- nvim-tree
local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- OR use all default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  vim.keymap.del('n', 's', { buffer = bufnr })

  -- add your mappings
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  ---
end

-- visual-multi
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor At Pos"]   = '<C-RIGHT>' ]])

-- emmet-vim
vim.g.user_emmet_leader_key = '<C-,>'

-- tagbar
vim.cmd([[ let g:tagbar_width = '30' ]])

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
---@type NvPluginSpec[]
local plugins = {
  -- JABS.nvim
  {
    "matbme/JABS.nvim",
    config = function()
      require 'jabs'.setup {
        -- Options for the main window
        position = { 'center', 'top' }, -- position = {'<position_x>', '<position_y>'} | <position_x> left, center, right,

        relative = 'editor', -- win, editor, cursor. Default win
        clip_popup_size = false, -- clips the popup size to the win (or editor) size. Default true

        width = 80,          -- default 50
        height = 20,         -- default 10
        border = 'single',   -- none, single, double, rounded, solid, shadow, (or an array or chars). Default shadow

        offset = {           -- window position offset
          top = 2,           -- default 0
          bottom = 2,        -- default 0
          left = 2,          -- default 0
          right = 2,         -- default 0
        },

        sort_mru = true,            -- Sort buffers by most recently used (true or false). Default false
        split_filename = true,      -- Split filename into separate components for name and path. Default false
        split_filename_path_width = 20, -- If split_filename is true, how wide the column for the path is supposed to be, Default 0 (don't show path)

        -- Options for preview window
        preview_position = 'left', -- top, bottom, left, right. Default top
        preview = {
          width = 40,          -- default 70
          height = 60,         -- default 30
          border = 'single',   -- none, single, double, rounded, solid, shadow, (or an array or chars). Default double
        },

        -- Default highlights (must be a valid :highlight)
        highlight = {
          current = "Title",     -- default StatusLine
          hidden = "StatusLineNC", -- default ModeMsg
          split = "WarningMsg",  -- default StatusLine
          alternate = "StatusLine" -- default WarningMsg
        },

        -- Default symbols
        symbols = {
          current = "C",       -- default 
          split = "S",         -- default 
          alternate = "A",     -- default 
          hidden = "H",        -- default ﬘
          locked = "L",        -- default 
          ro = "R",            -- default 
          edited = "E",        -- default 
          terminal = "T",      -- default 
          default_file = "D",  -- Filetype icon if not present in nvim-web-devicons. Default 
          terminal_symbol = ">_" -- Filetype icon for a terminal split. Default 
        },

        -- Keymaps
        keymap = {
          close = "dd", -- Close buffer. Default D
          jump = "<CR>", -- Jump to buffer. Default <cr>
          h_split = "h",  -- Horizontally split buffer. Default s
          v_split = "v",  -- Vertically split buffer. Default v
          preview = "p",  -- Open buffer preview. Default P
        },

        -- Whether to use nvim-web-devicons next to filenames
        use_devicons = false -- true or false. Default true
      }
    end,
    cmd = "JABSOpen",
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
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

  -- vim-codeium
  {
    "Exafunction/codeium.vim", -- :Codeium Auth
    event = "VimEnter"
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
    "preservim/tagbar", -- https://github.com/universal-ctags/ctags
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

  -- nvim-navbuddy
  {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
    },
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

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
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

  -- -- nvim-treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = overrides.treesitter,
  -- },

  -- nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        on_attach = my_on_attach,
      })
    end
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
