"====[ gergap's Vim Configuration ]======================================
" change this to your needs
"========================================================================
source $VIMRUNTIME/vimrc_example.vim
"====[ some basic editor settings ]======================================
set expandtab       " always use spaces instead of tabs
set tabstop=8       " if there are tabs display them with 8 spaces
set softtabstop=4   " this way backspace will remove the 'virtual' tab
set shiftwidth=4    " intend with 4 spaces
set backspace=2     " make backspace working as expected
set nowrap
set nojoinspaces    " avoid double space after dot when joining lines
set splitbelow
set splitright
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
"set relativenumber
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
        "set gfn=Hack\ 11
        "set gfn=Hack\ for\ Powerline\ 11
        set gfn=FiraCode\ 12
        set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
    else
        " console vim in 256 color terminal
        set t_Co=256
    endif
    set mouse=n
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
" allow changing buffers without saving them
set hidden
" configur external text formatter
set formatprg=par-format\ -w78

" enable titlestring to make vim-autoswap working
set title titlestring=

"====[ setup my CUPS printer ]===========================================
" you can simply print using :ha(rdcopy)
" this also supports an optional range argument, see :h ha
" use `lpstat -p -d to list printers`
set pdev=HP_LaserJet_5200

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

"====[ make edit vim config easy ]======================================
nnoremap <leader>ev :edit $MYVIMRC<cr>
" auto reload when config has changed
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" easymotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

"s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"====[ make naughty characters visible ]=================================
" exec "set listchars=tab:\u25B6\\ ,trail:\uB7,nbsp:~"
" set list

"=====[ Allow saving of files with sudo ]================================
cmap w!! w !sudo tee > /dev/null %

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
execute "set colorcolumn=" . join(range(121,220), ',')

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

"====[ Plugin Manager ]=================================
call plug#begin()
" Basic plugins that everybody should use
" ---------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
" Basic plugins end
" ---------------------------------------
" handle swap files in a smart way (Damian Convay)
Plug 'gioele/vim-autoswap'
" interact with tmux (used by cmake-build)
Plug 'benmills/vimux'
" effortless navigation between vim and tmux panes
Plug 'christoomey/vim-tmux-navigator'
" Wiki plugin
Plug 'vimwiki/vimwiki'
"Plug 'Yggdroot/indentLine'
" ---------------------------------------
" color schemes
"Plug 'gergap/gergap'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'asenac/vim-airline-loclist'
" ---------------------------------------
" autoclose plugins
"Plug 'Townk/vim-autoclose'
"Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
" ---------------------------------------
" Grammer check using languagetool
Plug 'rhysd/vim-grammarous'
" extend modelines to set custom variables
Plug 'vim-scripts/let-modeline.vim'
" Download show show RFCs
Plug 'dhulihan/vim-rfc'
" handle ASNI escapes from log fils
Plug 'powerman/vim-plugin-AnsiEsc'
" Quick move to different locations
Plug 'easymotion/vim-easymotion'
" General editing
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
" HTML+JS+CSS+SVG editing
Plug 'othree/html5.vim'
" LaTeX editing
Plug 'gergap/vim-latexview'
" Markdown editing
Plug 'SidOfc/mkdx'
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'prurigro/vim-markdown-concealed'
" C/C++ development stuff
Plug 'gergap/vim-cmake-build'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'gergap/vim-snippets'
" install yarn using `sudo npm install --global yarn`
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-scripts/valgrind.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
"Plug 'LucHermitte/lh-vim-lib'
"Plug 'LucHermitte/lh-tags'
"Plug 'LucHermitte/lh-dev'
"Plug 'LucHermitte/lh-style'
"Plug 'LucHermitte/lh-brackets'
"Plug 'LucHermitte/vim-refactor'
"Plug 'puremourning/vimspector'
" Rust Developement
Plug 'rust-lang/rust.vim'
" Python Developement
Plug 'davidhalter/jedi-vim'
" obsolete stuff, just for reference
"Plug 'Valloric/YouCompleteMe'
"Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'gergap/ShowMarks'
" change konsole title
"Plug 'gergap/vim-konsole'
"Plug 'vim-scripts/calendar.vim--Matsumoto'
Plug 'pprovost/vim-ps1'
Plug 'OmniSharp/omnisharp-vim'
call plug#end()

