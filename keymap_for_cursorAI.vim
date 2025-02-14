"---------------------------------------------------------
" Keymaps for Other Editors(cursorAI etc)
"---------------------------------------------------------

" Cursor movement
nmap <C-k> 3k
vmap <C-k> 3k
nmap <C-j> 3j
vmap <C-h> ^
nmap <C-l> $
vmap <C-l> $
vmap <C-j> 3j
nmap <C-h> ^
nmap <C-S-k> 10k
vmap <C-S-k> 10k
nmap <C-S-j> 10j
vmap <C-S-j> 10j

" Using Terminal keymap on <Insert> mode
imap <C-l> <ESC>$a
imap <C-a> <ESC>^i
imap <C-e> <ESC>$a
imap <C-d> <DEL>
imap <C-k> <ESC><Right>c
imap <C-CR> <ESC>o

" Screen movement
nmap <C-n> 3<C-e>
vmap <C-n> 3<C-e>
nmap <C-p> 3<C-y>
vmap <C-p> 3<C-y>
nmap <C-f> <C-d>
vmap <C-f> <C-d>
nmap <C-d> <C-u>
vmap <C-d> <C-u>

" Move Visual block (Indent, Outdent)
vmap > >gv
vmap < <gv
