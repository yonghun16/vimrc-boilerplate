"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************


"*****************************************************************************
"" Plug install packages
"*****************************************************************************


"*****************************************************************************
"" Custom bundles
"*****************************************************************************
""sidebar
Plug 'jlanzarotta/bufexplorer'
Plug 'majutsushi/tagbar'    "$sudo apt-get install ctags

""syntax
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'roxma/nvim-yarp'
Plug 'preservim/nerdcommenter'

""etc
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'tomtom/tlib_vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'} 
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
Plug 'mhinz/vim-startify'
Plug 'yegappan/mru'
Plug 'ryanoasis/vim-devicons'

""language
Plug 'ap/vim-css-color'
Plug 'eslint/eslint'

call plug#end()
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************
" Encoding 
set enc=utf-8               " editor의 인코딩
set tenc=utf-8              " terminal의 인코딩
set fencs=ucs-bom,utf-8,cp949,latin1,euc-kr
set nobomb                  " Byte Order Mark 사용하지 않음 (unix와의 인코딩 해결 문제)
let $LANG = 'ko_KR.UTF-8'   " vim의 언어
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set fileformats=unix,dos,mac

" Syntax
syntax on               " 구문 강조
syntax enable           " 파일 형식에 따른 문법 하이라이팅 켜기
filet plugin indent on  " 파일의 종류를 자동으로 인식
set wrap                " 자동 줄바꿈 사용
set magic               " 모든 정규식 문자를 사용 할 수 있게함
set sc                  " 완성중인 명령을 보이게함
set wmnu                " 자동완성 가능 목록을 보여줌
"set sm                 " 새로 추가된 괄호 짝 보여주기
"set mps+=<:>           " 괄호짝 찾기에서 <> 도 찾도록 추가하기 (HTML 작업시 유용)

" Indent & tab
set backspace=indent,eol,start
set autoindent          " 자동 들여쓰기
set tabstop=4           " 탭 크기 4로 하기
set softtabstop=4       " 탭 크기 4로 하기
set shiftwidth=4        " 들여쓰기를 4칸으로 
set expandtab           " 탭을 공백으로 바꿈
set smarttab            " 스마트 탭
set smartindent         " 스마트 들여쓰기

" Searching
set hlsearch            " 검색어 하이라이트 
set incsearch           " 검색 시 점진적으로 검색.
set ignorecase          " 검색 시 대소문자 구별 안함.
set go+=c               " '간단한 선택' 다이얼로그가 새 창에서 뜨지 않도록...
set smartcase           " 스마트 대소문자 구별 기능 사용

" Etc
set rnu                 " 행 라인 표시
set ruler               " 화면 하단에 커서 위치 표시
set cursorline          " 커서라인 하이라이팅
set bs=2                " 백스페이스 사용
set hi=100              " 명령어 기록 갯수 100개
set sel=exclusive       " 비주얼 모드에서의 동작 설정
set pastetoggle=<Ins>   " <Ins>키로 paste 사용
set ls=2                " 항상 status 라인을 표시
set uc=10               " 몇 글자를 입력받으면 swap 파일을 쓸 것인지 설정
set belloff=all         " Bell off


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
set termguicolors       "터미널에서 24bit컬러(GUI컬러) 지원하기
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:rehash256 = 1


"*****************************************************************************
"" Abbreviations
"*****************************************************************************
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

ab fucntion function
ab calss class
ab functio function
ab dunction function
ab defalut default
ab defautl default
ab functuin function
ab dunction function
ab functuin function
ab functopn function
ab fumction function
ab classs class
ab forarch foreach
ab inser insert
ab insertt insert
ab quewrty query
ab ovject object
ab objectr object
ab prit print
ab printnl println
ab prnitln println
ab fales false
ab treu true
ab teur true
ab nulll null
ab retrun return
ab retunr return
ab bcakground background
ab herf href