"=====[ color scheme ]============================
colorscheme solarized8_flat
"colorscheme solarized
let g:airline_theme='bubblegum'

"=====[ valgrind plugin ]============================
let g:valgrind_arguments='--leak-check=yes --num-callers=500 --show-leak-kinds=all --track-origins=yes'

"====[ vim-cmake-build ]======================================
nmap <leader>d :CMakeDebug<CR>
nmap <leader>x :CMakeExecute<CR>
nmap <leader>v :CMakeValgrind<CR>
let g:debugger = 'cgdb'
let g:perl_debugger = 'ddd'
let g:workdir='bin'
let g:args=''

"====[ vimux plugin ]================================================
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

"====[ Grammarous Plugin ]=====================================================
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
    nmap <buffer><C-r> <Plug>(grammarous-reset)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
    nunmap <buffer><C-r>
endfunction

"====[ Ctrl-P plugin         ]===========================================
"nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>t :TagbarToggle<cr>

"====[ NERDTree plugin       ]===========================================
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

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

"====[ use my own make script ]==========================================
set makeprg=mk

"====[ map :Q to :q ]====================================================
" It happens so often that I type :Q instead of :q that it makes sense to make
" :Q just working. :Q is not used anyway by vim.
command! Q q
command! Qw qw

"====[ Syntastic plugin ]================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
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
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsListSnippets        = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit           = "horizontal"
let g:UltiSnipsSnippetDirectories  = ['~/.vim/UltiSnips', 'UltiSnips']
inoremap <c-x><c-k> <c-x><c-k>

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


"if !exists("g:UltiSnipsJumpForwardTrigger")
"  let g:UltiSnipsJumpForwardTrigger = "<tab>"
"endif
"
"if !exists("g:UltiSnipsJumpBackwardTrigger")
"  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"endif
"
"au InsertEnter * exec "inoremap <silent> ".g:UltiSnipsExpandTrigger." <C-R>=g:UltiSnips_Complete()<cr>"
"au InsertEnter * exec "inoremap <silent> ".g:UltiSnipsJumpBackwardTrigger." <C-R>=g:UltiSnips_Reverse()<cr>"


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
syntax keyword Underscore    _    contained
syntax match   Escaped "\\?"  contains=Underscore

"====[ markdown-preview ]================
"let g:mkdp_path_to_chrome = "/usr/bin/google-chrome"
" Path to the chrome or the command to open chrome (or other modern browsers).
" If set, g:mkdp_browserfunc would be ignored.

" let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" " Callback Vim function to open browser, the only parameter is the url to open.
" 
" let g:mkdp_auto_start = 1
" " Set to 1, Vim will open the preview window on entering the Markdown
" " buffer.
" 
" let g:mkdp_auto_open = 1
" " Set to 1, Vim will automatically open the preview window when you edit a
" " Markdown file.
" 
" let g:mkdp_auto_close = 1
" " Set to 1, Vim will automatically close the current preview window when
" " switching from one Markdown buffer to another.
" 
" let g:mkdp_refresh_slow = 0
" " Set to 1, Vim will just refresh Markdown when saving the buffer or
" " leaving from insert mode. With default 0, it will automatically refresh
" " Markdown as you edit or move the cursor.
" 
" let g:mkdp_command_for_global = 1
" " Set to 1, the MarkdownPreview command can be used for all files,
" " by default it can only be used in Markdown files.
" 
" let g:mkdp_open_to_the_world = 0
" " Set to 1, the preview server will be available to others in your network.
" " By default, the server only listens on localhost (127.0.0.1).

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

