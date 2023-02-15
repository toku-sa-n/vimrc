let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

call ReadPart('plugins/vim-table-mode.vim')
call ReadPart('plugins/vim-markdown-folding.vim')
call ReadPart('plugins/ale.vim')
call ReadPart('plugins/NERDTree.vim')

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
"""}}}
"vim-splash{{{
Plug 'thinca/vim-splash'
let g:splash#path=g:vimrc_dir . '/title.txt'
"}}}
"ultisnips{{{
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
Plug 'vim-airline/vim-airline-themes'
"}}}
"vim-hybrid{{{
Plug 'w0ng/vim-hybrid'
let g:hybrid_custom_term_colors=1
let g:hybrid_reduced_contrast=1
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
    autocmd FileType tex let b:autoformat_autoindent=0
    autocmd BufWritePre *.s,*.pl,*.rs,*.hs,*.java,*.css,*.tex,*.c,*.cpp,*.hpp,*.html,*.css,*.h,*.js,*.py,*.rb,*.elm,*.awk,*.go,*.json,*.scss,*.sass,*.bib,*.tsx :Autoformat
augroup END
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