"*****************************************************************************
"" Commands
"*****************************************************************************
" 컴파일 단축키
function! Compile() range
    execute ':w'
    if &filetype =="c"
        if has("unix")
            execute ':! gcc -o ~/bin/%< %<.c'
            execute ':! ~/bin/%<'
        endif
    elseif &filetype =="cpp"
        if has("unix")
            execute ':! g++ -o ~/bin/%< %<.cpp'
            execute ':! ~/bin/%<'
        endif
    elseif &filetype == "java"
        if has("unix")
            execute ':! javac -encoding utf-8 -d ~/bin %<.java'
            execute ':! java -cp ~/bin %<'
        endif
    elseif &filetype =="python"
        if has("unix")
            execute ':! cp ./%<.py ~/bin'
            execute ':! python3 ./%<.py'
        endif
    elseif &filetype =="javascript"
        if has("unix")
            execute ':! cp ./%<.js ~/bin'
            execute ':! node ./%<.js'
        endif
    endif
endfunction

" 오토 하이라이팅 토글
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=1
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

"탭 토글(mysql쿼리문에서 유용)
function! Tab_toggle()
    let @/ = ''
    if exists('#tab_toggle')
        au!
        set expandtab
        augroup! tab_toggle
        echo 'Tab = 4 or 2 spaces'
        return 0
    else
        augroup tab_toggle
            au!
            set noexpandtab
        augroup end
        echo 'Tab = block'
        return 1
    endif
endfunction

"행번호 지우기 토글(putty에서 복사 할 때 유용)
function! Numberline_remove_toggle()
    execute ':IndentLinesToggle'
    if(&number==1)
        set nonumber
        set norelativenumber
        let g:indentLine_enabled = 0
    else
        set number
        set relativenumber
        let g:indentLine_enabled = 1
    endif
endfunction

"행번호 변경 토글
function! Numberline_change_toggle()
    set number
    if(g:indentLine_enabled == 0)
        let g:indentLine_enabled = 1
        execute ':IndentLinesToggle'
    endif
    if(&relativenumber==1)
        set norelativenumber!
    else
        set relativenumber
    endif
endfunction


"*****************************************************************************
"" Plug setting
"*****************************************************************************
" NERD Tree
let NERDTreeWinPos = "right"			
set autochdir
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" MRU
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix"

" deoplete
let g:deoplete#enable_at_startup = 1

" ale
let g:ale_linters = {}

" Tag bar
let g:tagbar_left = 1				
let g:tagbar_width = 30	   
let g:tagbar_sort = 0               " 파일 안의 태그 순서대로 태그정렬
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1

" Ultisnips 
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"

" Syntastic 
let g:syntastic_check_on_open=1     " 시작하자마자 구문을 체크함.

" FuzzyFinder
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|swp|class|pyc|orig)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

" gitgutter
let g:gitgutter_grep_command = 'grep -e'
let g:gitgutter_async = 0
let g:gitgutter_enabled = 0
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_avoid_cmd_prompt_on_windows = 0

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '│'
let g:indentLine_faster = 1

" emmet-vim
let g:user_emmet_leader_key=','

" vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline_left_sep          = '▶'
    let g:airline_left_alt_sep      = '»'
    let g:airline_right_sep         = '◀'
    let g:airline_right_alt_sep     = '«'
    let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
    let g:airline#extensions#readonly#symbol   = '⊘'
    let g:airline#extensions#linecolumn#prefix = '¶'
    let g:airline#extensions#paste#symbol      = 'ρ'
    let g:airline_symbols.linenr    = '␊'
    let g:airline_symbols.branch    = '⎇'
    let g:airline_symbols.paste     = 'ρ'
    let g:airline_symbols.paste     = 'Þ'
    let g:airline_symbols.paste     = '∥'
    let g:airline_symbols.whitespace = 'Ξ'
else
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''

    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif


"*****************************************************************************
"" Functions
"*****************************************************************************


"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************


"*****************************************************************************
"" Mappings
"*****************************************************************************
"----------------------------------------------------------------------
"" Basic mapping
"----------------------------------------------------------------------
let mapleader = ','

" ESC 키를 편하게 <Ctrl+f>로 변경
map  <C-f> <ESC>
tmap <C-f> <ESC>
imap <C-f> <ESC>
map  <ESC> <C-\><C-n>
tmap <ESC> <C-\><C-n>
imap <ESC> <C-\><C-n>

" 입력모드에서 간단한 커서이동
imap <C-l> <RIGHT>

" 빠른 커서 이동
map <C-j> 3j
map <C-k> 3k
map <C-l> $
map <C-h> ^

" 빠른 스크롤
map <C-n> <C-e><down><Up><C-e><down><up><C-e>
map <C-p> <C-y><up><down><C-y><up><down><C-y>

