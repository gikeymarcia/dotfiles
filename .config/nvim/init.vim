" https://github.com/neovim/neovim/wiki/Introduction
" https://neovim.io/doc/user/vim_diff.html#vim-differences
" https://neovim.io/doc/user/nvim.html#nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Mikey Garcia, @gikeymarcia
" https://vimways.org/2018/you-should-be-using-tags-in-vim/
"       _             _
" _ __ | |_   _  __ _(_)_ __  ___
"| '_ \| | | | |/ _` | | '_ \/ __|
"| |_) | | |_| | (_| | | | | \__ \
"| .__/|_|\__,_|\__, |_|_| |_|___/
"|_|            |___/
call plug#begin('~/.vim/plugged')
" colors
    Plug 'gruvbox-community/gruvbox'
    Plug 'flazz/vim-colorschemes'
" formatting
    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/goyo.vim'
    Plug 'tpope/vim-surround'
    "Plug 'tmhedberg/SimpylFold'
" utils
    " https://github.com/junegunn/fzf.vim
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mbbill/undotree'
    " Plug 'kevinoid/vim-jsonc'
    Plug 'tpope/vim-fugitive'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
" statusbar
    Plug 'itchyny/lightline.vim'
" MAYBE
    "Plug 'Konfekt/FastFold'
    " Plug 'junegunn/vim-peekaboo'
    " Plug 'ap/vim-css-color'
call plug#end()
" PLUGIN CONFIGURATION
source ~/.vim/plug-config/coc.vim
source ~/.vim/plug-config/lightline.vim
source ~/.vim/plug-config/goyo.vim
source ~/.vim/plug-config/vim-easy-align.vim
source ~/.vim/plug-config/undotree.vim
"source ~/.vim/plug-config/SimpylFold.vim
"source ~/.vim/plug-config/FastFold.vim
"         _
"   _  __(_)_ _  ________
" _| |/ / /  ' \/ __/ __/
"(_)___/_/_/_/_/_/  \__/ my basic .vimrc config
let mapleader  =","         " use the comma character as leader
let maplocalleader=" "      " use the space character as localleader

source ~/.config/nvim/vimrc.vim
