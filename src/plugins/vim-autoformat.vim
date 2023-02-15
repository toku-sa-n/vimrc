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
    autocmd BufWritePre *.s,*.pl,*.rs,*.hs,*.java,*.css,*.tex,*.c,*.cpp,*.hpp,*.html,*.css,*.h,*.js,*.py,*.rb,*.elm,*.awk,*.go,*.json,*.scss,*.sass,*.bib,*.tsx :Autoformat
augroup END
