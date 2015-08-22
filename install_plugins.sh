#!/bin/bash
# This script install some useful plugins for you.

# wombat256 - My default colorscheme
PLUGINS="https://github.com/gergap/wombat256.git"
# vim-touchpad - My new touchpad disabling plugin
PLUGINS="$PLUGINS git://github.com/gergap/touchpad.git"
# vim-gitgutter
PLUGINS="$PLUGINS https://github.com/airblade/vim-gitgutter.git"
# vim-fugitive - Awesome git plugin
PLUGINS="$PLUGINS git://github.com/tpope/vim-fugitive.git"
# vim-airline - lightweight powerline alternative (pure vim, no python)
PLUGINS="$PLUGINS https://github.com/bling/vim-airline.git"
# vim-airline-loclist allows to disable loclist error in vim-airline statusline
# This makes YCM (syntastic like) errors appear in the statusline
PLUGINS="$PLUGINS https://github.com/asenac/vim-airline-loclist.git"
# CTRLP - Fuzzy file open
PLUGINS="$PLUGINS https://github.com/kien/ctrlp.vim.git"
# QML syntax support
PLUGINS="$PLUGINS https://github.com/peterhoeg/vim-qml.git"
# Nerdtree
PLUGINS="$PLUGINS https://github.com/scrooloose/nerdtree"
# Autoclose
PLUGINS="$PLUGINS https://github.com/Townk/vim-autoclose.git"
# clang_complete
#PLUGINS="$PLUGINS https://github.com/Rip-Rip/clang_complete"
# YouCompletMe
PLUGINS="$PLUGINS https://github.com/Valloric/YouCompleteMe.git"
# snipMate
#PLUGINS="$PLUGINS https://github.com/msanders/snipmate.vim"
#PLUGINS="$PLUGINS https://github.com/ervandew/snipmate.vim"
PLUGINS="$PLUGINS https://github.com/vim-scripts/UltiSnips"
PLUGINS="$PLUGINS git://github.com/gergap/vim-snippets"
# superTab
#PLUGINS="$PLUGINS https://github.com/ervandew/supertab"
# multiple cursors - See https://github.com/terryma/vim-multiple-cursors
PLUGINS="$PLUGINS https://github.com/terryma/vim-multiple-cursors"
# tabularize plugin
PLUGINS="$PLUGINS https://github.com/godlygeek/tabular.git"
# vim-commentary
PLUGINS="$PLUGINS git://github.com/tpope/vim-commentary.git"
# vim-exchange
PLUGINS="$PLUGINS git://github.com/tommcdo/vim-exchange.git"
# vim-speeddating
PLUGINS="$PLUGINS git://github.com/tpope/vim-speeddating.git"
# vim-surround
PLUGINS="$PLUGINS git://github.com/tpope/vim-surround.git"
# vim-taglist
PLUGINS="$PLUGINS https://github.com/vim-scripts/taglist.vim"
# vim-textobj-function
# this provides textobjects for functions and supports C, JAVA, and Vim script
# Note: vim-textobj-function depends on vim-textobj-user
PLUGINS="$PLUGINS git://github.com/kana/vim-textobj-user"
PLUGINS="$PLUGINS git://github.com/kana/vim-textobj-function"
# gergap's vim-konsole plugin
PLUGINS="$PLUGINS git://github.com/gioele/vim-autoswap"
PLUGINS="$PLUGINS git://github.com/gergap/vim-konsole"
PLUGINS="$PLUGINS git://github.com/gergap/vim-latexview"
# solarized colorscheme
PLUGINS="$PLUGINS https://github.com/altercation/vim-colors-solarized"
# vim wiki plugin
PLUGINS="$PLUGINS https://github.com/vimwiki/vimwiki.git"
PLUGINS="$PLUGINS https://github.com/vim-scripts/calendar.vim--Matsumoto.git"
# showmarks plugin
PLUGINS="$PLUGINS https://github.com/vim-scripts/ShowMarks.git"

# create bundle dir for pathogen
[ -d bundle ] || mkdir bundle

# enter bundle
cd bundle || exit 1

# clone all plugins using git
for URL in $PLUGINS; do
    # remove path from url
    DIR=${URL##*/}
    # remove extension from dir
    DIR=${DIR%.*}
    if [ -d $DIR  ]; then
        echo "Updating plugin $DIR..."
        cd $DIR
        git pull
        cd ..
    else
        git clone $URL $DIR
    fi
done

# setup YouCompletMe
function SetupYCM() {
    cd YouCompleteMe
    git submodule update --init --recursive
    ./install.sh --clang-completer
    cd -
}

while true; do
    read -p "Do you want to setup YCM now (y/n)?" yn
    case $yn in
        [Yy]* ) SetupYCM; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

