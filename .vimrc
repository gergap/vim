" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"
" auto reload .vimrc when changed, this avoids reopening vim
autocmd! bufwritepost .vimrc source %
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
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" define ',' is leader key
let mapleader = ","
" turn syntax highlighting on
syntax on
if has("gui_running")
    colorscheme wombat
    set gfn=DejaVu_Sans_Mono:h10:cANSI
else
    set t_Co=256
    colorscheme wombat256
endif
" Make backspace working on Windows
if has("win32")
    set bs=2
endif
" show textwidth line
set colorcolumn=120
highlight ColorColumn ctermbg=236
" show trailing whitespaces
match ExtraWS /\s\+$/
" highlight all search results
set hlsearch
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden

" It happens so oftern that I type :Q instead of :q that it makes sense to make :Q just working. :Q is not used
" anyway by vim.
command Q q

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" superTab
" uncomment the next line to disable superTab
"let loaded_supertab = 1

set completeopt=menu,longest
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabLongestHighlight=1
let g:SuperTabLongestEnhanced=1

" clang-complete
filetype plugin on
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib64/llvm"
let g:clang_snippets = 1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_complete_auto=1
let g:clang_periodic_quickfix=0
set conceallevel=2
set concealcursor=vin
" Limit popup menu height
set pumheight=20

" vim-git plugin
set laststatus=2
"set statusline=%{GitBranch()}

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>"
"let g:DoxygenToolkit_licenseTag="My own license"
let g:DoxygenToolkit_interCommentTag = "*"

" Enhanced keyboard mappings
"
" unindent with Shift-Tab
imap <S-Tab> <C-o><<
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" map F3 and SHIFT-F3 to toggle spell checking
nmap <F3> :setlocal spell spelllang=en<CR>
imap <F3> <ESC>:setlocal spell spelllang=en<CR>i
nmap <S-F3> :setlocal spell spelllang=<CR>
imap <S-F3> <ESC>:setlocal spell spelllang=<CR>i
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
" build using makeprg with <F7>
nmap <F7> :make<CR>
" build using makeprg with <F7>, in insert mode exit to command mode, save and compile
imap <F7> <ESC>:w<CR>:make<CR>
" build using makeprg with <S-F7>
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
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
"  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  " global wordlist, press zg to add a word to the list
  set spellfile=~/.vim/spellfile.add
  " project specific ignore list, press 2zg to add a word to this ignore list
  set spellfile+=ignore.utf-8.add
  map <M-Down> ]s
  map <M-Up> [s
endif

" Taglist
let Tlist_WinWidth = 40

" airline
" use powerline fonts to show beautiful symbols
let g:airline_powerline_fonts = 1
" enable tab bar with buffers
let g:airline#extensions#tabline#enabled = 1
" fix the timout when leaving insert mode (see http://usevim.com/2013/07/24/powerline-escape-fix)
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=10
  augroup END
endif

" pathogen
execute pathogen#infect()

" my macros
" surround variable name with ${...}
let @s='bi${ea}'
" implement method. Turns 'int foo();' into 'int foo()\n{\n}\n'

"au! Syntax mixed  so $vim/syntax/cmix.vim

