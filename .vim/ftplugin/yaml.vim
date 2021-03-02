" https://vim.fandom.com/wiki/Indenting_source_code#Setup
" custom indentation for yaml
setlocal autoindent
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal foldlevelstart=2

" lint yaml files on write
if !exists("yamllint")
    let yamllint = 1
    autocmd BufWritePost *.yml,*.yaml :!yamllint -f standard --no-warnings %
endif
