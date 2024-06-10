# vimrc-boilerplate 

<div align="center">
  <img src="https://raw.githubusercontent.com/yonghun16/yonghun16/main/images/nvim_preview.png" width=800px />
</div>

## 1. Nvchad
- Nvchad : https://nvchad.com

### Install
```shell
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
```
- Run :MasonInstallAll command after lazy.nvim finishes downloading plugins.
- Delete the .git folder from nvim folder.

### Update
- RUN :Lazy  and sync command

### Config
```shell
cp -r nvim ~/.config
```

### Uninstall
```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```


## 2. Plugins 
- 문법 관련 플러그인
  - vim-codeium (AI 자동완성)
  - vim-illuminate (단어 하이라이트)
  - vim-lastplace (커서 마지막 위치 저장)
  - vim-pug (pug문법 사용)
  - emmet-vim (emmet 문법 사용)
- 사이드 바 플러그인
  - fzf-lua (fzf 파일 탐색기 보기)
  - symbols-outline (코드 아웃라인 보기)
  - tagbar (코드 태그 보기)
  - JABS.nvim (버퍼 리스트 보기)
  - nvim-navbuddy (코드 네비게이터 보기)
  - toggleterm.nvim (터미널 보기)
- 상태 표시 플러그인
  - barbecue (상단 요소 정보 표시)
- 의존성 플러그인
  - nvim-navic (for barbecue, navbuddy)
  - nui.nvim (for navbuddy)


## 3. Other settings

### BetterTouchTool
- BetterTouchTool : https://folivora.ai/ 
- config file : Default.bttpreset

### Iterm2
- Iterm2 : https://iterm2.com/
- config file : Default.json