"====[ Coc Plugin ]=====================================================
" Requirements: sudo apt install npm
" - npm install esbuild
" - cd ~/.vim/plugged/coc.nvim/
" - npm run build
" In Vim:
" - :CocInstall coc-clangd
" - :CocCommand clangd.install (if not using system clangd)
" - :CocConfig
"   {
"       "clangd.path": "/home/gergap/.config/coc/extensions/coc-clangd-data/install/12.0.1/clangd_12.0.1/bin/clangd",
"       "clangd.semanticHighlighting": true
"   }
" Ensure you have a compile_commands.json in your project dir
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader>D to show documentation in preview window.
" The default on Coc website uses K, which is the key to display man pages.
nnoremap <silent> <leader>D :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Refactor selection
vmap <silent> <leader>rf <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

"=====[ Comfortably comment out lines ]===============================

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType perl setlocal iskeyword+=$


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

"====[ My solution to create implementations from declarations ]==============================================
" Creates an implementation from a declaration in a header file.
" This requires A.vim to switch between headers and sources

" This uses the declaration from the current line
function! CreateImplementation()
    " copy current line
    normal yy
    " switch to implementation
    execute "A"
    " paste new line
    execute "normal Gp$xa\<CR>{\<CR>}\<ESC>O"
endfunction

" This works on lines in the visual selection
" The selection can contain empty lines, which will be ignored.
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
        " remove semicolon at end of line (including optional attributes)
        let line = substitute(line, ')[A-Za-z0-9_() ]*;$', ")", 'g')
        if (&ft == "cpp")
            " CPP code needs more work
            let line = substitute(line, '^ \+', '', 'g') " remove leading spaces
            let line = substitute(line, ' = \w\+', '', 'g') " remove default values and pure virtual definition
            let line = substitute(line, 'virtual ', '', 'g') " remove virtual keyword
            " lets insert classname
            let line = substitute(line, '\([a-zA-Z0-9_~]\+\)(', classname."::\\1(", '')
        endif
        let line = substitute(line, '\w\+EXPORT ', '', 'g') " remove EXPORT macros
        call append(line('$'), line)
        call append(line('$'), "{")
        let match = matchstr(line, '\v^(bool|(unsigned)? int|float|double) ')
        if match != ''
            let dt = substitute(match, '\v.{-}(bool|(unsigned)? int|float|double).*', '\1', '')
            call append(line('$'), "    ".dt." ret = 0;")
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
    "execute "normal /\\/\\/ TODO\<cr>v$\<c-g>"
endfunction
nmap <silent> <leader>i :call CreateImplementation()<CR>
vmap <silent> <leader>i :call CreateImplementationBlock()<CR>

"====[ F-key mappings ]==============================================
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
"map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F5> :!git ctags<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
function! Build()
    if &modified == 1
        " save current changed buffer
        normal :w<CR>
    endif
    "execute "make clean"
    execute "make all"
endfunction
nnoremap <F7> :call Build()<CR>
nmap <F7> :call Build()<CR>
imap <F7> <ESC>:w<CR>:make<CR>
" clean build using makeprg with <S-F7>
" build using makeprg with <F7>
function! CleanBuild()
    if &modified == 1
        " save current changed buffer
        normal :w<CR>
    endif
    " ninja does not support 'clean all' in one step
    execute "make clean"
    execute "make all"
endfunction
map <leader><F7> :call CleanBuild()<CR>
" Simple hexify/unhexify
noremap <F8> :call <sid>Hexify()<CR>
" Apply CoC FixIt
map <F9> <Plug>(coc-fix-current)
"map <F9> :make run<CR>
" remove trailing spaces
map <F10> :%s/\s\+$//<CR>
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

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

