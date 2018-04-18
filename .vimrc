"====[ gergap's Vim Configuration ]======================================
" note, that I'm working on German keyboard
" change this to your needs
"========================================================================

"====[ some basic editor settings ]======================================
set expandtab       " always use spaces instead of tabs
set tabstop=4       " if there are tabs display them with 4 spaces
set softtabstop=4   " this way backspace will remove the 'virtual' tab
set shiftwidth=4    " intend with 4 spaces
set backspace=2     " make backspace working as expected
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
set norelativenumber
set cursorline
" enable syntax highlighting
syntax on
" Always show at least one line above and below cursor
if !&scrolloff
    set scrolloff=1
endif
" The same for side scrolling
if !&sidescrolloff
    set sidescrolloff=5
endif
" See :h 'display' for an explanation of this
set display+=lastline
" enable filetype
filetype plugin indent on
" font selection
if has("win32")
    " Notes on Windows: You need to install gvim74.exe, python2.7.8 and ctags.
    " ctags zip contains a pre-built ctags.exe. Just put it into next to
    " gvim.exe, so it will be found.
    set gfn=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
    " disable clang_complete on Windows
    let g:clang_complete_loaded = 1
elseif has("gui_running")
    " gvim
    "set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ Bold\ 12
    set gfn=Hack\ 12
else
    " console vim in 256 color terminal
    "set t_Co=256
endif
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden
" configur external text formatter
set formatprg=par-format\ -w78

" disable clang_complete
"let g:clang_complete_loaded = 1
" add custom tags files
"set tags+=/home/gergap/work/devel/uasdkc/.git/tags
"set tags+=/home/gergap/work/devel/uasdkc/.git/modules/src/uaclient/uaclientc/tags
"set tags+=/home/gergap/work/devel/uasdkc/.git/modules/src/uastack/tags
"set tags+=/home/gergap/work/devel/uasdkc/.git/modules/src/uabase/uabasec/tags
"set tags+=/home/gergap/work/devel/uasdkc/.git/modules/src/uaserver/uaserverc/tags

"=====[ Allow saving of files with sudo ]================================
cmap w!! w !sudo tee > /dev/null %

"=====[ enable vundle plugin manager ]===================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'gioele/vim-autoswap'
Plugin 'gergap/vim-konsole'
Plugin 'gergap/vim-latexview'
Plugin 'gergap/gergap'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'asenac/vim-airline-loclist'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/taglist.vim'
"Plugin 'vim-scripts/ShowMarks'
Plugin 'godlygeek/tabular'
Plugin 'Townk/vim-autoclose'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-scripts/calendar.vim--Matsumoto'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'gergap/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rhysd/vim-grammarous'
Plugin 'vim-scripts/valgrind.vim'
Plugin 'vim-scripts/let-modeline.vim'
call vundle#end()

" configure colorscheme: autodected correct colorscheme depending on env
" variable that is set in KDE Konsole Profile
let cs=$colorscheme
if cs == "SolarizedDark"
    colorscheme solarized
    set background=dark
elseif cs == "SolarizedLight"
    colorscheme solarized
    set background=light
else
    set background=dark
    "colorscheme gergap
    "colorscheme desert
    colorscheme PaperColor
    set background=light
    "let g:airline_theme='papercolor'
endif

" disable vim-lldb
"let g:loaded_lldb=1
let g:lldb_map_Lbreakpoint = "<f9>"
let g:lldb_map_Lstep = "<f10>"
let g:lldb_map_Lnext = "<f11>"
let g:lldb_map_Lfinish = "<f12>"

nnoremap <S-F12> :call <sid>togglebackground()<cr>
function! s:togglebackground()
    if &background == "light"
        set background = "dark"
    else
        set background = "light"
    endif
endfunction

"=====[ valgrind plugin ]============================
let g:valgrind_arguments='--leak-check=yes --num-callers=500 --show-leak-kinds=all --track-origins=yes'

"====[ setup my CUPS printer ]===========================================
" you can simply print using :ha(rdcopy)
" this also supports an optional range argument, see :h ha
set pdev=MFC9142CDN

"====[ map leader ]======================================================
let mapleader="-"
let maplocalleader="-"

"====[ hotkey for toggling relative line numbers ]=======================
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>r :call NumberToggle()<cr>

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
" the normal Vim way is to use ColorColumn
"set colorcolumn=81
" Trick from Damian Conway: highlight 81 columns,
" but only for lines that are too long.
" this is less intrusive than showing it for all lines
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)
" I also find this highlight bubbles distracting, so I now use another trick.
" I use a complete color area with just a slightly different background color.
" The color is configured in my wombat256 color scheme.
execute "set colorcolumn=" . join(range(81,180), ',')

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
"nmap <Left> <Nop>
"nmap <Right> <Nop>
"nmap <Up> <Nop>
"nmap <Down> <Nop>

"====[ use my own make script ]==========================================
set makeprg=mk

"====[ map :Q to :q ]====================================================
" It happens so often that I type :Q instead of :q that it makes sense to make
" :Q just working. :Q is not used anyway by vim.
command! Q q

