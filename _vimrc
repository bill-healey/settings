set autoindent              " always set autoindenting on
set autoread                " Reload files when they are changed by another process
set backupdir=~/.vimtmp,.
set cindent                 " use cindent
set completeopt=menuone,longest,preview     " Insert completion$
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set directory=~/.vimtmp,.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
set foldlevel=99            " don't fold by default
set foldmethod=indent       " allow us to fold on indents
set history=1000
set history=1000
set hlsearch                " Highlight searches by default.
set ignorecase              " Default to using case insensitive searches,
set incsearch               " Incrementally search while typing a /regex
set laststatus=2
set linebreak               " don't wrap textin the middle of a word
set magic
set matchpairs+=<:>         " show matching <> (html mainly) as well
set nocompatible
set noerrorbells
set noerrorbells                            " don't bell or blink
set nosmartindent           " don't use deprecated smart indent if there is no indent file
set nostartofline           " Avoid moving cursor to BOL when jumping around
set novisualbell
set nowrap                  " don't wrap text
set pumheight=6                             " Keep a small completion window
set report=0                " : commands always print changed line count.
set ruler                   " show the cursor position all the time
set scrolloff=3             " Keep 3 context lines above and below the cursor
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set shiftround              " rounds indent to a multiple of shiftwidth
set shiftwidth=4            " but an indent level is 2 spaces wide.
set showcmd                 " Show incomplete normal mode commands as I type.
set showmatch
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set so=3
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%{fugitive#statusline()}%c,%l/%L\ %P
set tabstop=4               " <tab> inserts 4 spaces-
set title
set title                                   " show title in console title bar
set titleold=hostname()
set titlestring=VIM:\ %F
set vb t_vb=
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set wildignore+=*.egg-info/**
set wildignore+=*.o,*.obj,.git,*.pyc        " Ignore these files when completing
set wildignore+=eggs/**
set wildmenu                                " Menu completion in command mode on <Tab>
set wildmode=full                           " <Tab> cycles between all matching choices.

syntax on
colorscheme torte
call pathogen#infect()


" ==========================================================
" Key Mappings
" ==========================================================

" Leader-based mappings
let mapleader=","             " change the leader to be a comma vs slash

" Open NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Open Gundo
nnoremap <leader>g :GundoToggle<CR>

" Open Quickfix
nnoremap <leader>q :copen<CR>

" Open Git status
nnoremap <leader>s :Gstatus<CR>

" Open Git diff
nnoremap <leader>d :Gdiff<CR>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Set pasted with leader p
nnoremap <leader>p :set paste<CR>

" Close current file with leader c
nnoremap <leader>c :close<CR>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Map ctrl-movement keys to window switching
nnoremap <leader>w :wincmd w<cr>
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

nnoremap j gj
nnoremap k gk

nnoremap <S-h> ^
nnoremap <S-k> 10k
nnoremap <S-j> 10j
nnoremap <S-l> $
nnoremap <TAB> =j<CR>

nnoremap <C-n> :tabn<CR>
nnoremap <C-p> :tabp<CR>

command! W :w
cmap w!! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>


" ==========================================================
" Plugin Settings
" ==========================================================

" Pyflakes settings
let g:pyflakes_use_quickfix = 0
let g:acp_completeoptPreview=1

" Syntastic settings
let g:syntastic_python_checker_args = "--ignore=E501"
let g:syntastic_check_on_open=1

" NERDTree settings
let NERDChristmasTree=1
let NERDTreeQuitOnOpen=1
let NERDTreeDirArrows=0
let NERDTreeCascadeOpenSingleChildDir=1
let NERDTreeHighlightCursorline=1
let NERDTreeMapOpenInTab='<CR>'

"Reload .vimrc whenever it is edited
autocmd! bufwritepost .vimrc source ~/.vimrc 

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" ==========================================================
" Javascript
" ==========================================================
au BufRead *.js set makeprg=jslint\ %

" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"


" ===========================================================
" FileType specific changes
" ============================================================
" Mako/HTML
filetype plugin on
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css,js setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent nocindent noautoindent

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 nosmartindent cindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

