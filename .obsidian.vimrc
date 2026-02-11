" Have j and k navigate visual lines rather than logical ones
" nmap j gj
" nmap k gk

set clipboard=

" make sure the space key is unmapped so it can be used as a leader key
" DOES NOT WORK, wasted 2 hours here, just control c for system clipboard
" unmap <Space>
"
" vmap <Space>y <C-c>

" Quickly remove search highlights
nmap <F9> :nohl<CR>

" THIS PART IS CURRENTLY NOT WORKING
" map old C-o functionality to
" nmap <leader>pb :obcommand<space>switcher:open<CR>
" go back and forth in jumps
" (make sure to remove default Obsidian shortcuts for these to work)
" exmap back obcommand app:go-back
" nmap <C-o> :back<CR>
" exmap forward obcommand app:go-forward
" nmap <C-i> :forward<CR>

" Jump to the file under the cursor
" nmap gd <C-CR>
nmap gd :obcommand<space>editor:open-link-in-new-leaf<CR>
nmap gx :obcommand<space>editor:follow-link<CR>

" simulate vim-surround plugin
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_dollar surround $ $

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki<CR>
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>
map s$ :surround_dollar<CR>

