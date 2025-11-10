# vimrc-boilerplate 
<div align="center">
  <img src="https://raw.githubusercontent.com/yonghun16/yonghun16/refs/heads/main/images/nvim_preview.png" width=800px />
</div>


## 1. Neovim(Nvchad)
> Nvchad : https://nvchad.com

### 1) Install
#### 🟢 Install
```shell
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
  - Run `:MasonInstallAll` command after lazy.nvim finishes downloading plugins.
  - Delete the `.git` folder from nvim folder.
  - Learn customization of ui & base46 from `:h nvui`.

#### 🟢 Update
  - Run `:Lazy sync`

#### 🟢 Uninstall
```shell
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

### 2) init setting
#### 🔵 Config file copy
```shell
git clone https://github.com/yonghun16/vimrc-boilerplate ~
cd ~/vimrc-boilerplate
cp -r nvim ~/.config
```

#### 🔵 ~/.config/nvim/init.lua 수정
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

#### 🔵 Manual plugins setting
- package (shell)
  ```bash
  brew install fd universal-ctags luarocks fzf ripgrep
  pip3 install debugpy
  ```
- Mason language server (vim mode)
  ```vim
  MasonInstall stylua prettier tailwindcss-language-server typescript-language-server js-debug-adapter css-lsp html-lsp black pyright clang-format clangd google-java-format jdtls sqlls
  ```
- Tree-sitter parser (vim mode)
  ```vim
  TSInstall javascript typescript html css python lua c cpp java json jsdoc pug
  ```
  
### 3) Input & Hangul setting
#### 🟡 Karabiner
> karabiner : https://karabiner-elements.pqrs.org/
  - preset file
    - `karabiner-korean.json`
    - `karabiner-vim.json`
  - [Complex Modifications] → [Add your own rule]
  - [Devices] → 외장키보드 사용 시 추가

#### 🟡 Gureum
> Gureum : https://gureum.io/
  - Config
    - 로마자로만 바꾸기 단축키 : `^C` (ESC 단축키)
    - 오른쪽 키로 언어 전환 : `Command` (한/영 키 대체)
    - 한자 및 이모지 바꾸기 : `control + shift + spacebar`
    - 한글 입력기 설정 : 모아치기, MS윈도호환, JDK호환, vi모드 
  - Mac 입력 소스 설정
    - [설정] → [키보드] → [키보드 단축키] → [입력소스]
    - 이전 입력 소스 선택 : `contrl + shift + spacebar`
    - 입력 메뉴에서 다음 소스 선택 : 체크해제
  - Detail : [gureum_setting.png](https://github.com/yonghun16/vimrc-boilerplate/blob/master/gureum/gureum_setting.png), [keyboard_inputsource_setting.png](https://github.com/yonghun16/vimrc-boilerplate/blob/master/gureum/keyboard_inputsource_setting.png?raw=true)


## 2. Other App Settings (for nvim)
### 1) Oh-my-zsh
> oh-my-zsh : https://ohmyz.sh/
  - install
    ```shell
    $ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ```
  - zsh-autosuggestions
    ```shell
    $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
    - ~/.zshrc 에 플러그인 경로를 추가.
      ```shell
      plugins=( 
          # other plugins...
          zsh-autosuggestions
      )
      ```
  - Syntax Highlighter
    ```shell
    $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```
    - ~/.zshrc 에 아래 플러그인 경로를 추가.
      ```shell
      plugins=( 
          # other plugins...
          zsh-autosuggestions
      )
      ```
  - Neofetch
    ```shell
    $ brew install neofetch
    ```

### 2) WezTerm
> WezTerm : https://wezterm.org/
  - install
    ```shell
    brew install --cask wezterm
    ```
  - setting : `.wezterm.lua`
    - ```shell
      cp .wezterm.lua ~/.wezterm.lua
      ```

### 3) tmux 
> tmux : https://github.com/tmux/tmux/wiki
  - install
  ```bash
  brew install tmux
  ```
  - setting : `.tmux.conf`
    - ```shell
      cp .tmux.conf ~/.tmux.conf
      ```
  - 파일을 수정한 뒤 tmux 안에서:
    - ```shell
      tmux source-file ~/.tmux.conf
      ```


## 3. Plugins info
#### 디버거 플러그인
  - nvim-dap (Debug Adapter Protocol)
  - js-debug-adapter (JS/TS Debuger)
  - debugpy (Pythion Debuger)

#### 편집 보조 플러그인
  - vim-windsurf (windsurf AI)
  - vim-visual-multi (멀티 커서)
  - vim-illuminate (단어 하이라이팅)
  - nvim-lastplace (커서 마지막 위치 저장)

#### 문법 플러그인
  - conform.nvim (코드 포맷팅)
  - vim-pug (pug문법 사용)
  - emmet-vim (emmet 문법 사용)

#### 탐색 / 사이드바 플러그인
  - fzf-lua (fzf 파일 탐색기 보기)
  - outline (코드 아웃라인 보기)
  - tagbar (코드 태그 보기)
  - JABS.nvim (버퍼 리스트 보기)
  - toggleterm.nvim (플로팅 터미널 보기)
  - barbecue.nvim (상단에 파일 및 요소 정보 표시)
