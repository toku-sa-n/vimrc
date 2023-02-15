nnoremap s "_s

nnoremap Y y$

nnoremap + <C-a>
nnoremap - <C-x>

nnoremap gO O<Esc>
nnoremap go o<Esc>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap <leader>w :up<CR>
nnoremap <leader>W :w !sudo tee %<CR>

nnoremap <leader>. :<C-u>execute 'tabnew '.escape(resolve(expand($MYVIMRC)),'\ ')<CR>

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <silent> <leader>b :bprevious<CR>
nnoremap <silent> <leader>n :bnext<CR>

augroup make_mappings
    autocmd!
    autocmd BufNewFile,BufRead * if (filereadable('Makefile') || filereadable('makefile')) | nnoremap <leader>l :up <Bar> make<CR>
    autocmd BufNewFile,BufRead * if (filereadable('Makefile') || filereadable('makefile')) | nnoremap <leader>v :up <Bar> make run<CR>
augroup END

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap & :&&<CR>
xnoremap & :&&<CR>
