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
set nowrap
set nojoinspaces    " avoid double space after dot when joining lines
set splitright
set splitbelow
" intend wrapped text and show the ">" symbol. The three spaces intend
" the text, which often fits text that I write.
exec "set showbreak=\u21AA\\ \\ \\ "
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
set modelines=10
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
    " this is important for vim-fugitive on windows: git tools need to called
    " with forward slash. Install git-bash for Windows and register tools in
    " PATH variable, so that git tools also workin in cmd.exe. This is
    " necessary for Vim, because it starts external tools this way on Windows.
    set shellslash
    " disable clang_complete on Windows
    let g:clang_complete_loaded = 1
    if has("gui_running")
        " Use the Hack font like on Linux
        set gfn=Hack:h12:cANSI:qPROOF
    endif
else
    " Unix/Linux
    if has("gui_running")
        set gfn=Hack\ NF\ 10
    endif
    " console vim in 256 color terminal
    set t_Co=256
endif

" Generic GVim settings
if has("gui_running")
    " disable all this GUIs nonesense to make it less distracting
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=b
endif
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden
" configur external text formatter
set formatprg=par-format\ -w78

" enable titlestring to make vim-autoswap working
set title titlestring=

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
Plugin 'tpope/vim-unimpaired'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'gioele/vim-autoswap'
Plugin 'benmills/vimux'
"Plugin 'gergap/vim-konsole'
Plugin 'gergap/vim-latexview'
Plugin 'gergap/vim-cmake-build'
"Plugin 'gergap/gergap'
Plugin 'NLKNguyen/papercolor-theme'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'asenac/vim-airline-loclist'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
"Plugin 'gergap/ShowMarks'
Plugin 'godlygeek/tabular'
"Plugin 'Townk/vim-autoclose'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-scripts/calendar.vim--Matsumoto'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'gergap/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tenfyzhong/CompleteParameter.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'rhysd/vim-grammarous'
Plugin 'vim-scripts/valgrind.vim'
Plugin 'vim-scripts/let-modeline.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'gergap/refactor'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SidOfc/mkdx'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'rhysd/vim-clang-format'
Plugin 'dhulihan/vim-rfc'
Plugin 'powerman/vim-plugin-AnsiEsc'
call vundle#end()

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 0,
  \       'allow_bold': 1,
  \       'allow_italic': 0
  \     }
  \   }
  \ }

" configure colorscheme: autodetected correct colorscheme depending on env
" variable that is set in KDE Konsole Profile
let cs=$colorscheme
if cs == "SolarizedDark"
    colorscheme solarized
    set background=dark
elseif cs == "SolarizedLight"
    colorscheme solarized
    set background=light
else
    " Use PaperColor by default: switching between light/dark can easily be
    " done using vim-unimpaired 'cob' (change option background)
    set background=dark
    colorscheme PaperColor
    let g:airline_theme='papercolor'
endif

" disable vim-lldb
"let g:loaded_lldb=1
let g:lldb_map_Lbreakpoint = "<f9>"
let g:lldb_map_Lstep = "<f10>"
let g:lldb_map_Lnext = "<f11>"
let g:lldb_map_Lfinish = "<f12>"

"=====[ valgrind plugin ]============================
let g:valgrind_arguments='--leak-check=yes --num-callers=500 --show-leak-kinds=all --track-origins=yes'

"====[ setup my CUPS printer ]===========================================
" you can simply print using :ha(rdcopy)
" this also supports an optional range argument, see :h ha
set pdev=MFC9142CDN

"====[ map leader ]======================================================
let mapleader="\\"
let maplocalleader="\\"

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
highlight ColorColumn ctermbg=235
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

"====[ navigation configuration ]=====================================
" For moving the cursor we use hjkl in Vim, so the cursor keys can be
" used for special actions which are used more rarely than hjkl.
" previous buffer
nmap <Left>     :bp<cr>
" next buffer
nmap <Right>    :bn<cr>
" previous spelling error
nmap <Up>       :[s<cr>
" next spelling error
nmap <Down>     :]s<cr>
" Vim: M-Up/Down to navigate to prev/next compile error
"      M-Left/Right to move between tabs
" VimDiff: M-Up/Down to navigate to prev/next change
"          M-Left/Right to move changes
nnoremap <expr> <M-Down>  &diff ? ']c' : ':cn<cr>'
nnoremap <expr> <M-Up>    &diff ? '[c' : ':cp<cr>'
nnoremap <expr> <M-Left>  &diff ? 'do' : ':tabp<cr>'
nnoremap <expr> <M-Right> &diff ? 'dp' : ':tabn<cr>'

