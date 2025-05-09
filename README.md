# vimrc-boilerplate 
<div align="center">
  <img src="https://raw.githubusercontent.com/yonghun16/yonghun16/refs/heads/main/images/nvim_preview.png" width=800px />
</div>


## 1. Nvchad
Nvchad : https://nvchad.com

#### Install
```shell
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
  - Run <code>:MasonInstallAll</code> command after lazy.nvim finishes downloading plugins.
  - Delete the <code>.git</code> folder from nvim folder.
  - Learn customization of ui & base46 from <code>:h nvui</code>.
#### Update
  - Run <code>:Lazy sync</code>
#### Uninstall
```shell
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```
#### Setting
```shell
git clone https://github.com/yonghun16/vimrc-boilerplate ~
cd ~/vimrc-boilerplate
cp -r nvim ~/.config
```

## 2. Other App Settings
#### iTerm2
  - iterm2 : https://iterm2.com/
  - json config file : <code>iterm_for_vim.json</code>
  - [setting] → [Profiles] → [Others Actions] → [Import JSON Profiles]
#### Wrap
  - wrap : https://www.warp.dev/
  - theme file : <code>base16_solarized_dark.yaml</code>
  - ```shell
    mkdir -p $HOME/.warp
    cd $HOME/.warp/
    git clone https://github.com/warpdotdev/themes.git
    cp ~/vimrc-boilerplate/vimbase16_solarized_dark.yaml ~/.warp/themes/base16
    ```
#### Cursor
  - Cursor : https://www.cursor.com/
  - Vimscript file : <code>keymap_for_cursorAI.vim</code>
  - Vim emulation install → (Commend ,) → (vim search) → Vim>vimrc:Path
#### BetterTouchTool
  - BetterTouchTool : https://folivora.ai/
  - preset file : <code>btt_for_vim.bttpreset</code>
  - [Configuration] → [preset] → [import]
#### Gureum
  - Gureum : https://gureum.io/
  - Config
    - 로마자로만 바꾸기 단축키 : ^C (ESC 단축키)
    - 오른쪽 키로 언어 전환 : Command
    - 한글 입력기 설정 : 모아치기, MS윈도호환, JDK호환, vi모드, 

## 3. Plugins 
#### 편집 보조 플러그인
  - [vim-windserf](https://github.com/Exafunction/windserf.vim) (AI 자동완성)
  - [vim-visual-multi](https://github.com/mg979/vim-visual-multi) (멀티 커서)
  - [vim-illuminate](https://github.com/RRethy/vim-illuminate) (단어 하이라이트)
  - [vim-lastplace](https://github.com/farmergreg/vim-lastplace) (커서 마지막 위치 저장)
#### 문법 플러그인
  - [formatter.nvim](https://github.com/mhartington/formatter.nvim) (코드 포맷팅)
  - [vim-snippets](https://github.com/honza/vim-snippets) (코드 스니펫)
  - [vim-pug](https://github.com/digitaltoad/vim-pug) (pug문법 사용)
  - [emmet-vim](https://github.com/mattn/emmet-vim) (emmet 문법 사용)
#### 사이드바 플러그인
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua) (fzf 파일 탐색기 보기)
  - [nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy) (코드 네비게이터 보기)
  - [symbols-outline](https://github.com/simrat39/symbols-outline.nvim) (코드 아웃라인 보기)
  - [tagbar](https://github.com/preservim/tagbar) (코드 태그 보기)
  - [JABS.nvim](https://github.com/matbme/JABS.nvim) (버퍼 리스트 보기)
  - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) (터미널 보기)
  - [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) (상단 요소 정보 표시)
#### 의존성 플러그인
  - [nvim-navic](https://github.com/SmiteshP/nvim-navic) (for barbecue, navbuddy)
  - [nui.nvim](https://github.com/MunifTanjim/nui.nvim) (for navbuddy)

