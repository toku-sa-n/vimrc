Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'

let NERDTreeShowLineNumbers=1

augroup nerdtree
    autocmd!
    " From https://vi.stackexchange.com/a/18489/38995
    nnoremap <expr> <F9> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
    autocmd FileType nerdtree setlocal relativenumber
augroup END

