set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

execute pathogen#infect()

"---------------- key mappings ----------------
"F2 - toggle line nums
"F3 - toggle NERDTree on current directory
"F4 - send python file in current buffer to ipython screen session
"F5 - open .bash_profile in buffer
"F6 - open .vimrc in buffer
"F7 - open keys.txt in buffer
"F8 - (empty)
"F9 - send selected text to interpreter in corresponding vsplit buffer
"F10 - send all text to interpreter in corresponding vsplit buffer
"F11 - send all text to new buffer if editing an executable file 
"F12 - open ipython in vsplit
"----------------------------------------------

syntax on

set hidden  "shut the command line up
set vb      "shut the bell up
set ch=2    "make command line two lines high
set mousehide   "hide the mouse when typing text
set number  "start with line nos
set textwidth=0 wrapmargin=0
"set ruler
"set noesckeys   "don't look for escape sequences in insert mode (stops crazy delays on certain characters)
"set textwidth=160
"set wrapmargin=2

filetype on
filetype indent on
filetype plugin on
au! FileType python setl nosmartindent

"au BufNewFile,BufRead *.html set filetype=htmlm4
au BufNewFile,BufRead *.tmpl set filetype=html
au BufNewFile,BufRead *.json set filetype=json

"do pretty printing on indent call (gg=G)
au FileType xml setlocal equalprg=c:\\cygwin\\bin\\xmllint.exe\ --format\ --recover\ - 
au FileType json setlocal equalprg=c:\\Python27\\python.exe\ -mjson.tool

"do pretty printing on buffer load
"au FileType xml exe "%!c:\\cygwin\\bin\\xmllint.exe --format --recover %"
"au FileType json exe "%!c:\\Python27\\python.exe -mjson.tool %"


"autocmd FileType python map <F4> :w<CR>:!screen -x ipython -X stuff $'\%reset\ny\n\%cd %:p:h\n\%run %:t\n'<CR><CR>

"outline word being changed
set cpoptions+=$

"map line num toggle
"nmap <silent> <F2> :set number<CR>
"nmap <silent> <S-F2> :set nonumber<CR>
nnoremap <F2> :set nonumber!<CR>

"leader
let mapleader=","

"remap window/buffer cycling to something that doesn't suck on mac
map <Tab> <C-w><C-w>
map <C-j> <C-^>
map <C-k> :bnext<CR>
map <C-l> :bprevious<CR>
map <C-t> <Esc>:tabnew<CR>
map <C-Tab> <Esc>gt<CR>
map + :res +5<CR>
map - :res -5<CR>


"indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
imap <S-Tab> <Esc><<i

"ignore case sensitivity on searches
set ignorecase

"ditch tip window when omnicomplete finishes
"set completeopt=menu
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"convenience mappings
"nmap <silent> <F5> :e ~/.bash_profile<CR>
"nmap <silent> <F6> :e ~/.vimrc<CR>
"nmap <silent> <F7> :e ~/Documents/keys.txt<CR>

"-------------- plugin specific -------------"
nmap <silent> <F3> :NERDTreeToggle .<CR>
"nmap <silent> <F4> :NERDTreeToggle ~/src/python/primer-0.1<CR>

"in-buffer terminal
"let g:ConqueTerm_Color = 1
"nmap <silent> <F11> :ConqueTermVSplit bash<CR>
"nmap <silent> <F12> :ConqueTermVSplit ipython<CR>

"java code completion
"if has("autocmd") 
"  autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
"  autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo 
"endif 

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>" 
"let g:SuperTabDefaultCompletionType = "context"

"pydiction code completion - not as good as built-in omnicompletion
"let g:pydiction_location='/Users/john/.vimfiles/ftplugin/pydiction/complete-dict'
source dot-config\_vimrc.local

"-------------- macvim specific -------------"
if has("gui_running")
  set guioptions=egmt
  colorscheme gentooish
  "colorscheme mustang
  "set transparency=30
  set guifont=Ubuntu_Mono:h13
  set backupdir=C:\tmp\vim
  "run fullscreen on startup
  "set fuoptions=maxvert,maxhorz
  au GUIEnter * simalt ~x
  set guioptions-=m
endif
