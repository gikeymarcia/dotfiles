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
source ~/.vim/plug-config/gruvbox.vim
"source ~/.vim/plug-config/SimpylFold.vim
"source ~/.vim/plug-config/FastFold.vim

"         _
"   _  __(_)_ _  ________
" _| |/ / /  ' \/ __/ __/
"(_)___/_/_/_/_/_/  \__/ my basic .vimrc config
let mapleader  =","         " use the comma character as leader
let maplocalleader=" "      " use the space character as localleader
set mouse=a
" swap file madness
set noswapfile
set nobackup
set undodir=~/.vim/undo
set undofile
" _  __(_)__ __ _____ _/ /__
"| |/ / (_-</ // / _ `/ (_-<
"|___/_/___/\_,_/\_,_/_/___/ allow italics
" https://jsatk.us/posts/a-descent-into-madness-with-vim-tmux-and-italics/
set t_ZH=[3m
set t_ZR=[23m
" page visual tweaks
set showcmd                  " show command in bottom bar
set lazyredraw               " redraw only when we need to.
set linebreak                " don't break up words during line wrapping
set colorcolumn=80
set background=dark
" hightlight position with <leader>h
highlight ColorColumn ctermbg=darkgrey guibg=lightgrey
highlight cursorcolumn cterm=NONE ctermbg=darkred ctermfg=white
highlight cursorline   cterm=NONE ctermbg=red ctermfg=white
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>
nnoremap <Leader>c :Colors<CR>
"
"            _    _
" _ _ ___ __(_)__(_)_ _  __ _
"| '_/ -_|_-< |_ / | ' \/ _` |
"|_| \___/__/_/__|_|_||_\__, |
" resizing windows      |___/
nnoremap <C-Up> :resize +1<cr>
nnoremap <C-Down> :resize -1<cr>
nnoremap <C-Right> :vert resize +2<cr>
nnoremap <C-Left> :vert resize -2<cr>
"
" _        _
"| |_ __ _| |__ ___
"|  _/ _` | '_ (_-<
" \__\__,_|_.__/__/
" https://medium.com/@arisweedler/tab-settings-in-vim-1ea0863c5990
set expandtab           " turn all TAB->4(space)
set softtabstop=4       " # of spaces inserted when TAB is pressed
set tabstop=4           " # of spaces per TAB read from file
set shiftwidth=4        " # of spaces inserted when TAB is pressed
set smartindent         " auto indent to correct level
filetype plugin indent on
" code folding
set foldmethod=manual
"
" ___ ___  ___
"|_ _|   \| __|
" | || |) | _|
"|___|___/|___|-like environment variables
syntax on                   " enable syntax highlighting
set number relativenumber   " left panel numbering relative to cursor position
set wildmenu                " visual autocomplete for command menu
set showmatch               " highlight matching {},(),[]
set browsedir=buffer        " set working directory based on opening file location
" markdown stuff
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim', 'css' , 'json']
nnoremap <Leader>m :w<CR>:!~/.scripts/pandoc/markdown-preview.sh % &<CR><CR>
nnoremap <Leader>dm /^_date modified:.*<CR>C_date modified: <ESC>:read !date +"\%Y-\%m-\%d"<CR>kJA_<ESC>:nohlsearch<CR>

" search settings
set incsearch               " search as characters are entered
set hlsearch                " highlight search matches
set ignorecase              " use case insensitive search
set smartcase               " case sensitive search when using capital letters
nnoremap <Leader><Leader> :nohlsearch<CR>

" _     _           _ _
"| |__ (_)_ __   __| (_)_ __   __ _ ___
"| '_ \| | '_ \ / _` | | '_ \ / _` / __|
"| |_) | | | | | (_| | | | | | (_| \__ \
"|_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"                             |___/
"visual mode
" yank to clipboard
vnoremap <C-y> "+y<CR>
" insert mode
" paste from clipboard
inoremap <C-v> <ESC>:set paste<CR>a<C-r>+<esc>:set nopaste<CR>a
" normal mode
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>
nnoremap <Leader>s :source ~/.vimrc<CR>
" TODO make below command send full path to :!tmux set-buffer
nnoremap <Leader>p :! echo <C-r>%<cr>
nnoremap <Leader>gf 0f(lyt):!firefox -private <C-r>" &<CR><CR>
nnoremap <localLeader>l :set linebreak!<CR>
"nnoremap <localLeader>c :syntax sync fromstart<CR>
"" todo lists
nnoremap <Leader>- o-<space>[<space>]<space>
nnoremap <Leader>x 0f[lrXWj
nnoremap <Leader>X 0fXr<space><Esc>2wj
" splits
set splitbelow splitright
nnoremap <Leader>f :sp<CR>:Files<CR>
"" change window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"" wrap words
nnoremap <Leader>" ciW""<Esc>P
nnoremap <Leader>' ciW''<Esc>P
nnoremap <Leader>( ciW()<Esc>P
nnoremap <Leader>< ciW<><Esc>P
nnoremap <Leader>` ciW``<Esc>P
"" spellcheck
nnoremap <F7> :set spell!<CR>

" file shortcuts
nnoremap <Leader><Localleader><Localleader> :edit!<CR>

" manual syntax highlighting
nnoremap <LocalLeader>m :set filetype=messages<CR>
map <F11> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
"
"             _                           _
"  __ _ _   _| |_ ___   ___ _ __ ___   __| |
" / _` | | | | __/ _ \ / __| '_ ` _ \ / _` |
"| (_| | |_| | || (_) | (__| | | | | | (_| |
" \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|
" remove trailing white space before writing file
let blacklist = ['patch', 'diff']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e
" custom extension syntax highlighting
autocmd BufNewFile,BufRead *.Xresources,*.xcolors,*.xfonts set syntax=xdefaults
" AUTO-RELOAD PROGRAMS
autocmd BufWritePost ~/.Xresources      :!xrdb -merge ~/.Xresources
autocmd BufWritePost ~/.config/i3/*     :!~/.scripts/i3/build-config.sh
"
"                         _                _         __  __
" __ _ _ _  _ _  ___ _  _(_)_ _  __ _   __| |_ _  _ / _|/ _|
"/ _` | ' \| ' \/ _ \ || | | ' \/ _` | (_-<  _| || |  _|  _|
"\__,_|_||_|_||_\___/\_, |_|_||_\__, | /__/\__|\_,_|_| |_|
"                    |__/       |___/
nnoremap Q <nop>
nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap o o<Esc>i
nnoremap O O<Esc>i
