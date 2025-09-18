## 1.  ~/.config/nvim/init.lua 수정사항

```lua
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = ","   -- 1. <leader> 키 설정

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
  { import = "custom.plugins" },  --2. custom.plugins 경로 추가
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "custom.options"      -- 3. custom.options 경로 수정
require "custom.autocmds"     -- 4. custom.autocmds 경로 수정
require "custom.lspconfig"    -- 5. custom.lspconfig 경로 수정

vim.schedule(function()
  require "custom.mappings"   -- 6. custom.mappings 경로 수정
end)
```


## 2. 수동 패키지 설치 사항
```bash
brew install fd universal-ctags luarocks fzf ripgrep
```
```vim
MasonInstall black pyright clang-format clangd google-java-format jdtls sqlls
```
```vim
MasonInstall stylua prettier tailwindcss-language-server typescript-language-server css-lsp html-lsp
```
```vim
TSInstall javascript typescript html css python lua c cpp java json jsdoc pug
```
