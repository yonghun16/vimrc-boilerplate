"---------------------------------------------------------
" Keymaps for Other Editors(cursorAI etc)
"---------------------------------------------------------

" Cursor movement
nmap <C-k> 3k
vmap <C-k> 3k
nmap <C-j> 3j
vmap <C-j> 3j
nmap <C-l> $
vmap <C-l> $
nmap <C-h> ^
vmap <C-h> ^

" Screen movement
nmap <C-p> 3<C-y>
nmap <C-n> 3<C-e>

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
