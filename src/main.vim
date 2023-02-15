set encoding=utf-8
scriptencoding utf-8

" `g:mapleader` must be defined first and foremost. Otherwise, all lines using
" `<leader>` will use the old leader key.
let g:mapleader="\<Space>"

function! ReadPart(path)
    exec 'source ' . g:vimrc_dir . '/' . a:path
endfunction

function! ReadAll(dirPath)
    " This for loop is from https://stackoverflow.com/a/4500936/13132898.
    " The license is CC BY-SA 2.5.
    for f in split(glob(g:vimrc_dir . '/' . a:dirPath . '/*.vim'), '\n')
        exe 'source' f
    endfor
endfunction

let g:vimrc_dir=fnamemodify(resolve(expand('$MYVIMRC')),':h')

call ReadPart('plugins.vim')
call ReadPart('indent.vim')
call ReadPart('japanese.vim')
call ReadPart('local_vimrc.vim')
call ReadAll('langs')

"Display{{{
filetype plugin indent on
syntax on

" This depends on `vim-hybrid`. I tried to move this line into
" `src/plugins/vim-hybrid` but couldn't get it work.
colorscheme hybrid

"Colorchange
set t_Co=16
set background=dark

set display=lastline
set relativenumber

"Show which keys are pressed
set showcmd

"Highlighten the pair parenthesis when entering ( or ).
set showmatch
set matchtime=5

set laststatus=2

"Scroll
set scrolloff=5

hi Folded ctermbg=none
"}}}
"Completions{{{
set completeopt=menuone,menu,longest,preview
set complete+=U,k,d,]
set infercase
set pumheight=10
"}}}
" Search and Grep{{{
set ignorecase  " A and a is the same
set smartcase   " If the sentence to search contains UPPER, then no-ignorecase.
set incsearch   " Automatically start to search when typing the word to search.
set gdefault    " Always add "g" s/foo/bar/g <---
set hlsearch

"Auto load when editing file is changed
set autoread
set autowrite

"Autocomplete of command line
set wildmenu
set wildmode=list:full

set shortmess-=S    " To show the number of matched words.
"}}}
"Moving{{{
"Endless Moving
set whichwrap=h,l,<,>,[,],b
"}}}
"Others{{{

augroup spell_git_commit
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

" cancelAutoComment
set formatoptions-=cro

set ttyfast

set hidden

set history=500

set matchpairs+=「:」


if has('python3')
    set pyxversion=3
else
    set pyxversion=2
endif

" chomp each line
augroup chomp
    autocmd!
    autocmd BufWritePre * silent! exec "%s/ \\+$//g"
augroup END

set autoread

set mouse=a

augroup exclude_quickfix_from_bnext_bprevious
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" autoclose quickfix
" See: https://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
augroup close_quickfix
    au!
    au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END

"}}}

set fileencodings=utf-8,sjis
