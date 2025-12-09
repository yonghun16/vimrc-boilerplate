local plugins = {
  -------------------------------------------
  -- AI
  -------------------------------------------
  -- windsuf.vim (AI 자동완성, Codeium 기반) :Codeium Auth
  {
    "Exafunction/windsurf.vim",
    event = { "InsertEnter", "BufReadPost" },
  },

  -------------------------------------------
  -- Coding
  -------------------------------------------
  -- LuaSnip (스니펫)
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
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

  -- emmet-vim (emmet)
  {
    "mattn/emmet-vim",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- vim-pug (pug)
  {
    "digitaltoad/vim-pug",
    ft = "pug",
  },

  -------------------------------------------
  -- Debugging
  -------------------------------------------
  -- nvim-dap (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dapui = require "dapui"
          dapui.setup()

          local dap = require "dap"
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      local dap = require "dap"

      -- Python Config
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          name = "Launch file",
          type = "python",
          request = "launch",
          program = "${file}",
          pythonPath = function()
            local venv = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then
              return venv
            end
            return "python"
          end,
        },
      }

      -- JS / TS Config
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      local js_ts_config = {
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
        {
          name = "Attach to process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      dap.configurations.javascript = js_ts_config
      dap.configurations.typescript = js_ts_config
      dap.configurations.javascriptreact = js_ts_config
      dap.configurations.typescriptreact = js_ts_config
    end,
  },

  -------------------------------------------
  -- Editor
  -------------------------------------------
  -- fzf-lua (빠른 탐색기)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.nvim" },
    cmd = "FzfLua",
    config = function()
      local actions = require "fzf-lua.actions"
      require("fzf-lua").setup {
        keymap = {
          builtin = {
            ["<C-u>"] = "preview-page-up",
            ["<C-d>"] = "preview-page-down",
          },
        },
        buffers = {
          sort_lastused = true,
          include_current = true,
          actions = {
            ["ctrl-D"] = { fn = actions.buf_del, reload = true },
          },
        },
      }
    end,
  },

  -- nvim-lastplace (커서 마지막 위치 저장, lua 포트 버전)
  {
    "ethanholz/nvim-lastplace",
    event = "BufReadPost",
    config = function()
      require("nvim-lastplace").setup {}
    end,
  },

  -- vim-illuminate (단어 하이라이트)
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- vim-visual-multi (멀티 커서)
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  -------------------------------------------
  -- Formatting & Linting & Treesitter
  -------------------------------------------
  -- conform.nvim (포맷터)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          java = { "google-java-format" },
          html = { "prettier" },
          css = { "prettier" },
          sh = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_fallback = true,
        },
      }
    end,
  },

  -- nvim-lint (코드 린팅)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        python = { "flake8" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        c = { "cpplint" },
        cpp = { "cpplint" },
        java = { "checkstyle" },
        html = { "htmlhint" },
        css = { "stylelint" },
        sh = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = "*",
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- nvim-treesitter (문법 강조 및 구문 분석)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "c",
          "cpp",
          "java",
          "json",
          "jsdoc",
          "pug",
          "html",
          "css",
          "vim",
          "vimdoc",
          "query",
        },

        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },

  -------------------------------------------
  -- UI
  -------------------------------------------
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

  -------------------------------------------
  -- Util
  -------------------------------------------
  -- toggleterm.nvim (터미널)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup {
        shade_terminals = true,
        start_in_insert = true,
        direction = "float",
      }
    end,
  },

  -- which-key.nvim (키맵 도움말)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers = { { "<leader>", mode = { "n", "v" } } },
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
  },
}

return plugins
