"====[ gergap's Vim Configuration ]======================================
" note, that I'm working on German keyboard
" change this to your needs
"========================================================================

"====[ some basic editor settings ]======================================
set expandtab       " always use spaces instead of tabs
set tabstop=4       " if there are tabs display them with 4 spaces
set softtabstop=4   " this way backspace will remove the 'virtual' tab
set shiftwidth=4    " intend with 4 spaces
" intend wrapped text and show the ">" symbol. The three spaces intend
" the text, which often fits text that I write.
exec "set showbreak=\u21AA\\ \\ \\ "
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" enable cindent
set cindent
set cinoptions+=:0,g0
" enable line numbers
set number
" enable syntax highlighting
syntax on
" enable filetype
filetype plugin indent on
" font selection
if has("win32")
    " Notes on Windows: You need to install gvim74.exe, python2.7.8 and ctags.
    " ctags zip contains a pre-built ctags.exe. Just put it into next to
    " gvim.exe, so it will be found.
    " make backspace working as expected
    set backspace=2
    colorscheme wombat
    set gfn=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
    " diable clang_complete on Windows
    let g:clang_complete_loaded = 1
elseif has("gui_running")
    colorscheme wombat
    set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ Bold\ 11
else
    set t_Co=256
    colorscheme wombat256
endif
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden
" configur external text formatter
set formatprg=par-format\ -w78

"=====[ enable pathogen vim package manager ]============================
execute pathogen#infect()

"=====[ enable solarized colorscheme        ]============================
colorscheme solarized
nnoremap <leader><F12> :call <sid>togglebackground()<cr>
function! s:togglebackground()
    if &background == "light"
        let &background = "dark"
    else
        let &background = "light"
    endif
endfunction

"====[ setup my CUPS printer ]===========================================
" you can simply print using :ha(rdcopy)
" this also supports an optional range argument, see :h ha
set pdev=HP_Officejet_Pro_8600

"====[ map leader ]======================================================
let mapleader="-"
let maplocalleader="-"

"====[ make edit vim config easys ]======================================
nnoremap <leader>ev :split $MYVIMRC<cr>
" auto reload when config has changed
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"====[ make naughty characters visible ]=================================
exec "set listchars=tab:\u25B6\\ ,trail:\uB7,nbsp:~"
set list

"====[ highlight 81 column ]=============================================
" but only for lines that are too long.
" this is less intrusive than showing it for all lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"====[ enable higlight search ]==========================================
set incsearch
set hlsearch
" This rewires n and N to do the highlighting...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>
" clear last search to remove all highlightings
nnoremap <leader>c :let @/ = ""<cr>

" this makes the current selected word better visible
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
endfunction

"====[ Esc insert mode by pressing jk ]==================================
" this avoids moving my left hand to the esc key which is far away.
" jk is not used normally in english or german language and I key leave my
" hand on the navigation keys.
:inoremap jk <esc>

"====[ surround word with quotes ]=======================================
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"====[ map Y to y$ ]=====================================================
" from the help: If you like "Y" to work from the cursor to the end of line
" (which is more logical, but not Vi-compatible) use ":map Y y$".
:nnoremap Y y$

"====[ comment out current line ]========================================
augroup Comment
    autocmd!
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
augroup END

"====[ Damian Convay's vmath plugin ]====================================
vnoremap <expr> ++  VMATH_YankAndAnalyse()
nmap            ++  vip++
set noshowmode

"====[ Damian Convay's digraph plugin ]==================================
" disable betterdigraph
"let loaded_betterdigraphs = 1
"inoremap <expr>  <C-K>   HUDG_GetDigraph()
inoremap <expr>  <C-K>   BDG_GetDigraph()

"=====[ Make arrow keys move visual blocks around ]======================
runtime plugin/dragvisuals.vim

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
vmap  <expr>  <C-D>    DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

"=====[ tabularize plugin ]==============================================
"if exists(":Tabularize")
if 1
    nnoremap <leader>a= :Tabularize /=<cr>
    vnoremap <leader>a= :Tabularize /=<cr>
    nnoremap <leader>a: :Tabularize /:\zs<cr>
    vnoremap <leader>a: :Tabularize /:\zs=<cr>
    nnoremap <leader>a& :Tabularize /&<cr>
    vnoremap <leader>a& :Tabularize /&<cr>
else
    echom "Tabularize not available"
endif

" automatically invoke s:align when | is typed
inoremap <bar> <bar><esc>:call <sid>align()<cr>a
" automatically indend latex tabular envireonments
augroup MyLaTeX
    autocmd!
    autocmd FileType tex inoremap <buffer> & &<esc>:call <sid>align_tabular()<cr>a
augroup END

" tabularize | helper function
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize')
    if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  else
    echom "no tabularize"
  endif
endfunction

