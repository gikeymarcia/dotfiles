" check shell scripts for common mistakes
if !exists("shellcheck")
    let shellcheck = 1
    autocmd BufWritePost * :!shellcheck -x %
endif
