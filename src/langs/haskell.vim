augroup haskell_specific
    autocmd!
    autocmd Filetype haskell setlocal tabstop=4
    autocmd Filetype haskell setlocal softtabstop=4
    autocmd Filetype haskell setlocal shiftwidth=4
    autocmd Filetype haskell setlocal shiftround
    autocmd Filetype haskell nnoremap <leader>t :!cabal build && cabal test<CR>
augroup END
