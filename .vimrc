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

" clang-complete
filetype plugin on
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib64/llvm"
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
set conceallevel=2
set concealcursor=vin

" Complete options (disable preview scratch window, longest removed to aways
" show menu)
set completeopt=menu,menuone

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
map <F4> :A<CR>
map <S-F4> :AV<CR>
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
" macro recording
nmap <S-F8> qq
nmap <F8> @q
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
  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif

" template functionality
function! CreateHeaderFile()
    silent! 0r ~/.vim/skel/templ.h
    silent! exe "%s/%INCLUDEPROTECTION%/__".toupper(expand("<afile>:r"))."_H__/g"
endfunction

function! CreateCSourceFile()
    if expand("<afile>") == "main.c"
        return
    endif
    silent! 0r ~/.vim/skel/templ.c
    " :r removes file extension
    silent! exe "%s/%FILE%/".expand("<afile>:r").".h/g"
endfunction

autocmd BufNewFile main.c 0r ~/.vim/skel/main.c
autocmd BufNewFile main.cpp 0r ~/.vim/skel/main.cpp
autocmd BufNewFile *.c call CreateCSourceFile()
autocmd BufNewFile *.h call CreateHeaderFile()

" Abbreviations
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc
iab #i #include <><left><C-R>=EatChar('\s')<CR>
iab #I #include ""<left><C-R>=EatChar('\s')<CR>
iab forl for(i=0; i<; i++) {<CR><CR>}<UP><RIGHT><RIGHT><RIGHT><C-R>=EatChar('\s')<CR>

" Taglist
let Tlist_WinWidth = 40

" airline
let g:airline_powerline_fonts = 1

" pathogen
execute pathogen#infect()

" my macros
" surround variable name with ${...}
let @s='bi${ea}'
" implement method. Turns 'int foo();' into 'int foo()\n{\n}\n'
let @i='A€kb{}j'

