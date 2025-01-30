# vimrc-boilerplate 

<div align="center">
  <img src="https://raw.githubusercontent.com/yonghun16/yonghun16/main/images/nvim_preview.png" width=800px />
</div>

## 1. Nvchad
- Nvchad : https://nvchad.com

### Install
```shell
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
- Run <code>:MasonInstallAll</code> command after lazy.nvim finishes downloading plugins.
- Delete the <code>.git</code> folder from nvim folder.
- Learn customization of ui & base46 from <code>:h nvui</code>.

### Update
- Run <code>:Lazy sync</code>

### Config
```shell
cp -r nvim ~/.config
```

### Uninstall
```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```


## 2. Plugins 
- **문법 플러그인**
  - [formatter.nvim](https://github.com/mhartington/formatter.nvim) (코드 포맷팅)
  - [vim-codeium](https://github.com/Exafunction/codeium.vim) (AI 자동완성)
  - [vim-pug](https://github.com/digitaltoad/vim-pug) (pug문법 사용)
  - [emmet-vim](https://github.com/mattn/emmet-vim) (emmet 문법 사용)
- **편집 플러그인**
  - [vim-illuminate](https://github.com/RRethy/vim-illuminate) (단어 하이라이트)
  - [vim-lastplace](https://github.com/farmergreg/vim-lastplace) (커서 마지막 위치 저장)
  - [vim-visual-multi](https://github.com/mg979/vim-visual-multi) (멀티 커서)
- **사이드바 플러그인**
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua) (fzf 파일 탐색기 보기)
  - [nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy) (코드 네비게이터 보기)
  - [symbols-outline](https://github.com/simrat39/symbols-outline.nvim) (코드 아웃라인 보기)
  - [tagbar](https://github.com/preservim/tagbar) (코드 태그 보기)
  - [JABS.nvim](https://github.com/matbme/JABS.nvim) (버퍼 리스트 보기)
  - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) (터미널 보기)
- **상태 표시 플러그인**
  - [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) (상단 요소 정보 표시)
- **의존성 플러그인**
  - [nvim-navic](https://github.com/SmiteshP/nvim-navic) (for barbecue, navbuddy)
  - [nui.nvim](https://github.com/MunifTanjim/nui.nvim) (for navbuddy)

## 3. Other settings

### BetterTouchTool
- BetterTouchTool : https://folivora.ai/ 
- config file : yonghun16_btt.bttpreset

### Iterm2
- Iterm2 : https://iterm2.com/
- config file : yonghun16_iterm.json