"====[ convert enum to string array ]=====================================================
" This uses array designators, which is C99 only
function! Enum2ArrayC99()
    let l:autoclose=b:AutoCloseOn
    " disable autoclose
    let b:AutoCloseOn=0
    " disable delimitMate
    exe "DelimitMateOff"
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
    " enable delimitMate
    exe "DelimitMateOn"
    normal f[
endfunction

" This does the some without array designators
function! Enum2Array()
    let l:autoclose=b:AutoCloseOn
    " disable autoclose
    let b:AutoCloseOn=0
    " disable delimitMate
    exe "DelimitMateOff"
    exe "normal! :'<,'>g/^\\s*$/d\n"
    exe "normal! :'<,'>s/\\(\\s*\\)\\([[:alnum:]_]*\\).*/\"\\2\",/\n"
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
    " enable delimitMate
    exe "DelimitMateOn"
    normal f[
endfunction
map <leader>e <esc>:call Enum2Array()<cr>ienum_strings<esc>viw<C-G>
map <leader>E <esc>:call Enum2ArrayC99()<cr>ienum_strings<esc>viw<C-G>

"====[ python configuration ]=====================================================
let g:ycm_python_binary_path = '/usr/bin/python3'
augroup python_files
    autocmd!
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=8
    autocmd FileType python set shiftwidth=8
    autocmd FileType python nnoremap <buffer> <F5> :!python3 %<CR>
augroup END

"====[ automatic strip trailing whitespace on write ]=====================================================
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePre *.pl :%s/\s\+$//e

" avoid pressing enter when leaving man pages
:nnoremap K K<CR>
:vnoremap K K<CR>

"=====[ CCMake integration ]=====================
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

"=====[ Search folding ]=====================
" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
"highlight Folded  ctermfg=cyan ctermbg=black
hi! link Folded VisualNOS

" Toggle on and off...
nmap <silent> <expr>  ff  FS_ToggleFoldAroundSearch({'context':2})

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

" Load Mutt alias completion when writing mails
au BufRead /var/tmp/mutt-* source ~/.mutt/mutt-aliases.vim
let g:mutt_aliases_file="~/.mutt/aliases.generated"

"==============[ CoC Config ]======================

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"=====[ Vimspector ]=====================
"nmap <F5> <Plug>VimspectorContinue
"nmap <S-F5> <Plug>VimspectorReset
"nmap <leader><F5> <Plug>VimspectorRunToCursor
"nmap <F9> <Plug>VimspectorToggleBreakpoint
"nmap <F10> <Plug>VimspectorStepOver
"nmap <F11> <Plug>VimspectorStepInto
"nmap <F12> <Plug>VimspectorStepOut
"" for normal mode - the word under the cursor
"nmap <Leader>di <Plug>VimspectorBalloonEval
"" for visual mode, the visually selected text
"xmap <Leader>di <Plug>VimspectorBalloonEval

function! FindTagsFile()
    let tagsfile = findfile("tags", ".;")
    if (!empty(tagsfile))
        exec "set tags+=".tagsfile
    endif
endfunction
exec FindTagsFile()

function! SetupPerlTestCaseHighlights()
    exe "syntax match TestCaseName /Name:/ containedin=perlComment"
    exe "syntax match TestCaseDescription /Description:/ containedin=perlComment"
    exe "syntax match TestCaseExpectedResult /Expected Result:/ containedin=perlComment"
    exe "syntax match TestCaseTestItem /Test Item:/ containedin=perlComment"
    exe "syntax match TestCasePrerequisites /Prerequisites:/ containedin=perlComment"
    exe "syntax match TestCaseRequirements /Requirements:/ containedin=perlComment"
    exe "highlight TestCaseKeyword ctermfg=magenta cterm=bold,italic"
    exe "hi link TestCaseName TestCaseKeyword"
    exe "hi link TestCaseDescription TestCaseKeyword"
    exe "hi link TestCaseExpectedResult TestCaseKeyword"
    exe "hi link TestCaseTestItem TestCaseKeyword"
    exe "hi link TestCasePrerequisites TestCaseKeyword"
    exe "hi link TestCaseRequirements TestCaseKeyword"
endfunction
augroup MyCommentMarkers
    autocmd!
    autocmd BufNewFile,BufRead *.pl,*.t call SetupPerlTestCaseHighlights()
augroup END

function! LoadLogFile()
    set background=dark
    exe ":AnsiEsc"
endfunction

augroup VimAutoAnsiEsc
    autocmd!
    autocmd BufRead *.log call LoadLogFile()
    autocmd BufRead log.txt call LoadLogFile()
augroup END

" name: Function name to add
function! RegisterTest(name)
    let save_pos = getpos(".")
    call search("register_tests")
    normal! j%
    exe ":normal! OUREGISTER_TEST(test_".a:name.");"
    call setpos(".", save_pos)
endfunction
