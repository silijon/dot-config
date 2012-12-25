"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" .vimrc --- all-purpose, console friendly
"""            reqs: Pathogen, NERDTree, gentooish
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256  "hopefully working in 256 color term

"spin up pathogen
call pathogen#infect()
call pathogen#helptags()

colorscheme gentooish  "colors

"general settings
let mapleader = ","
set hidden  "shut the command line up
set novb      "shut the visual bell up
"set vb      "shut the bell up
set ch=2    "make command line two lines high
set mousehide   "hide the mouse when typing text
set number  "start with line nos
"set wrap    "default to line wrapping
"set linebreak  "break in-between words rather than splitting them in the middle
"set ruler
"set noesckeys   "don't look for escape sequences in insert mode (stops crazy delays on certain characters)
"set textwidth=160
"set wrapmargin=2 "inserts EOLs between lines when word-wrapping
set ignorecase  "ignore case sensitivity on searches

"indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
imap <S-Tab> <Esc><<i

"filetype switches
syntax on
filetype on
filetype indent on
filetype plugin on

"addtl filetype mappings
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.tmpl set filetype=html
au BufNewFile,BufRead *.gsp set filetype=htmlm4  "regular html formatting looks like shit with groovy tags for some reason
"au BufNewFile,BufRead *.html set filetype=htmlm4

"autocmd FileType python map <F4> :w<CR>:!screen -x ipython -X stuff $'\%reset\ny\n\%cd %:p:h\n\%run %:t\n'<CR><CR>

"outline word being changed
set cpoptions+=$

"map line num toggle
"nmap <silent> <F2> :set number<CR>
"nmap <silent> <S-F2> :set nonumber<CR>
nnoremap <F2> :set nonumber!<CR>

"remap window/buffer cycling to something that doesn't suck on mac
map <Tab> <C-w><C-w>
map <C-j> <C-^>
map <C-k> :bnext<CR>
map <C-l> :bprevious<CR>
"map <C-n> :s/^/#/g<CR>  "python comment on
"map <C-m> :s/^#//g<CR>  "python comment off

"convenience mappings
nmap <silent> <F5> :e ~/.bashrc<CR>
nmap <silent> <F6> :e ~/.vimrc<CR>
nmap <silent> <F3> :NERDTreeToggle .<CR>
"nmap <silent> <F4> :NERDTreeToggle ~/src/python/primer-0.1<CR>
