" root user nvim init.vim all it does it source ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
" https://github.com/neovim/neovim/wiki/Introduction
" https://neovim.io/doc/user/vim_diff.html#vim-differences
" https://neovim.io/doc/user/nvim.html#nvim-from-vim
