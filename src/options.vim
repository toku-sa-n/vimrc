set t_Co=16
set background=dark

set display=lastline

set relativenumber

set showcmd

set showmatch
set matchtime=5

set laststatus=2

set scrolloff=5

set autoread
set autowrite

set wildmenu
set wildmode=list:full

set shortmess-=S

set whichwrap=h,l,<,>,[,],b

set completeopt=menuone,menu,longest,preview
set complete+=U,k,d,]
set infercase
set pumheight=10

set ignorecase  " A and a is the same
set smartcase   " If the sentence to search contains UPPER, then no-ignorecase.
set incsearch   " Automatically start to search when typing the word to search.
set gdefault    " Always add "g" s/foo/bar/g <---
set hlsearch

set ttyfast

set hidden

set history=500

set matchpairs+=「:」

set mouse=a

set fileencodings=utf-8,sjis

if has('python3')
    set pyxversion=3
else
    set pyxversion=2
endif
