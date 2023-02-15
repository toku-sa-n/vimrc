Plug 'tpope/vim-fugitive'

nnoremap <leader>a :Gwrite<CR>
nnoremap <leader>c :Git commit<CR>
nnoremap <leader>p :!gh pr create<CR>
nnoremap <leader>s :Gstatus<CR>
nnoremap <up> :Git push<CR>
nnoremap <down> :Git pull<CR>

cnoremap gck<space> Git checkout<space>
cnoremap gckb<space> Git checkout -b<space>
cnoremap gm<space> Git merge<space>
cnoremap gb<space> Git branch<space>
cnoremap gbd<space> Git branch -d<space>

