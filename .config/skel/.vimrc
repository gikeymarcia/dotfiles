" Mikey Garcia, @gikeymarcia
" Base vim config for new users
"         _
"   _  __(_)_ _  ________
" _| |/ / /  ' \/ __/ __/
"(_)___/_/_/_/_/_/  \__/ my basic .vimrc config
let mapleader  =","         " use the comma character as leader
let maplocalleader=" "      " use the space character as localleader
set mouse=a
" swap file madness
set noswapfile nobackup undofile
set undodir=~/.vim/undo
"       _               _
" _  __(_)__ __ _____ _/ /__
"| |/ / (_-</ // / _ `/ (_-<
"|___/_/___/\_,_/\_,_/_/___/ allow italics
" https://jsatk.us/posts/a-descent-into-madness-with-vim-tmux-and-italics
set t_ZH=[3m
set t_ZR=[23m
colorscheme ron
set background=dark
" page visual tweaks
set showcmd                  " show command in bottom bar
set lazyredraw               " redraw only when we need to.
set linebreak                " don't break up words during line wrapping
set colorcolumn=80
" hightlight position with <leader>h
highlight ColorColumn ctermbg=darkgrey guibg=lightgrey
highlight cursorcolumn cterm=NONE ctermbg=darkred ctermfg=white
highlight cursorline   cterm=NONE ctermbg=red ctermfg=white
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>
"
"            _    _
" _ _ ___ __(_)__(_)_ _  __ _
"| '_/ -_|_-< |_ / | ' \/ _` |
"|_| \___/__/_/__|_|_||_\__, | (RESIZE)
" resizing windows      |___/
nnoremap <C-Up> :resize +1<cr>
nnoremap <C-Down> :resize -1<cr>
nnoremap <C-Right> :vert resize +2<cr>
nnoremap <C-Left> :vert resize -2<cr>
"
" _        _
"| |_ __ _| |__ ___
"|  _/ _` | '_ (_-<
" \__\__,_|_.__/__/ (TABS)
" https://medium.com/@arisweedler/tab-settings-in-vim-1ea0863c5990
set expandtab           " turn all TAB->4(space)
set softtabstop=4       " # of spaces inserted when TAB is pressed
set tabstop=4           " # of spaces per TAB read from file
set shiftwidth=4        " # of spaces inserted when TAB is pressed
set autoindent          " auto indent (copy previous line)
filetype plugin indent on
" code folding
"set foldmethod=indent
"
" ___ ___  ___
"|_ _|   \| __|
" | || |) | _|
"|___|___/|___|-like environment variables (IDE)
syntax on                   " enable syntax highlighting
set number relativenumber   " left panel numbering relative to cursor position
set wildmenu                " visual autocomplete for command menu
set completeopt=longest,menuone
set showmatch               " highlight matching {},(),[]
set browsedir=buffer        " set working directory based on opening file location
" markdown stuff
let g:markdown_fenced_languages = ['python', 'bash=sh', 'vim', 'html', 'css' , 'json', 'dosini', 'ini', 'sshconfig', 'yaml']

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
"|_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/ (KEYBINDS)
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
"" todo lists
nnoremap <Leader>\| yy2p:s/[^ \|]/-/g<CR>:set hlsearch!<CR>
nnoremap <Leader>- o-<space>[<space>]<space>
nnoremap <Leader>x 0f[lrXWj
nnoremap <Leader>X 0fXr<space><Esc>2wj
" splits
set splitbelow splitright
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
nnoremap <Leader>_ ciW__<Esc>P
nnoremap <Leader>[ ciW[]<Esc>P
"" spellcheck
nnoremap <F7> :set spell!<CR>

" file shortcuts
nnoremap <Leader><Localleader><Localleader> :edit!<CR>

" manual syntax highlighting
map <F11> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
"             _                           _
"  __ _ _   _| |_ ___   ___ _ __ ___   __| |
" / _` | | | | __/ _ \ / __| '_ ` _ \ / _` |
"| (_| | |_| | || (_) | (__| | | | | | (_| |
" \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|
" custom extension syntax highlighting
autocmd BufNewFile,BufRead *.m3u,*.m3u8 set syntax=dosini
"                         _                _         __  __
" __ _ _ _  _ _  ___ _  _(_)_ _  __ _   __| |_ _  _ / _|/ _|
"/ _` | ' \| ' \/ _ \ || | | ' \/ _` | (_-<  _| || |  _|  _|
"\__,_|_||_|_||_\___/\_, |_|_||_\__, | /__/\__|\_,_|_| |_|
"                    |__/       |___/
nnoremap Q <nop>
nnoremap <F1> <nop>
inoremap <F1> <nop>
