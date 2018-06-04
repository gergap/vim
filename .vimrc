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
"
"=====[ enable vundle plugin manager ]===================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'NLKNguyen/papercolor-theme'
call vundle#end()

colorscheme PaperColor
set background=light

