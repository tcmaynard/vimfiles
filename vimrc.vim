"
" This is standard pathogen and vim setup
"
set nocompatible
filetype off
set t_Co=256

source $VIMRUNTIME/mswin.vim

call pathogen#helptags()
call pathogen#infect()

filetype plugin indent on
syntax on

" Change the mapleader from \ to ,
let mapleader=","

" Use semicolon as a "shortcut" (unshifted) colon key
nnoremap ; :
nnoremap : ;

" Quickly close the current window
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Damian Conway's "Instantly Better Vim" stuff {{{
"
"============================================================================
" Make :help appear in a full-screen tab, instead of a window
"============================================================================

  "Only apply to .txt files...
  augroup HelpInTabs
      autocmd!
      autocmd BufEnter  *.txt   call HelpInNewTab()
  augroup END

  "Only apply to help files...
  function! HelpInNewTab ()
      if &buftype == 'help'
          "Convert the help window to a tab...
          execute "normal \<C-W>T"
      endif
  endfunction

"============================================================================
" Make % match angle brackets as well (including Euro-brackets)
"============================================================================

    set matchpairs+=<:>


"====[ Make the 81st column stand out ]====================

"    " EITHER the entire 81st column, full-screen...
"    highlight ColorColumn ctermbg=magenta
"    set colorcolumn=81
 
  " OR ELSE just the 81st column of wide lines...
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%81v', 100)
 
"=====[ Highlight matches when jumping to next ]=============
 
  " This rewires n and N to do the highlighing...
  nnoremap <silent> n   n:call HLNext(0.4)<cr>
  nnoremap <silent> N   N:call HLNext(0.4)<cr>
 
    " OR ELSE ring the match in red...
  function! HLNext (blinktime)
      highlight RedOnRed ctermfg=red ctermbg=red
      let [bufnum, lnum, col, off] = getpos('.')
      let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
      echo matchlen
      let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
              \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
              \ . '\|'
              \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
              \ . '\|'
              \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
      let ring = matchadd('RedOnRed', ring_pat, 101)
      redraw
      exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
      call matchdelete(ring)
      redraw
  endfunction
 
"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
 
  exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
  set list
 
"====[ dragvisuals ]======
 
  runtime plugin/dragvisuals.vim
  vmap  <expr>  h        DVB_Drag('left')
  vmap  <expr>  l        DVB_Drag('right')
  vmap  <expr>  j        DVB_Drag('down')
  vmap  <expr>  k        DVB_Drag('up')
  "vmap  <expr>  D        DVB_Duplicate()
 
  " Remove any introduced trailing whitespace after moving...
  let g:DVB_TrimWS = 1
" }}}
"
" Editing behavior {{{
" Rewrap a long-line file into 80 byte lines
function! LineWrap()
  :setl tw=80 fo=t
  1GVGgq
endfunction

set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=2                   " a tab is four spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
nnoremap <leader>/ :nohlsearch<CR>  " Turn off search highlighting
nnoremap <C-b>  :bn<CR>         " Control-B jumps to next buffer
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
"set listchars=tab:>.,trail:.,extends:#,nbsp:&
"set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid
set cul                         " Highlight the cursor line

"====[ Damian Conway's "Instantly Better Vim" inserts ] ================
"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======
    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" Example of convenience mappings:
map <silent><F7> :NEXTCOLOR<cr>
map <silent><F8> :PREVCOLOR<cr>
map <silent><F9> :SCROLLCOLOR<cr>

" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

" Make the escape key easier to reach
inoremap jj <Esc>
"inoremap <Esc> <Nop>             " For hardcore types

" }}}

" Folding rules {{{

set foldenable			" Enable folding
set foldcolumn=2		" Add a fold column
set foldmethod=marker		" Use triple {
set foldlevelstart=1		" Start all opened up
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' �@' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" }}}

" GUI Appearance {{{

" Airline Settings
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" Set the colorscheme for non/Gui
colorscheme calmar256-dark

hi CursorLine guibg=bg gui=underline ctermbg=darkblue cterm=NONE
nnoremap <C-c> set cursorline<cr>

if has("gui_running")
"    set guifont=Monospace\ 12
"    set guifont=Ubuntu_Mono:h11:cANSI
    set guifont=DejaVU_Sans_Mono_for_Powerline:h11
    set laststatus=2
    set linespace=2
    set lines=29
endif

" }}}

nnoremap <silent><F7> :PREVCOLOR<cr>
nnoremap <silent><F8> :NEXTCOLOR<cr>

" }}}

" NERDTree key mappings {{{
nnoremap <c-n> :NERDTreeToggle<CR>
" }}}

" PowerLine settings {{{

" Disable the cache until I can figure out the Unix/Dos format problem
let g:Powerline_cache_enabled = 0

set laststatus=2		" Always show the status line
set t_Co=256			" Ensure colored status lines
set encoding=utf-8		" Necessary for Unicode glyphs
set termencoding=utf-8

" Default is "compatible" -- "fancy" needs customized font(s)
let g:Powerline_symbols="fancy"
"let g:Powerline_symbols="compatible"
" }}}

" Vim behavior {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/vimfiles/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
set ttyfast                     " always use a fast terminal

" }}}
