set encoding=utf-8
scriptencoding utf-8

let g:vimrc_dir=fnamemodify(resolve(expand('$MYVIMRC')),':h')

exec "source " . g:vimrc_dir . '/plugins.vim'
"Display"{{{
filetype plugin indent on
syntax on
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

"Fold
set foldmethod=marker
set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1

set laststatus=2

"Scroll
set scrolloff=5

"Colorize
let g:colorizer_colornames=0

hi Folded ctermbg=none
"}}}
"indent{{{
"indent
set list listchars=tab:>-,trail:_
set autoindent
set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

"Show the searched word at the center of the display.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

set shortmess-=S    " To show the number of matched words.
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"}}}
"Moving{{{
"Endless Moving
set whichwrap=h,l,<,>,[,],b
"}}}
"Shortcut{{{
let g:mapleader="\<Space>"
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap Y y$
nnoremap gO O<Esc>
nnoremap go o<Esc>

let g:filetype_to_ignore=['latex','plaintex','tex','text']

augroup about_make
    autocmd!
    autocmd BufNewFile,BufRead * if index(filetype_to_ignore,&ft)<0 | nnoremap <leader>l :up <Bar> make<CR>
    autocmd BufNewFile,BufRead * if index(filetype_to_ignore,&ft)<0 | nnoremap <leader>v :up <Bar> make run<CR>
augroup END

" Shortcut for vimrc. It may be good to add the shortcut ":source ~/.vimrc" when .vimrc are opened.
nnoremap <leader>. :<C-u>execute 'tabnew '.escape(resolve(expand($MYVIMRC)),'\ ')<CR>

nnoremap <leader>w :up<CR>
nnoremap <leader>W :w !sudo tee %<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap & :&&<CR>
xnoremap & :&&<CR>

nnoremap <leader>a :Gwrite<CR>
nnoremap <leader>c :Git commit<CR>
nnoremap <leader>p :!gh pr create<CR>
nnoremap <leader>s :Gstatus<CR>
nnoremap <up> :Git push<CR>
nnoremap <down> :Git pull<CR>
cnoremap gck Git checkout
cnoremap gckb Git checkout -b
cnoremap gm Gmerge
cnoremap gb Git branch
cnoremap gbd Git branch -d
nnoremap <leader>f :FZF<CR>

nnoremap <silent> <leader>b :bprevious<CR>
nnoremap <silent> <leader>n :bnext<CR>

"}}}
"Others{{{
"--- Language ---
set helplang=ja,en

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

set spelllang+=cjk

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

nnoremap s "_s

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
"Extension specific{{{
"Text{{{
augroup text_specific
    autocmd!
    autocmd Filetype text setlocal textwidth=0 " No auto line break. See http://stst.hateblo.jp/entry/2014/07/14/010844.
augroup END
"}}}
"C and C++{{{
set cinwords+=case
augroup c_specific
    autocmd!
    autocmd Filetype c,cpp setlocal foldmethod=indent
augroup END
"}}}
"HTML{{{
augroup html_specific
    autocmd!
    autocmd Filetype html setlocal tabstop=2
    autocmd Filetype html setlocal softtabstop=2
    autocmd Filetype html setlocal shiftwidth=2
augroup END
"}}}
"Perl{{{
augroup perl_specific
    autocmd!
    autocmd Filetype perl setlocal equalprg=perltidy\ -st
augroup END
"}}}
"Ruby{{{
augroup ruby_specific
    autocmd!
    autocmd Filetype ruby setlocal tabstop=2
    autocmd Filetype ruby setlocal softtabstop=2
    autocmd Filetype ruby setlocal shiftwidth=2
augroup END
"}}}
"Coffeescript{{{
augroup coffeescript_specific
    autocmd!
    autocmd Filetype coffee setlocal tabstop=2
    autocmd Filetype coffee setlocal softtabstop=2
    autocmd Filetype coffee setlocal shiftwidth=2
augroup END
"}}}
"Haskell{{{
let g:haskellmode_completion_ghc=0
augroup haskell_specific
    autocmd!
    autocmd Filetype haskell setlocal tabstop=4
    autocmd Filetype haskell setlocal softtabstop=4
    autocmd Filetype haskell setlocal shiftwidth=4
    autocmd Filetype haskell setlocal shiftround
    autocmd Filetype haskell nnoremap <leader>t :!cabal build && cabal test<CR>
augroup END
"}}}
"LaTeX{{{
set concealcursor=""
set conceallevel=2
let g:tex_flavor='latex'
let g:tex_conceal='abdmgs'
highlight Conceal guifg=White guibg=NONE ctermfg=15 ctermbg=NONE
"}}}
"Snippet{{{
augroup snippet_specific
    autocmd!
    autocmd BufNewFile,BufRead *.snip set noexpandtab
augroup END
"}}}
"Assembly{{{
augroup assembly_specific
    autocmd!
    autocmd BufNewFile,BufRead *.asm set filetype=nasm
augroup END
"}}}
"Rust{{{
augroup rust_specific
    autocmd!
    autocmd Filetype rust setlocal foldmethod=indent
augroup END
"}}}
"}}}}}}
"load .local_vimrc
augroup load_local_vimrc
    autocmd!
    autocmd BufNewFile,BufReadPost * if findfile('.local_vimrc','.;')!=''|silent! exec "source " . findfile('.local_vimrc','.;')| endif
augroup END

set fileencodings=utf-8,sjis
