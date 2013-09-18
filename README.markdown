gergap's Vim Configuration
==========================

With vim you can really do everything. I'm using it for C/C++ development,
writing BASH scripts, and for all kind of adminstration tasks. TMux and SSH are
your best friends ;-)

I'm using vim on Gentoo Linux running in Konsole (KDE's awsome terminal application).
My config may work on other systems too, but I've not tested it.
Anyway my .vimrc may contain some nice features the you can integrate into yours.

You can use my config as-is, or better read my .vimrc, understand it, and as
Bruce Lee would say: "Absorb what is useful, discard what is not."

Requirements
------------

* vim, for obvious reasons ;-)
* git

Installation
------------

cd ~
# backup any existing vim configuration and remove your .vim folder and .vimrc file.
rm -rf .vim .vimrc
# clone this repository
git clone git@github.com:gergap/vim.git
# symlink your new config
ln -s vim/.vimrc
ln -s vim/.vim
# install used plugins
cd vim/.vim
./install_plugins.sh

