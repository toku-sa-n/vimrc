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

