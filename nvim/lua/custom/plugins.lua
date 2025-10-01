local plugins = {
  -------------------------------------------
  -- 디버거 플러그인
  -------------------------------------------
  -- nvim-dap (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" }, -- 필수
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

      -- JavaScript / TypeScript Config
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
  -- 편집 보조 플러그인
  -------------------------------------------
  -- windsuf.vim (AI 자동완성, Codeium 기반) :Codeium Auth
  {
    "Exafunction/windsurf.vim",
    event = "BufReadPost",
  },

  -- vim-visual-multi (멀티 커서)
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
  },

  -- vim-illuminate (단어 하이라이트)
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
  },

  -- nvim-lastplace (커서 마지막 위치 저장, lua 포트 버전)
  {
    "ethanholz/nvim-lastplace",
    event = "BufReadPost",
    config = function()
      require("nvim-lastplace").setup {}
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

  -- nvim-cmp (자동완성)
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

  -- luasnip + friendly-snippets (스니펫)
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -------------------------------------------
  -- 문법 / 포맷팅 플러그인
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
          html = { "prettier" },
          css = { "prettier" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          java = { "google-java-format" },
          sh = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_fallback = true,
        },
      }
    end,
  },

  -- vim-pug (pug 문법)
  {
    "digitaltoad/vim-pug",
    ft = "pug",
  },

  -- emmet-vim (emmet 문법)
  {
    "mattn/emmet-vim",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -------------------------------------------
  -- 탐색 / 사이드 바 플러그인
  -------------------------------------------

  -- fzf-lua (빠른 탐색기)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.nvim" },
    cmd = "FzfLua",
    config = function()
      require("fzf-lua").setup {
        keymap = {
          builtin = {
            ["<C-u>"] = "preview-page-up",
            ["<C-d>"] = "preview-page-down",
          },
        },
      }
    end,
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

  -- tagbar (코드 태그 보기)
  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
  },

  -- JABS.nvim (버퍼 리스트)
  {
    "matbme/JABS.nvim",
    cmd = "JABSOpen",
    config = function()
      require("jabs").setup {
        position = { "center", "center" },
        width = 80,
        height = 20,
        border = "single",
        sort_mru = true,
        preview = {
          width = 90,
          height = 40,
          border = "single",
        },
        symbols = {
          current = "C",
          alternate = "A",
          ro = "R",
        },
        keymap = {
          close = "dd",
          preview = "p",
        },
      }
    end,
  },

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

  -- barbecue.nvim (상단 breadcrumb)
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.nvim",
    },
    event = "BufReadPost",
    opts = {
      attach_navic = true,
      show_dirname = true,
      show_basename = true,
      show_modified = true,
      create_autocmd = true,
    },
    config = function(_, opts)
      local barbecue = require "barbecue"
      barbecue.setup(opts)
      local navic = require "nvim-navic"
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          vim.defer_fn(function()
            if navic.is_available() then
              pcall(navic.attach)
            end
          end, 100)
        end,
      })
    end,
  },
}

return plugins
