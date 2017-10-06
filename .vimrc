"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" .vimrc --- all-purpose, console & gui friendly
"""            reqs: vim-plug, jellybeans
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""setup"""
set nocompatible
colorscheme jellybeans
if has("win32")
    source $VIMRUNTIME/vimrc_example.vim  "not sure if i need these but wth
    source $VIMRUNTIME/mswin.vim
    behave mswin  "this seems to be essential
    au GUIEnter * simalt ~x "run fullscreen on startup
    set backupdir=C:\tmp\vim
endif

"""load plugins -- using junegunn/vim-plug"""
silent!call plug#begin()  "force silent since gvim complains about missing git in some execution contexts
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/OutlookVim'
call plug#end()  "PlugStatus to check on plugins

"""plugin-specific settings"""
let g:NERDTreeWinSize=35
let g:NERDTreeShowHidden=1
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts=1
let g:outlook_scan_email_body_Unicode=0
let g:outlook_textwidth=0

"""general settings"""
if has("multi_byte")
    set encoding=utf-8
endif
let mapleader = ","
set novb      "shut the visual bell up
set hidden    "shut the command line up
set cpoptions+=$  "outline the word being modified
set ch=1    "make command line one line high
set mousehide   "hide the mouse when typing text
set number  "start with line nos
set textwidth=0  "driving you crazy?  ':verbose set tw?' to find the culprit
set foldlevel=99  "open all folds on startup
set ignorecase  "ignore case sensitivity on searches
set hlsearch "highlight search results

"""indentation"""
set smartindent
set expandtab  "use spaces instead of tabs
set tabstop=4  "default to 4 spaces per tab
set shiftwidth=4  "also 4 spaces on an indent

"""filetype settings"""
syntax on
filetype on
filetype indent on
filetype plugin on
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.tmpl set filetype=html
au FileType python setl nosmartindent
au FileType make setl noexpandtab  "make files need actual tab characters
au FileType markdown setl spell spelllang=en_us
au FileType mail setl spell spelllang=en_us

"""pretty printing on indent call (gg=G)"""
if has("win32")
    au FileType xml setl equalprg=c:\\Windows\\Sysnative\\bash.exe\ -c\ 'xmllint\ --format\ --recover\ -'
    au FileType json setl equalprg=c:\\Windows\\Sysnative\\bash.exe\ -c\ 'python2.7\ -mjson.tool'
else
    au FileType xml setl equalprg=xmllint\ --format\ --recover\ -
    au FileType json setl equalprg=python2.7\ -mjson.tool
endif

"""custom mappings"""
map <leader>z 1z=
map <Tab> <C-w><C-w>
map <C-j> <C-^>
map <C-n> :bnext<CR>
map <C-p> :bprevious<CR>
map <C-t> <Esc>:tabnew<CR>
nmap + :vertical res +5<CR>
nmap - :vertical res -5<CR>

"""gui/console specific"""
if has("gui_running")
    set guifont=Ubuntu_Mono_derivative_Powerlin:h14,Ubuntu_Mono:h14,Consolas:h13
    set guioptions=egmt
    set guioptions-=L
    set guioptions-=m "do something with intercepting alt key
    map <M-t> <Esc>:tabnew<CR>
    map <silent> <M-;> :NERDTreeToggle .<CR>
else
    set t_Co=256  "hopefully working in 256 color term
    map <silent> <Esc>; :NERDTreeToggle .<CR>
endif
