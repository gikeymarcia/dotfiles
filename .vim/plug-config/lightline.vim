" Mikey Garcia, @gikeymarcia
" lightline.vim options
set noshowmode
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif

" COLORSCHEMES
" see more @ ~/.vim/plugged/lightline.vim/colorscheme.md
"let g:lightline = { 'colorscheme': 'wombat', }
"let g:lightline = { 'colorscheme': 'jellybeans', }
"let g:lightline = { 'colorscheme': 'PaperColor_dark', }
"let g:lightline = { 'colorscheme': 'PaperColor_light', }
"let g:lightline = { 'colorscheme': 'material', }

" from -- https://github.com/neoclide/coc-python
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
\ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
