#!/bin/bash
# This script install some useful plugins for you.

# vim-fugitive - Awesome git plugin
PLUGINS="git://github.com/tpope/vim-fugitive.git"
# vim-airline - lightweight powerline alternative (pure vim, no python)
PLUGINS="$PLUGINS https://github.com/bling/vim-airline.git"
# CTRLP - Fuzzy file open
PLUGINS="$PLUGINS https://github.com/kien/ctrlp.vim.git"
# QML syntax support
PLUGINS="$PLUGINS https://github.com/peterhoeg/vim-qml.git"
# Nerdtree
PLUGINS="$PLUGINS https://github.com/scrooloose/nerdtree"
# Autoclose
PLUGINS="$PLUGINS https://github.com/Townk/vim-autoclose.git"
# Autoclose
PLUGINS="$PLUGINS https://github.com/Rip-Rip/clang_complete"
# snipMate
#PLUGINS="$PLUGINS https://github.com/msanders/snipmate.vim"
#PLUGINS="$PLUGINS https://github.com/ervandew/snipmate.vim"
PLUGINS="$PLUGINS https://github.com/vim-scripts/UltiSnips"
# superTab
PLUGINS="$PLUGINS https://github.com/ervandew/supertab"
# multiple cursors - See https://github.com/terryma/vim-multiple-cursors
PLUGINS="$PLUGINS https://github.com/terryma/vim-multiple-cursors"

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

