---------------------------------------------------------------------------
-- VimScript plugins config
---------------------------------------------------------------------------
-- visual-multi
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor At Pos"]   = '<C-RIGHT>' ]])

-- emmet-vim
vim.g.user_emmet_leader_key = ','

-- tagbar
vim.cmd([[ let g:tagbar_width = '30' ]])

---------------------------------------------------------------------------
-- Lua plugins config
---------------------------------------------------------------------------
local M = {}

M.navbuddy = {
  lsp = {
    auto_attach = true
  },
  window = {
    -- size = "80%",    -- Or table format example: { height = "40%", width = "100%"}
  },
}

M.jabs = {
  position = { 'center', 'center' }, -- position = {'<position_x>', '<position_y>'} | <position_x> left, center, right,

  relative = 'editor',               -- win, editor, cursor. Default win
  clip_popup_size = false,           -- clips the popup size to the win (or editor) size. Default true

  width = 80,                        -- default 50
  height = 20,                       -- default 10
  border = 'single',                 -- none, single, double, rounded, solid, shadow, (or an array or chars). Default shadow

  offset = {                         -- window position offset
    top = 2,                         -- default 0
    bottom = 2,                      -- default 0
    left = 2,                        -- default 0
    right = 2,                       -- default 0
  },

  sort_mru = true,                -- Sort buffers by most recently used (true or false). Default false
  split_filename = true,          -- Split filename into separate components for name and path. Default false
  split_filename_path_width = 20, -- If split_filename is true, how wide the column for the path is supposed to be, Default 0 (don't show path)

  -- Options for preview window
  preview_position = 'top', -- top, bottom, left, right. Default top
  preview = {
    width = 85,             -- default 70
    height = 70,            -- default 30
    border = 'single',      -- none, single, double, rounded, solid, shadow, (or an array or chars). Default double
  },

  -- Default highlights (must be a valid :highlight)
  highlight = {
    current = "Title",       -- default StatusLine
    hidden = "StatusLineNC", -- default ModeMsg
    split = "WarningMsg",    -- default StatusLine
    alternate = "StatusLine" -- default WarningMsg
  },

  -- Default symbols
  symbols = {
    current = "C",         -- default 
    split = "S",           -- default 
    alternate = "A",       -- default 
    hidden = "H",          -- default ﬘
    locked = "L",          -- default 
    ro = "R",              -- default 
    edited = "E",          -- default 
    terminal = "T",        -- default 
    default_file = "D",    -- Filetype icon if not present in nvim-web-devicons. Default 
    terminal_symbol = ">_" -- Filetype icon for a terminal split. Default 
  },

  -- Keymaps
  keymap = {
    close = "dd",  -- Close buffer. Default D
    jump = "<CR>", -- Jump to buffer. Default <cr>
    h_split = "h", -- Horizontally split buffer. Default s
    v_split = "v", -- Vertically split buffer. Default v
    preview = "p", -- Open buffer preview. Default P
  },

  -- Whether to use nvim-web-devicons next to filenames
  use_devicons = false -- true or false. Default true
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "json",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- shell stuff
    "shfmt",

    --python
    "pyright",
    "python-lsp-server",
    "mypy",
  },
}

-- git support in nvimtree
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

M.nvimtree = {
  on_attach = my_on_attach,
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}


return M
