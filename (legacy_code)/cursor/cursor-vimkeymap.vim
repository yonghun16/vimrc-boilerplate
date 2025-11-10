"---------------------------------------------------------
" Keymaps for Other Editors(cursorAI etc)
"---------------------------------------------------------

" Cursor movement
nmap <C-k> kkk
vmap <C-k> kkk
nmap <C-j> jjj
vmap <C-j> jjj
nmap <C-l> $
vmap <C-l> $
nmap <C-h> ^
vmap <C-h> ^

" Screen movement
nmap <C-p> <C-y><C-y><C-y>
nmap <C-n> <C-e><C-e><C-e>

" Using Terminal keymap on <Insert> mode
imap <C-a> <ESC>^i
imap <C-e> <ESC>$a
imap <C-d> <DEL>
imap <C-k> <ESC><Right>C

" Additional key on <Insert> mode
imap <C-CR> <ESC>

" Move Visual block (Indent, Outdent)
vmap > >gv
vmap < <gv
