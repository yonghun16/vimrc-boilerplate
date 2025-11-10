# Legacy setting files


## 1. Neovim(no framwork)
- config file setting
  ```shell
  $ cp -rf nvim/ ~/.config/nvim 
  ```

## 2. Lunarvim
> Lunarvim : https://www.lunarvim.org
  - config file setting
    ```shell
    $ cp lvim/.config ~/.config/lvim 
    ```
  - Updating LunarVim : `:LvimUpdate`


## 3. BetterTouchTool
> BetterTouchTool : https://folivora.ai/
  - preset file : `btt_for_vim.bttpreset`
  - [Configuration] → [preset] → [import]

## 4. iTerm2
> iterm2 : https://iterm2.com/
  - json config file : `iterm2-vim.json`
    - [setting] → [Profiles] → [Others Actions] → [Import JSON Profiles]
  - Shell Integration
    ```shell
    $ curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
    ```

## 5. Wrap
> wrap : https://www.warp.dev/
  - theme : `base16_solarized_dark.yaml`
    - ```shell
      mkdir -p $HOME/.warp
      cd $HOME/.warp/
      git clone https://github.com/warpdotdev/themes.git
      cp ~/vimrc-boilerplate/base16_solarized_dark.yaml ~/.warp/themes/base16
      ```
  - Ctrl+Tab behavior : [settings] → [settings] → Ctrl+Tab behavior = circle most recent session
  - Apperance : [wrap_apperance.png](https://github.com/yonghun16/vimrc-boilerplate/blob/master/warp/wrap_apperance.png?raw=true)
    - input type : classic

## 6. Neovide
> Neovide : https://neovide.dev/
  - install
  ```bash
  brew install neovide
  ```

## 6. Cursor
> Cursor : https://www.cursor.com/
  - Vim Mode 설정 : 확장 → Vim emulation install 
  - Vimscript file : (Commend ,) → (vim search) → Vim>vimrc:Path → `cursor-vimkeymap.vim` 적용
  - Key binding file : `cp cursor-keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json`
  - settings : (Commend ,) → 설정열기(JSON) → 여기에 `cursor-seetings.json` 내용 추가



