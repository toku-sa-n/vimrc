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
call ReadPart('mappings.vim')
call ReadPart('options.vim')
call ReadAll('langs')

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
