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
