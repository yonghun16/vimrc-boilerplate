# ==========================================
# 1. Zinit 설치 및 초기화 (가장 먼저 실행)
# ==========================================
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZINIT%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ==========================================
# 2. Powerlevel10k 테마 설정 (예쁜 터미널 복구)
# ==========================================
# p10k 테마를 가장 먼저 로딩해야 합니다.
zinit ice depth=1
zinit light romkatv/powerlevel10k

# 기존 p10k 설정 파일이 있다면 로드
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ==========================================
# 3. Oh My Zsh 핵심 라이브러리 (기능만 가져오기)
# ==========================================
zinit snippet OMZL::functions.zsh      # 필수 함수
zinit snippet OMZL::git.zsh            # git 단축키 (gst, gco 등)
zinit snippet OMZL::history.zsh        # 히스토리 설정
zinit snippet OMZL::completion.zsh     # 자동완성 강화
zinit snippet OMZL::key-bindings.zsh   # 키 바인딩
zinit snippet OMZL::termsupport.zsh    # 터미널 지원
zinit snippet OMZL::theme-and-appearance.zsh # 테마
zinit snippet OMZL::directories.zsh          # 파일과 폴더 관리


# ==========================================
# 4. 플러그인 (속도 향상 적용)
# ==========================================
# 자동완성 (회색 글씨 추천)
zinit light zsh-users/zsh-autosuggestions

# 구문 강조 (명령어 색깔 입히기) - Turbo Mode 적용
zinit ice wait'0a' lucid atinit"ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)"
zinit light zsh-users/zsh-syntax-highlighting


# ==========================================
# 5. 사용자 환경 변수 및 설정 (PATH 등)
# ==========================================
# Homebrew Path
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Python / Pip
export PATH="/Users/song-yonghun/Library/Python/3.9/lib/python/site-packages:$PATH"
export PATH="/Users/song-yonghun/.local/bin:$PATH"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
export PATH="$JAVA_HOME/bin:/opt/homebrew/opt/openjdk/bin:$PATH"

# User Options
setopt promptsubst
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000


# ==========================================
# 6. 사용자 Aliases
# ==========================================
alias swap="rm -rf ~/.local/state/nvim/swap/*"
alias rm="trash"
alias cp="cp -i"
alias mv='mv -i'
alias vi="nvim"
alias python="python3"
alias pip="pip3"
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons -l --group-directories-first --git"
alias tree="eza --icons --tree"

# Neofetch (터미널 켤 때 정보 표시)
neofetch


# ==========================================
# 7. 외부 도구 로딩 (NVM, SDKMAN, PNPM)
# ==========================================
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PNPM
export PNPM_HOME="/Users/song-yonghun/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# SDKMAN (파일 맨 끝 권장)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# iTerm2 Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# OpenAI Key (보안을 위해 실제 키는 파일에서 관리하거나 주의하세요!)
# export OPENAI_API_KEY='YOUR_KEY_HERE'
