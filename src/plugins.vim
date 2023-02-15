let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" This for loop is from https://stackoverflow.com/a/4500936/13132898.
" The license is CC BY-SA 2.5.
for f in split(glob(g:vimrc_dir . '/plugins/*.vim'), '\n')
    exe 'source' f
endfor

Plug 'tpope/vim-endwise'
Plug 'sbdchd/vim2hs'
Plug 'jelera/vim-javascript-syntax'
Plug 'tpope/vim-fugitive'   " Git wrapper
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'adimit/prolog.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-repeat'
Plug 'philj56/vim-asm-indent'
Plug 'rust-lang/rust.vim'
Plug 'junegunn/fzf'
Plug 'whonore/Coqtail'
"vim-gutentags{{{
"Auto tags file generator.
Plug 'ludovicchabant/vim-gutentags'

set statusline+=%{gutentags#statusline()}
"}}}
"quickrun{{{
Plug 'thinca/vim-quickrun'
let g:quickrun_config={
            \'hook/output_encode/enable':1,
            \'hook/output_encode/encoding':'utf-8',
            \}
"}}}
"tagbar{{{
Plug 'majutsushi/tagbar'
set updatetime=0    " seemless syncking with tagbar.
nnoremap <F8> :TagbarToggle<CR>
"}}}
call plug#end()

packadd! matchit

