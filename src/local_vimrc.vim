augroup load_local_vimrc
    autocmd!
    autocmd VimEnter * if findfile('.local_vimrc','.;')!=''|silent! exec "source " . findfile('.local_vimrc','.;')| endif
augroup END
