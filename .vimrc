"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" .vimrc --- all-purpose, console friendly
"""            reqs: Pathogen, NERDTree, gentooish
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""terminal settings"""
set t_Co=256  "hopefully working in 256 color term


"""externals (plugins, colors)"""
call pathogen#infect()
call pathogen#helptags()
colorscheme gentooish


"""general settings"""
let mapleader = ","
set hidden    "shut the command line up
set novb      "shut the visual bell up
set cpoptions+=$  "outline the word being modified
set ch=2    "make command line two lines high
set mousehide   "hide the mouse when typing text
set number  "start with line nos
set ignorecase  "ignore case sensitivity on searches

"set laststatus=2
"set statusline+=%F
"set wrap    "default to line wrapping
"set linebreak  "break in-between words rather than spliting them in the middle
"set ruler
"set noesckeys   "don't look for escape sequences in insert mode (stops crazy
"delays on certain characters)
"set textwidth=160
"set wrapmargin=2 "inserts EOLs between lines when word-wrapping


"""indentation"""
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
imap <S-Tab> <Esc><<i


"""filetype settings"""
syntax on
filetype on
filetype indent on
filetype plugin on
au! FileType python setl nosmartindent
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.tmpl set filetype=html
au BufNewFile,BufRead *.gsp set filetype=htmlm4  "regular html formatting looks like shit with groovy tags for some reason
"au BufNewFile,BufRead *.html set filetype=htmlm4
autocmd FileType make setlocal noexpandtab  "make files need actual tab characters


"remap window/buffer cycling to something that doesn't suck
map <Tab> <C-w><C-w>
map <C-j> <C-^>
map <C-n> :bnext<CR>
map <C-p> :bprevious<CR>

"""NERDTree stuff"""
let g:NERDTreeWinSize = 50


"""clang complete stuff"""
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"let g:clang_snippets = 1
"let g:clang_snippets_engine = 'clang_complete'


"""ctags stuff"""
let Tlist_Ctags_cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50


"""convenience mappings"""
nnoremap <F2> :set nonumber!<CR>
nmap <silent> <F3> :NERDTreeToggle .<CR>
nmap <silent> <F4> :TlistToggle<cr>
nmap <silent> <F5> :e ~/.bashrc<CR>
nmap <silent> <F6> :e ~/.vimrc<CR>