"====[ YCM plugin ]======================================================
let g:ycm_key_list_select_completion = ['<C-Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-Tab>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-Tab>'
" use ctags files
let g:ycm_collect_identifiers_from_tags_files = 1
" When set to 1, the OmniSharp server will be automatically started (once per
" Vim session) when you open a C# file.
let g:ycm_auto_start_csharp_server = 0
" only show popup when hitting (super)tab, this is less intrusive
let g:ycm_auto_trigger = 1
" disable confirmation for loading extra conf
let g:ycm_confirm_extra_conf = 0
" always populate location list
let g:ycm_always_populate_location_list = 1
" debug output
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_server_use_vim_stdout = 1
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction
function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction
augroup mycm
    au!
    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
augroup END

"====[ ShowMarks plugin ]================================================
" reduce shows marks to I need. The default is
"let s:all_marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""
let g:showmarks_include="abcdefghijklmnopqrstuvwxyz.[]<>"

"====[ Autoclose plugin ]================================================
" fix issue of autoclose with YCM. See
" https://github.com/Valloric/YouCompleteMe/issues/9
let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}
" Disable expand space, I don't need it and this would overload <SPACE>
" which conflicts with Vim abbreviation
let g:AutoCloseExpandSpace = 0

"====[ UltiSnips plugin ]================================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsListSnippets="<c-e>"

"====[ superTab plugin ]=================================================
" uncomment the next line to disable superTab
"let loaded_supertab = 1
"set completeopt=menu,longest
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabLongestHighlight=1
"let g:SuperTabLongestEnhanced=1

"====[ Taglist plugin ]==================================================
let Tlist_WinWidth = 40
let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1

"====[ airline ]=========================================================
" use powerline fonts to show beautiful symbols
let g:airline_powerline_fonts = 1
" enable tab bar with buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#loclist#enabled = 1
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

"====[ KDbg launcher ]===================================================
let g:workdir="/home/gergap/work/devel/embeddedstack/bin"
"let g:target="/home/gergap/work/devel/embeddedstack/bin/xml2bin"
"let g:args="-i0:ua -o ns0.ua Opc.Ua.NodeSet2.xml"
let g:target="/home/gergap/work/devel/embeddedstack/bin/uaserverhp"
let g:args=""

" run target in debugger
function! g:ExecuteKDbg()
    if exists("g:target")
        "execute "!kdbg ".g:target
        execute "!nemiver ".g:target
    else
        echo "No target is defined. Please execute 'let g:target=\"<your target>\"'"
    endif
endfunction

" run target without debugging
function! g:RunTarget()
    if exists("g:target")
        let s:dir=getcwd()
        if exists("g:workdir")
            exe "cd ".g:workdir
        endif
        execute "!".g:target g:args
        exe "cd ".s:dir
    else
        echo "No target is defined. Please execute 'let g:target=\"<your target>\"'"
    endif
endfunction

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
let g:DoxygenToolkit_interCommentTag = "* "

"====[ make use of F-keys ]==============================================
" unindent with Shift-Tab
imap <S-Tab> <C-o><<
" use F2 for saving
nnoremap <F2> :w<cr>
inoremap <F2> <esc>:w<cr>i
" map F3 and SHIFT-F3 to toggle spell checking
nmap <F3> :setlocal spell spelllang=de,en<CR>:syntax spell toplevel<CR>
imap <F3> <ESC>:setlocal spell spelllang=en,de<CR>i:syntax spell toplevel<CR>
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
function! Build()
    if &modified == 1
        " save current changed buffer
        normal :w<CR>
    endif
    "execute "make clean"
    execute "make all"
endfunction

"nnoremap <F7> :silent :wa<cr>:make<cr>
nnoremap <F7> :call Build()<CR>
" build using makeprg with <F7>
"nmap <F7> :w<CR>:make<CR>
nmap <F7> :call Build()<CR>
imap <F7> <ESC>:w<CR>:make<CR>
" clean build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" Simple hexify/unhexify
noremap <F8> :call <sid>Hexify()<CR>
" Apply YCM FixIt
map <F9> :YcmCompleter FixIt<CR>
" remove trailing spaces
map <F10> :%s/\s\+$//<CR>
" run kdbg
nmap <leader>d :call ExecuteKDbg()<CR>
nmap <leader>x :call RunTarget()<CR>
nmap <leader>v :exec("Valgrind ".g:target." ".g:args)<CR>
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" prefer vertical diff
set diffopt+=vertical
" in diff mode we use the spell check keys for merging
nnoremap <expr> <M-Down>  &diff ? ']c' : &spell ? ']s' : ':cn<cr>'
nnoremap <expr> <M-Up>    &diff ? '[c' : &spell ? '[s' : ':cp<cr>'
nnoremap <expr> <M-Left>  &diff ? 'do' : ':bp<cr>'
nnoremap <expr> <M-Right> &diff ? 'dp' : ':bn<cr>'
" spell settings
"  :setlocal spell spelllang=en
" set the spellfile - folders must exist
" global wordlist, press zg to add a word to the list
set spellfile=~/.vim/spellfile.add
" project specific ignore list, press 2zg to add a word to this ignore list
set spellfile+=ignore.utf-8.add