" 분할창 크기조절
map <C-Up> <C-W>2+
map <C-Down> <C-W>2-
map <C-Left> <C-W>2<
map <C-Right> <C-W>2>

" Buffer
nmap <leader>z :bp<CR>
nmap <leader>x :bn<CR>
nmap <leader><tab> :ToggleBufExplorer<CR>
nmap <leader>c :bd<CR>

" Tab
nmap <silent><S-q> gt
nmap <silent><S-Tab> gT
nmap <Leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" 영역지정 된 행을 위아래로 이동
vmap <S-j> :m '>+1<CR>gv=gv
vmap <S-k> :m '<-2<CR>gv=gv

" 영역지정 시 들여쓰기/내어쓰기. 
vmap >> >gv 
vmap << <gv 

" 레지스터 보기
nmap <silent> <leader>r :reg<cr>

" 파일비교
nmap <leader>v :vert diffsplit 

" 현재 경로를 작업경로로 설정
nmap <leader>. :lcd %:p:h<CR>

" 종료
map  <leader>w <ESC>:w<CR>
map  <leader>q <ESC>:q<CR>
tmap <leader>q <C-\><C-n>:q<CR>

"----------------------------------------------------------------------
"" plugins & etc function mapping
"----------------------------------------------------------------------

" Auto highlight
nmap <leader>/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

" Clean search (highlight)
nmap <silent> <leader><space> :noh<cr>

" Compile
nmap <silent><leader>a :call Compile()<CR>

" Ctags 
nmap <silent>tt :!ctags -R .<CR>
nmap <silent>ts :tselect<CR>
nmap <silent>tn :tnext<CR>
nmap <silent>tp :tprevious<CR>

" Easymotion
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)

" FuzzyFinder
nmap <silent>sf :FufFile **/<CR>
nmap <silent>sb :FufBuffer<CR>
nmap <silent>st :FufTagWithCursorWord!<CR>
nmap <silent>s, :FufBufferTag<CR>
nmap <silent>so :FufJumpList<CR>

" Grep.vim
nmap <silent> <leader>gp :Rgrep<CR>

" Git
nmap <Leader>gs :Git<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gsh :Git push<CR>
nmap <Leader>gll :Git pull<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gl :Git log<CR>
nmap <Leader>gr :Gremove<CR>
nmap <Leader>o :GBrowse<CR>

" Numberline
map <silent><leader>R :call Numberline_remove_toggle()<CR>
map <silent><leader>k :call Numberline_change_toggle()<CR>

" Sidebar
nmap <silent><leader>l :NERDTreeToggle<CR>      
nmap <silent><leader>h :TagbarToggle<CR>
nmap <silent><leader>j :sp<CR><C-w>j<C-w>10_:terminal<CR>:set nonu nornu<CR>a

" Tab change to 4 space
nmap <leader>T :if Tab_toggle()<Bar>set noexpandtab<Bar>endif<CR>


"*****************************************************************************
"" Custom configs
"*****************************************************************************
" vuejs
autocmd Filetype vue setlocal ts=2 sw=2 expandtab 


"----------------------------------------------------------------------
"" 홈 디렉토리가 존재할 때에만 사용할 수 있는 기능 정의
"----------------------------------------------------------------------
if exists("$HOME")

    " 특정 시스템에서는 홈 디렉토리 경로 끝에 / 또는 \ 문자가 붙어 있기 때문에, 그것들을 제거한다.	
    let s:home_dir = $HOME	
    let s:temp = strpart(s:home_dir,strlen(s:home_dir)-1,1)	
    if s:temp == "/" || s:temp == "\\"	
        let s:home_dir = strpart(s:home_dir,0,strlen(s:home_dir)-1)	
    endif

    " 경로 설정
    let s:dir_tmp = s:home_dir."/.vim/tmp"
    let s:dir_backup = s:home_dir."/.vim/backup"

    " 임시 디렉토리 설정
    if isdirectory(s:dir_tmp)
        set swf
        let &dir = s:dir_tmp
    else
        set noswf
        set dir=.
    endif

    " 백업 디렉토리 설정
    if isdirectory(s:dir_backup)
        set bk
        let &bdir = s:dir_backup
        set bex=.bak
    else
        set nobk
    endif
endif
