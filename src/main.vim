scriptencoding utf-8

" `g:mapleader` must be defined first and foremost. Otherwise, all lines using
" `<leader>` will use the old leader key.
let g:mapleader="\<Space>"

let g:vimrc_dir=fnamemodify(resolve(expand('$MYVIMRC')), ':h')

"Plugins{{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')


"NerdTREE{{{
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'

let NERDTreeShowLineNumbers=1

augroup nerdtree
    autocmd!
    " From https://vi.stackexchange.com/a/18489/38995
    nnoremap <expr> <F9> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
    autocmd FileType nerdtree setlocal relativenumber
augroup END
"}}}
"ale{{{
Plug 'dense-analysis/ale'

let g:ale_linters = {'rust': ['cargo'], 'haskell': ['hls', 'hlint', 'cabal']}
let g:ale_haskell_hlint_options = '--show'
let g:ale_open_list = 1
let g:ale_fix_on_save = 0
let g:ale_rust_cargo_use_clippy = 1

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" Workaround for closing the error list when there is no error.
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

"}}}
"FZF{{{
Plug 'junegunn/fzf'

nnoremap <leader>f :FZF<CR>
"}}}
"Tagbar{{{
Plug 'majutsushi/tagbar'

set updatetime=0    " seemless syncking with tagbar.
nnoremap <F8> :TagbarToggle<CR>
"}}}
"UltiSnips{{{
Plug 'SirVer/ultisnips'

nnoremap <space><space> :<c-u>UltiSnipsEdit<CR>
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<c-p>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories=[g:vimrc_dir . '/snippets']
"}}}
"vim-airline{{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='jellybeans'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.maxlinenr = ''
"}}}
"vim-autoformat{{{
Plug 'Chiel92/vim-autoformat'

let g:formatdef_hs = '"(hindent | stylish-haskell)"'
let g:formatters_haskell = ['hs']

let g:formatdef_elmformat = '"elm-format --stdin"'
let g:formatters_elm = ['elmformat']

let g:formatdef_awk = '"awk -o- -f -"'
let g:formatters_awk = ['awk']

let g:formatdef_stylelint = '"stylelint --fix"'
let g:formatters_sass = ['stylelint']
let g:formatters_scss = ['stylelint']

let g:formatdef_prettier = '"npx prettier --parser babel"'
let g:formatters_javascript = ['prettier']
let g:formatters_typescript = ['prettier']
let g:formatters_typescriptreact = ['prettier']

let g:formatdef_bibtex = '"bibtex-tidy -"'
let g:formatters_bib = ['bibtex']

augroup autoformat
    autocmd!
    autocmd FileType tex,haskell let b:autoformat_autoindent=0
    autocmd BufWritePre *.s,*.pl,*.rs,*.hs,*.java,*.css,*.tex,*.c,*.cpp,*.hpp,*.html,*.css,*.h,*.js,*.py,*.rb,*.elm,*.awk,*.go,*.json,*.scss,*.sass,*.bib,*.tsx,*.ts,*ml,*mli :Autoformat
augroup END
"}}}
"fugitive.vim{{{
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
"}}}
"vim-gutentags{{{
"Auto tags file generator.
Plug 'ludovicchabant/vim-gutentags'

set statusline+=%{gutentags#statusline()}
"}}}
"vim-hybrid{{{
Plug 'w0ng/vim-hybrid'

let g:hybrid_custom_term_colors=1
let g:hybrid_reduced_contrast=1
"}}}
"vim-lsp{{{
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
if executable('pyls')
    " pip install python-language-server
    augroup install_pyls
        autocmd!
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'pyls',
                    \ 'cmd': {server_info->['pyls']},
                    \ 'allowlist': ['python'],
                    \ })
    augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> ga <plug>(lsp-code-action)

    " See: https://github.com/prabirshrestha/vim-lsp/issues/1263#issuecomment-1011892059
    nmap <plug>() <Plug>(lsp-float-close)

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_log_verbose = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
"}}}
"vim-markdown-folding{{{
Plug 'mikeboiko/vim-markdown-folding'
let g:markdown_fold_style = 'nested'
"}}}
"vim-quickrun{{{
Plug 'thinca/vim-quickrun'

let g:quickrun_config={
            \'hook/output_encode/enable':1,
            \'hook/output_encode/encoding':'utf-8',
            \}
"}}}
"vim-splash{{{
Plug 'thinca/vim-splash'
let g:splash#path = g:vimrc_dir . '/../assets/title.txt'
"}}}
"vim-table-mode{{{
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'
"}}}
"vimtex{{{
Plug 'lervag/vimtex'

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

let g:vimtex_view_method='zathura'
let g:vimtex_compiler_latexmk = {
            \ 'options':[
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \   '-pdfdvi',
            \ ],
            \}
let g:vimtex_compiler_latexmk_engines={'_':'-pdfdvi'}   " See: https://texwiki.texjp.org/?vimtex
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1
"}}}

Plug 'mattn/emmet-vim'
Plug 'tpope/vim-endwise'
Plug 'sbdchd/vim2hs'
Plug 'jelera/vim-javascript-syntax'
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
Plug 'whonore/Coqtail'
Plug 'github/copilot.vim'
Plug 'ocaml/vim-ocaml'

call plug#end()

packadd! matchit
"}}}
"Indent{{{
set list listchars=tab:>-,trail:_
set autoindent
set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"}}}
"Japanese{{{
set helplang=ja,en
set spelllang+=cjk
"}}}
"Local vimrc{{{
augroup load_local_vimrc
    autocmd!
    autocmd VimEnter * if findfile('.local_vimrc','.;')!=''|silent! exec "source " . findfile('.local_vimrc','.;')| endif
augroup END
"}}}
"Mappings{{{
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
"}}}
"Options{{{
set encoding=utf-8

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
"}}}
"Langs{{{
"Assembly{{{
augroup assembly_specific
    autocmd!
    autocmd BufNewFile,BufRead *.asm set filetype=nasm
augroup END
"}}}
"C and C++{{{
set cinwords+=case
augroup c_specific
    autocmd!
    autocmd Filetype c,cpp setlocal foldmethod=indent
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
"Ruby{{{
augroup ruby_specific
    autocmd!
    autocmd Filetype ruby setlocal tabstop=2
    autocmd Filetype ruby setlocal softtabstop=2
    autocmd Filetype ruby setlocal shiftwidth=2
augroup END
"}}}
"Rust{{{
augroup rust_specific
    autocmd!
    autocmd Filetype rust setlocal foldmethod=indent
augroup END
"}}}
"Snippet{{{
augroup snippet_specific
    autocmd!
    autocmd BufNewFile,BufRead *.snip set noexpandtab
augroup END
"}}}
"Plain text{{{
augroup text_specific
    autocmd!

    " No auto line break. See http://stst.hateblo.jp/entry/2014/07/14/010844.
    autocmd Filetype text setlocal textwidth=0
augroup END
"}}}
"Vimscript{{{
augroup vim_specific
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
augroup END
"}}}
"}}}
"Display{{{
filetype plugin indent on
syntax on

" This depends on `vim-hybrid`. I tried to move this line into
" `src/plugins/vim-hybrid` but couldn't get it work.
colorscheme hybrid

hi Folded ctermbg=none
"}}}
"Others{{{

augroup spell_git_commit
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

" chomp each line
augroup chomp
    autocmd!
    autocmd BufWritePre * silent! exec "%s/ \\+$//g"
augroup END

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