"====[ Ctrl-P plugin         ]===========================================
nnoremap <leader>t :CtrlPTag<cr>

"====[ NERDTree plugin       ]===========================================
nnoremap <leader>n :NERDTreeToggle<cr>

"====[ indentLines plugin    ]===========================================
let g:indentLine_enabled = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'

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

"====[ hexify/unhexify using Vim's built-in xxd commend ]================
function! s:Hexify()
    " we need to ensure that Vim doesn't add garbage to the binary file
    set binary "use binary mode
    set noeol  "disable adding EOL
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunc
function! EscapeText(text)

    let l:escaped_text = a:text

    " Map characters to named C backslash escapes. Normally, single-quoted
    " strings don't require double-backslashing, but these are necessary
    " to make the substitute() call below work properly.
    "
    let l:charmap = {
    \   '"'     : '\\"',
    \   "'"     : '\\''',
    \   "\n"    : '\\n',
    \   "\r"    : '\\r',
    \   "\b"    : '\\b',
    \   "\t"    : '\\t',
    \   "\x07"  : '\\a',
    \   "\x0B"  : '\\v',
    \   "\f"    : '\\f',
    \   }

    " Escape any existing backslashes in the text first, before
    " generating new ones. (Vim dictionaries iterate in arbitrary order,
    " so this step can't be combined with the items() loop below.)
    "
    let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')

    " Replace actual returns, newlines, tabs, etc., with their escaped
    " representations.
    "
    for [original, escaped] in items(charmap)
        let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
    endfor

    " Replace any other character that isn't a letter, number,
    " punctuation, or space with a 3-digit octal escape sequence. (Octal
    " is used instead of hex, since octal escapes terminate after 3
    " digits. C allows hex escapes of any length, so it's possible for
    " them to run up against subsequent characters that might be valid
    " hex digits.)
    "
    let l:escaped_text = substitute(l:escaped_text,
    \   '\([^[:alnum:][:punct:] ]\)',
    \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
    \   'g')

    return l:escaped_text

endfunction


function! PasteEscapedRegister(where)

    " Remember current register name, contents, and type,
    " so they can be restored once we're done.
    "
    let l:save_reg_name     = v:register
    let l:save_reg_contents = getreg(l:save_reg_name, 1)
    let l:save_reg_type     = getregtype(l:save_reg_name)

    echo "register: [" . l:save_reg_name . "] type: [" . l:save_reg_type . "]"

    " Replace the contents of the register with the escaped text, and set the
    " type to characterwise (so pasting into an existing double-quoted string,
    " for example, will work as expected).
    "
    call setreg(l:save_reg_name, EscapeText(getreg(l:save_reg_name)), "c")

    " Build the appropriate normal-mode paste command.
    "
    let l:cmd = 'normal "' . l:save_reg_name . (a:where == "before" ? "P" : "p")

    " Insert the escaped register contents.
    "
    exec l:cmd

    " Restore the register to its original value and type.
    "
    call setreg(l:save_reg_name, l:save_reg_contents, l:save_reg_type)

endfunction
" Define keymaps to paste escaped text before or after the cursor.
"
nmap <Leader>P :call PasteEscapedRegister("before")<cr>
nmap <Leader>p :call PasteEscapedRegister("after")<cr>

function! KeyLoggerEnable()
    augroup logger
        autocmd!
        autocmd VimEnter * :call system('$HOME/vim/enable_logger')
        autocmd VimLeave * :call system('$HOME/vim/disable_logger')
        autocmd InsertEnter * :call system('$HOME/vim/insert_enter')
        autocmd InsertLeave * :call system('$HOME/vim/insert_leave')
    augroup END
endfunction

function! KeyLoggerDisable()
    augroup logger
        autocmd!
    augroup END
endfunction

" change cursor shape in KDE4 konsole
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Syntax highlight debugging: this function is from the Vim Manual
function! ShowSyntaxStack()
    for id in synstack(line("."), col("."))
        echo synIDattr(id, "name")
    endfor
endfunction
map <leader>s :call ShowSyntaxStack()<cr>

" Make views automatic: http://vim.wikia.com/wiki/VimTip991
augroup MakeViewAutomatic
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview 
augroup end

function! Enum2Array()
    let l:autoclose=b:AutoCloseOn
    " disable autoclose
    let b:AutoCloseOn=0
    exe "normal! :'<,'>g/^\\s*$/d\n"
    exe "normal! :'<,'>s/\\(\\s*\\)\\([[:alnum:]_]*\\).*/\\1[\\2] = \"\\2\",/\n"
    normal `>
    exe "normal a\n};\n"
    normal ==
    normal `<
    exe "normal iconst char *[] =\n{\n"
    " try some indentation
    exe ":'<,'>normal =="
    normal `>j==
    " set the cursor at the top
    normal `<
    " restore autoclose
    let b:AutoCloseOn=l:autoclose
    normal f[
endfunction
map <leader>e <esc>:call Enum2Array()<cr>

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
endfunction
"let g:grammarous#languagetool_cmd = '/home/gergap/Documents/Latex/detex-languagetool.py'

let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*