" tabularize latex tabular helper
" this is the same idea as above, but for & instead of |
function! s:align_tabular()
  let p = '^.*&.*&*$'
  if exists(':Tabularize')
    if getline('.') =~# '^[^&]*&' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^&]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*&\s*\zs.*'))
        echom position
        Tabularize/&/l1
        normal! 0
        call search(repeat('[^&]*&',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  else
    echom "no tabularize"
  endif
endfunction

"====[ learn hjkl the hard way ;-) ]=====================================
nmap <Left> <Nop>
nmap <Right> <Nop>
nmap <Up> <Nop>
nmap <Down> <Nop>

"====[ use my own make script ]==========================================
set makeprg=mk

"====[ map :Q to :q ]====================================================
" It happens so often that I type :Q instead of :q that it makes sense to make
" :Q just working. :Q is not used anyway by vim.
command! Q q

"====[ UltiSnips plugin ]================================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"

"====[ superTab plugin ]=================================================
" uncomment the next line to disable superTab
"let loaded_supertab = 1
set completeopt=menu,longest
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabLongestHighlight=1
let g:SuperTabLongestEnhanced=1

"====[ clang plugin ]====================================================
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib"
let g:clang_snippets = 1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_complete_auto=1
let g:clang_periodic_quickfix=0
set conceallevel=2
set concealcursor=vin
" Limit popup menu height
set pumheight=20

"====[ Taglist plugin ]==================================================
let Tlist_WinWidth = 40

"====[ airline ]=========================================================
" use powerline fonts to show beautiful symbols
let g:airline_powerline_fonts = 1
" enable tab bar with buffers
let g:airline#extensions#tabline#enabled = 1
" fix the timout when leaving insert mode (see
" http://usevim.com/2013/07/24/powerline-escape-fix)
if ! has('gui_running')
  set ttimeoutlen=100
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

"====[ fugitive vim plugin ]=============================================
set laststatus=2
"set statusline=%{GitBranch()}

"====[ DoxygenToolKit ]==================================================
" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
let g:DoxygenToolkit_startCommentTag = "/**"
let g:DoxygenToolkit_startCommentBlock = "/*"
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>"
"let g:DoxygenToolkit_licenseTag="My own license"
let g:DoxygenToolkit_interCommentTag = "*"

"====[ make use of F-keys ]==============================================
" unindent with Shift-Tab
imap <S-Tab> <C-o><<
" use F2 for saving
nnoremap <F2> :w<cr>
inoremap <F2> <esc>:w<cr>i
" map F3 and SHIFT-F3 to toggle spell checking
nmap <F3> :setlocal spell spelllang=en<CR>
imap <F3> <ESC>:setlocal spell spelllang=en<CR>i
nmap <S-F3> :setlocal nospell<CR>
imap <S-F3> <ESC>:setlocal nospell<CR>i
" switch between header/source with F4 in C/C++ using a.vim
nmap <F4> :A<CR>
imap <F4> <ESC>:A<CR>i
" currently S-F4 does not work in KDE konsole. Don't know why.
nmap <S-F4> :AV<CR>
imap <S-F4> <ESC>:AV<CR>i
" recreate tags file with F5
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
nnoremap <F7> :make<cr>
" build using makeprg with <F7>
nmap <F7> :make<CR>
imap <F7> <ESC>:w<CR>:make<CR>
" clean build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" remove trailing spaces
map <F10> :%s/\s\+$//<CR>
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  nnoremap <M-Down> ]c
  nnoremap <M-Up> [c
  nnoremap <M-Left> do
  nnoremap <M-Right> dp
  nnoremap <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
"  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  " global wordlist, press zg to add a word to the list
  set spellfile=~/.vim/spellfile.add
  " project specific ignore list, press 2zg to add a word to this ignore list
  set spellfile+=ignore.utf-8.add
  nnoremap <M-Down> :call <sid>NextError()<cr>
  nnoremap <M-Up> :call <sid>PreviousError()<cr>
  " buffer switching with Alt-Left/Right
  nnoremap <M-Left> :bp<cr>
  nnoremap <M-Right> :bn<cr>
endif

" jump to next (spell|quickfix) error
function! s:NextError()
  if (&spell)
      normal ]s
  else
      cNext
  endif
endfunction

" jump to previous (spell|quickfix) error
function! s:PreviousError()
  if (&spell)
      normal [s
  else
      cprevious
  endif
endfunction


"====[ Ctrl-P plugin         ]===========================================
nnoremap <leader>t :CtrlPTag<cr>

"====[ distraction free mode ]===========================================
" a primitive approach to create a distraction free mode
" this can be helpful e.g. when writing prosa like Markdown files.
" augroup DFM
"     autocmd!
"     autocmd FileType markdown call <sid>ToggleFocusMode()
" augroup END
function! s:ToggleFocusMode()
    if (&foldcolumn != 12)
        set laststatus=0
        set numberwidth=10
        set foldcolumn=12
        set noruler
        hi FoldColumn ctermbg=none
        hi LineNr ctermfg=0 ctermbg=none
        hi NonText ctermfg=0
    else
        set laststatus=2
        set numberwidth=4
        set foldcolumn=0
        set ruler
        execute 'colorscheme ' . g:colors_name
    endif
endfunc
nnoremap <buffer> <F1> :call <sid>ToggleFocusMode()<cr>

"====[ resize split windows ]============================================
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"====[ add function to add support for unit test output ]================
function! Unittest()
    set makeprg=./bin/test_list
    set efm=\%EFAIL!\ \ :\ %m,%-GPASS%.%#,%+C\ \ \ Actual%.%#,%+C\ \ \ Expected%.%#,%+Z\ \ \ Loc:\ %[%f(%l%.%.
endfunction

"====[ add convenience function for underlining text ]===================
" this is useful for markdown headers level 1 and 2
function! Header1()
    normal yypv$r=
endfunction
function! Header2()
    normal yypv$r-
endfunction
nnoremap <silent> <Leader>U :call Header1()<CR>
nnoremap <silent> <Leader>u :call Header2()<CR>

