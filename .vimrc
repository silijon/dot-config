"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" .vimrc --- all-purpose, console friendly
"""            reqs: vim-plug, gentooish
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""setup"""
set nocompatible
colorscheme gentooish
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
Plug 'vim-airline/vim-airline'
call plug#end()

"""plugin-specific settigns"""
let g:NERDTreeWinSize = 35
let g:NERDTreeShowHidden = 1

"""general settings"""
let mapleader = ","
set encoding=utf-8
set novb      "shut the visual bell up
set hidden    "shut the command line up
set cpoptions+=$  "outline the word being modified
set ch=2    "make command line two lines high
set mousehide   "hide the mouse when typing text
set number  "start with line nos
set ignorecase  "ignore case sensitivity on searches

"""indentation"""
set smartindent
set expandtab  "use spaces instead of tabs
set tabstop=4  "default to 4 spaces per tab
set shiftwidth=4  "also 4 spaces on an indent
imap <S-Tab> <Esc><<i  

"""filetype settings"""
syntax on
filetype on
filetype indent on
filetype plugin on
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.tmpl set filetype=html
au FileType python setl nosmartindent
au FileType make setl noexpandtab  "make files need actual tab characters
au FileType markdown setl tabstop=2 shiftwidth=2  "markdown seems to work nicer with 2 spaces

"""pretty printing on indent call (gg=G)"""
if has("win32")
    au FileType xml setlocal equalprg=c:\\Windows\\Sysnative\\bash.exe\ -c\ 'xmllint\ --format\ --recover\ -'
    au FileType json setlocal equalprg=c:\\Windows\\Sysnative\\bash.exe\ -c\ 'python2.7\ -mjson.tool'
else
    au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -
    au FileType json setlocal equalprg=python2.7\ -mjson.tool
endif

"""remap window/buffer cycling to something that doesn't suck"""
map <Tab> <C-w><C-w>  
map <C-j> <C-^>
map <C-n> :bnext<CR>
map <C-p> :bprevious<CR>
map <C-t> <Esc>:tabnew<CR>
map + :vertical res +5<CR>
map - :vertical res -5<CR>

"""gui/console specific"""
if has("gui_running")
    set guioptions=egmt
    set guioptions-=L
    set guifont=Ubuntu\ Mono:h14
    set guioptions-=m "do something with intercepting alt key
    map <M-t> <Esc>:tabnew<CR>
    nmap <silent> <M-;> :NERDTreeToggle .<CR>
else
    set t_Co=256  "hopefully working in 256 color term
    nmap <silent> <Esc>; :NERDTreeToggle .<CR>
endif
