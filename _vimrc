" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"if &term == 'xterm' || &term == 'screen'
    "set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
"endif

call pathogen#infect()
call pathogen#helptags()

" use system clipboard
set clipboard=unnamedplus

" No Help, please
nmap <F1> <Esc>

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" allow switching buffers without saving
set hidden

" don't jump to the start of the line when switching buffers
set nostartofline

" better leader
let mapleader = ","

" Switch syntax highlighting on
syntax on

" colorscheme
"let g:solarized_termcolors=256
let g:solarized_termcolors=256
set background=dark
colorscheme molokai
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=232 guibg=#2c2d27
highlight Normal ctermbg=Black ctermfg=White guifg=White guibg=Black

" insert cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ack support
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" allows us to set project folders for ctrlp
let g:ctrlp_root_markers = ['.project'] 

" easier esc from insert
imap jj <Esc>

" up and down sane when on word wrapped lines
nnoremap j gj
nnoremap k gk

" window navigation
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" shortcut for Ack
map <leader>f :Ack -Q<Space>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" stop vim putting tmp files all over the place
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" python support
" --------------
"  don't highlight exceptions and builtins. I love to override them in local
"  scopes and it sucks ass if it's highlighted then. And for exceptions I
"  don't really want to have different colors for my own exceptions ;-)
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
\ formatoptions+=cq softtabstop=4
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType php setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" template language support (SGML / XML too)
" ------------------------------------------
" and disable that stupid html rendering (like making stuff bold etc)
fun! SelectHTML()
  let n = 1
  while n < 50 && n < line("$")
    " check for jinja
    if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=jinja
      return
    endif
    " check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
    " check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.html,*.htm  call SelectHTML()
let html_no_rendering=1

" html etc
" autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
" autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" ColdFusion
autocmd FileType cf setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
\ formatoptions+=cq autoindent

" CSS
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" markdown
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md setlocal ft=markdown
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" vim
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 formatoptions-=ro
let javascript_enable_domhtmlcss=1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.svg,*.pdf,*.xls,.DS_Store,*/tinymce/*,*.png,*.jpg,*.gif

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

