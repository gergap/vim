gergap's Vim Configuration
==========================
                                       /\        ____   ____.__
       ____   ___________  _________  _____)/ ______ \   \ /   /|__| _____
      / ___\_/ __ \_  __ \/ ___\__  \ \____ \/  ___/  \   Y   / |  |/     \
     / /_/  >  ___/|  | \/ /_/  > __ \|  |_> >___ \    \     /  |  |  Y Y  \
     \___  / \___  >__|  \___  (____  /   __/____  >    \___/   |__|__|_|  /
    /_____/      \/     /_____/     \/|__|       \/                      \/


With vim you can really do everything. I'm using it for C/C++ development,
writing BASH scripts, and for all kinds of administration tasks. TMux and SSH are
your best friends ;-)

I'm using vim on Gentoo Linux running in Konsole (KDE's awesome terminal application).
My config may work on other systems too, but I've not tested it.
Anyway my .vimrc may contain some nice features that you can integrate into yours.

You can use my config as-is, or better read my .vimrc, understand it, and as
Bruce Lee would say: "Absorb what is useful, discard what is not."

And this is what my config looks like:
![gergap's Vim example screenshot][vim-gergap]

Requirements
------------

* vim, for obvious reasons ;-) (you will need to build vim with python support for some plugins)
* git

Now some optional parts:

* clang - for clang_complete plugin (See https://github.com/Rip-Rip/clang_complete/wiki)
* python - for some plugins like clang_complete
* powerline fonts - for vim-airline to display nice symbols (See https://github.com/Lokaltog/powerline-fonts)

Installation
------------

    cd ~
    # clone this repository
    git clone git@github.com:gergap/vim.git
    # now merge my config with yours or continue to replace your config completely.
    # The following steps are what I'm doing to install it on various machines.
    # Note: backup any existing vim configuration before you remove your .vim folder and .vimrc file.
    rm -rf .vim .vimrc
    # symlink your new config
    ln -s vim/.vimrc
    ln -s vim/.vim
    # install used plugins
    cd vim/.vim
    ./install_plugins.sh
    # Now enjoy the best editor on earth - vim :-)

[vim-gergap]: https://raw.github.com/gergap/vim/master/vim-gergap.png

