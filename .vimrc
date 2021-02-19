" Mikey Garcia, @gikeymarcia
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
    Plug 'tpope/vim-commentary'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
" utils
    " https://github.com/junegunn/fzf.vim
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-fugitive'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
" statusbar
    Plug 'itchyny/lightline.vim'
" MAYBE
    " Plug 'tmhedberg/SimpylFold'
    " Plug 'kevinoid/vim-jsonc'
    " Plug 'Konfekt/FastFold'
    " Plug 'junegunn/vim-peekaboo'
    " Plug 'ap/vim-css-color'
call plug#end()
" PLUGIN CONFIGURATION
source ~/.vim/plug-config/coc.vim
source ~/.vim/plug-config/goyo.vim
source ~/.vim/plug-config/vim-easy-align.vim
source ~/.vim/plug-config/undotree.vim
source ~/.vim/plug-config/ansible.vim
" source ~/.vim/plug-config/lightline.vim
" NOT Installed
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
set undofile
set undodir=~/.vim/undo
"       _               _
" _  __(_)__ __ _____ _/ /__
"| |/ / (_-</ // / _ `/ (_-<
"|___/_/___/\_,_/\_,_/_/___/ allow italics
" https://jsatk.us/posts/a-descent-into-madness-with-vim-tmux-and-italics
set t_ZH=[3m
set t_ZR=[23m
" dark colorscheme
source ~/.vim/plug-config/gruvbox.vim
" light colorscheme
" colorscheme Atelier_ForestLight
" set background=light
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
nnoremap <Leader>c :Colors<CR>
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
set foldmethod=indent
set foldlevelstart=1
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
nnoremap <Leader>m :w<CR>:!markdown-watch.sh % &<CR>
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
"|_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/ (KEYBINDS)
"                             |___/
"visual mode
" yank to clipboard
vnoremap <C-y> "+y<CR>
" insert mode
" paste from clipboard
inoremap <C-v> <ESC>:set paste<CR>a<C-r>+<esc>:set nopaste<CR>a
" paste link as reference format link from clipboard
inoremap <C-l> <CR><CR>[shortname]: <<ESC>:set paste<CR>a<C-r>+<esc>:set nopaste<CR>a><CR>"Long Description of Link"<ESC>0kfnciw
" folding
nnoremap <Tab> za
" nnoremap <C-]> zr
" normal mode
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>
nnoremap <Leader>s :source ~/.vimrc<CR>
" TODO make below command send full path to :!tmux set-buffer
nnoremap <Leader>p :! echo <C-r>%<cr>
nnoremap <Leader>gf 0f(lyt):!firefox -private <C-r>" &<CR><CR>
nnoremap <localLeader>l :set wrap!<CR>
"nnoremap <localLeader>c :syntax sync fromstart<CR>
"" todo lists
nnoremap <Leader>\| yy2p:s/[^ \|]/-/g<CR>:set hlsearch!<CR>
nnoremap <Leader>- o-<space>[<space>]<space>
nnoremap <Leader>x 0f[lrXWj
nnoremap <Leader>X 0fXr<space><Esc>2wj
" splits
set splitbelow splitright
nnoremap <Leader>F :sp<CR>:Files<CR>
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

" toggle dark/light
map <F11> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
"             _                           _
"  __ _ _   _| |_ ___   ___ _ __ ___   __| |
" / _` | | | | __/ _ \ / __| '_ ` _ \ / _` |
"| (_| | |_| | || (_) | (__| | | | | | (_| |
" \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|
" remove trailing white space before writing file
let blacklist = ['patch', 'diff', 'markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e
" custom extension syntax highlighting
autocmd BufNewFile,BufRead *.Xresources,*.xcolors,*.xfonts set syntax=xdefaults
autocmd BufNewFile,BufRead *.m3u,*.m3u8 set syntax=dosini
" AUTO-RELOAD PROGRAMS
autocmd BufWritePost ~/.Xresources      :!xrdb -merge ~/.Xresources
autocmd BufWritePost ~/.config/i3/*     :!~/.scripts/i3/build-config.sh
"                         _                _         __  __
" __ _ _ _  _ _  ___ _  _(_)_ _  __ _   __| |_ _  _ / _|/ _|
"/ _` | ' \| ' \/ _ \ || | | ' \/ _` | (_-<  _| || |  _|  _|
"\__,_|_||_|_||_\___/\_, |_|_||_\__, | /__/\__|\_,_|_| |_|
"                    |__/       |___/
nnoremap Q <nop>
nnoremap <F1> <nop>
inoremap <F1> <nop>