"====[ use my own make script ]==========================================
set makeprg=mk

"====[ map :Q to :q ]====================================================
" It happens so often that I type :Q instead of :q that it makes sense to make
" :Q just working. :Q is not used anyway by vim.
command! Q q

"====[ Syntastic plugin ]================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_python_pylint_exec = '/usr/bin/pylint3'
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_enable_balloons = 1

"====[ Git Gutter plugin ]======================================================
" Use lower prio than YCM errors
let g:gitgutter_sign_priority = 5

"====[ YCM plugin ]======================================================
nmap <leader><leader>c :YcmCompleter GoToReferences expand("<cword>")<CR>
nmap <leader><leader>d :YcmCompleter GoToDefinition expand("<cword>")<CR>
nmap <leader><leader>g :YcmCompleter GoTo expand("<cword>")<CR>

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

"====[ CompleteParam plugin ]============================================
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <leader><tab> <Plug>(complete_parameter#goto_next_parameter)
imap <leader><tab> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
let g:complete_parameter_use_ultisnips_mapping = 1

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
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

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

"====[ Tagbar plugin ]==================================================
let g:tagbar_autoshowtag = 1
let g:tagbar_autopreview = 0
let g:tagbar_silent = 0
autocmd VimEnter * nested :call tagbar#autoopen(1)

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

"====[ vim-cmake-build ]======================================
nmap <leader>d :CMakeDebug<CR>
nmap <leader>x :CMakeExecute<CR>
nmap <leader>v :CMakeValgrind<CR>
let g:debugger = 'cgdb'
let g:perl_debugger = 'ddd'

"====[ vimux ]================================================
let g:VimuxHeight = "40"
let g:VimuxOrientation = "h"

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
" save and leave insert mode
inoremap <F2> <esc>:w<cr>
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
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" prefer vertical diff
set diffopt+=vertical
" spell settings
"  :setlocal spell spelllang=en
" set the spellfile - folders must exist
" global wordlist, press zg to add a word to the list
set spellfile=~/.vim/spellfile.add
" project specific ignore list, press 2zg to add a word to this ignore list
set spellfile+=ignore.utf-8.add

"====[ Ctrl-P plugin         ]===========================================
"nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>t :TagbarToggle<cr>

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

" Open ccmake for current project.
" This uses b:git_dir from vim-fugitive to find the git directory
function! CCMake() abort
    if exists('b:git_dir')
        execute "silent !ccmake ".b:git_dir."/../bld"
        execute "redraw!"
    else
        echom "error: b:git_dir is not set"
    endif
endfunction
map <leader>cc :call CCMake()<cr>

" Make views automatic: http://vim.wikia.com/wiki/VimTip991
"augroup MakeViewAutomatic
"    autocmd!
"    autocmd BufWinLeave *.* mkview
"    autocmd BufWinEnter *.* silent loadview
"augroup end

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

let g:ycm_python_binary_path = '/usr/bin/python3'
augroup python_files
    autocmd!
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=8
    autocmd FileType python set shiftwidth=8
    autocmd FileType python nnoremap <buffer> <F5> :!python3 %<CR>
augroup END

" automatic strip trailing whitespace on write
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePre *.pl :%s/\s\+$//e

" avoid pressing enter when leaving man pages
:nnoremap K K<CR>
:vnoremap K K<CR>

"======[ Magically build interim directories if necessary ]===================
" This is from Damian Conway.

function! AskQuit (msg, options, quit_option)
    if confirm(a:msg, a:options) == a:quit_option
        exit
    endif
endfunction

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
             \       "&Create it\nor &Quit?", 2)

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
        endtry
    endif
endfunction

augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

"=====[ Auto-setup for Perl scripts and modules and test files ]===========

augroup Perl_Setup
    autocmd!
    autocmd BufNewFile   *.p[lm65],*.t,*.h,*.c,*.hpp,*.cpp   0r !file_template <afile>
    autocmd BufNewFile   *.p[lm65],*.t,*.h,*.c,*.hpp,*.cpp   /^.*implementation[ \t]\+here/
augroup END

"=====[ Add or subtract comments ]===============================

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap <silent> # :call ToggleComment()<CR>j0
vmap <silent> # :call ToggleBlock()<CR>

" Creates an implementation from a declaration in a header file.
" It uses the declaration from the current line.
function! CreateImplementation()
    " copy current line
    normal yy
    " switch to implementation
    execute "A"
    " paste new line
    execute "normal Gp$xa\<CR>{\<CR>}\<ESC>O"
endfunction
function! CreateImplementationBlock() range
    let num_lines = a:lastline - a:firstline
    let lines = getline(a:firstline, a:lastline)

    " try to figure out class name
    if (&ft == "cpp")
        let lineno = search("^class", "b")
        let line = getline(lineno)
        let classname = substitute(line, 'class \(\w\+\).*', "\\1", '')
    endif

    " switch to implementation
    execute "A"

    let startpos = line('$')

    for line in lines
        " skip empty lines
        if match(line, "^\s*$") != -1
            continue
        endif
        " remove semicolon at end of line
        let line = substitute(line, ';$', "", 'g')
        if (&ft == "cpp")
            " CPP code needs more work
            let line = substitute(line, '^ \+', '', 'g') " remove leading spaces
            let line = substitute(line, ' = \w\+', '', 'g') " remove default values and pure virtual definition
            let line = substitute(line, 'virtual ', '', 'g') " remove virtual keyword
            " lets insert classname
            let line = substitute(line, '\([a-zA-Z0-9_~]\+\)(', classname."::\\1(", '')
        endif
        call append(line('$'), line)
        call append(line('$'), "{")
        let match = matchstr(line, "^int ")
        if match != ''
            call append(line('$'), "    int ret = 0;")
            call append(line('$'), "")
            call append(line('$'), "    // TODO")
            call append(line('$'), "")
            call append(line('$'), "    return ret;")
        else
            call append(line('$'), "    // TODO")
        endif
        call append(line('$'), "}")
        call append(line('$'), "")
    endfor

    " place cursor in first function implementation body
    call cursor(startpos, 1)
    execute "normal /\\/\\/ TODO\<cr>v$\<c-g>"
endfunction
nmap <silent> <leader>i :call CreateImplementation()<CR>
vmap <silent> <leader>i :call CreateImplementationBlock()<CR>


"=====[ Search folding ]=====================

" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':2})

" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only C #includes...
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})

let g:clang_include_fixer_path = "/usr/bin/clang-include-fixer-3.9"
let g:clang_include_fixer_maximum_suggested_headers = 3
let g:clang_include_fixer_increment_num = 5
let g:clang_include_fixer_jump_to_include = 0
let g:clang_include_fixer_query_mode = 0
noremap <leader>cf :py3f /usr/lib/llvm-3.9/share/clang/clang-include-fixer.py<cr>

" setup
if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " search ctags first
    set csto=1
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
    endif
    " show msg when any other cscope db is added
    set csverb
endif

" To do the first type of search, hit 'CTRL-\', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.  
"
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split horizontally, with search result displayed in
" the new window.
"
" (Note: earlier versions of vim may not have the :scs command, but it
" can be simulated roughly via:
"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

" Hitting CTRL-space *twice* before the search type does a vertical 
" split instead of a horizontal one (vim 6 and up only)
"
" (Note: you may wish to put a 'set splitright' in your .vimrc
" if you prefer the new window on the right instead of the left
nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"====[ unit test execution ]======================================
function! RunTest(testname)
    " populate quickfix window with test result
    cexpr system(a:testname)
endfunction
" add error format for unit test output
set efm+=%-GSTART%.%#
set efm+=%EFAIL!%.%#:\ %m
set efm+=%-Z\ \ \ Loc:\ [%f(%l)]
set efm+=%-C%m
set efm+=%-GTest\ finished%.%#
set efm+=%-G%.%#PASSED.
set efm+=%-G%.%#FAILED.
set efm+=%-G%.%#SKIPPED.
set efm+=%-G%.%#Testing\ %.%#...
set efm+=%-G%.%#Finished\ testing%.%#
set efm+=%-G%.%#PASS%.%#

" load tags file in project root. the ';' is important here. It will search
" from the current directoru upwards until it find a tags file
set tags=tags;

