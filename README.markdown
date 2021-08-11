gergap's Vim Configuration
==========================
                                           /\        ____   ____.__
       ____   ___________  _________  _____)/ ______ \   \ /   /|__| _____
      / ___\_/ __ \_  __ \/ ___\__  \ \____ \/  ___/  \   Y   / |  |/     \
     / /_/  >  ___/|  | \/ /_/  > __ \|  |_> >___ \    \     /  |  |  Y Y  \
     \___  / \___  >__|  \___  (____  /   __/____  >    \___/   |__|__|_|  /
    /_____/      \/     /_____/     \/|__|       \/                      \/

Vim is a versatile editor that I use for C/C++ development, writing bash or perl scripts,
LaTeX documentation, Markdown, actually everything.
Using SSH and TMux you can work remotely, keep sessions running when disconnecting and
resume on later.

Currently I'm working on Debian using Suckless' DWM and the st terminal.
But my config should work on other systems too.
Anyway my .vimrc may contain some nice features that you can integrate into yours.

You can use my config as-is, or better read my .vimrc, understand it, and as
Bruce Lee would say: "Absorb what is useful, discard what is not."

And this is what my config looks like:
![gergap's Vim Demo][vim-demo]

Important shortctus
-------------------

* F2: Saves file. Works in normal mode and insert mode.
* F3: Enables spellcheck.
* S-F3: Disables spellcheck.
* F4: Switches between header and corresponding source file.
* S-F4: Like F4, but opens the counterpart in a vertical split.
* F5: Creates/updates ctags (use git ctags, see https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)
* F6: Creates doxygen comment for the current function.
* F7: Builds using :make
* S-F7: Clean build using :make clean all
* F10: Removes trailing whitespaces of the complete file.
* F12: Goto definition
* S-F12: Opens definition in vertical split view.
* M-Down: Next typo (spellchecking)
* M-Up:   Previous typo (spellchecking)

Note, that I've changed a while ago from a German keyboard to US keyboard,
simply because all programming characters like e.g. `[]{}/\'"` are easily accessisble.
This also means that I don't need F12 anymore, because Vim's default `CTRL-]` is more handy.
I just kept it, because I have no other use for it at the moment.

Special keys in vimdiff mode
----------------------------

* M-Down: jump next difference
* M-Up:   jump to previous difference
* M-Left: diffget
* M-Right: diffput

Plugins
-------

Vim should be only extended in Vim's way like the great plugins from Tim Pope.
It makes no sense to install plugins for tasks which Vim can do out of the box.
One example is the multiple-cursors plugin, Vim has Ctrl-V, there is no need for such a plugin.

My config makes use of some great vim plugins for coders. Use `:PlugInstall` to install them.
Vimplug as the plugin manager.

An incomplete list of the most important plugins
* Tim Pope's `vim-fugitive`, `vim-surround`, `vim-unimpaired`, `vim-commentary`, and more
* Some new text objects: `kana/vim-text-function`, `kana/vim-text-line`
* `neoclide/coc.nvim`: This replaces YCM, and provides clang based auto-completion and more
* `sirver/ultisnips`: Awesome snippets support. This is a must have!
* `vim-airline`: Powerline based on vim-script (no python)
* `Raimondi/delimitMate`: another autoclose plugin
* `scrooloose/nerdtree`: File tree for accessing files interactively
* `ctrlpvim/ctrlp.vim`: Fuzzy file open support
* `majutsushi/tagbar`: List functions, variable and macros of the current file.
* `rhysd/vim-clang-format`: Integration of clang-format to automatically reformat code
* `gergap/vim-cmake-build`: My own plugin to work with CMake based projects (run cmake, compile, debug and more)
* ... much more

Requirements
------------

* vim, for obvious reasons ;-) (you will need to build vim with python support for some plugins)
* git

Now some optional parts:

* clang-format - for clang-format plugin (See https://github.com/Rip-Rip/clang_complete/wiki)
* npm - required for Coc
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
    ln -s vim/.vim
    ln -s vim/.vimrc
    # Now enjoy the best editor on earth - vim :-)

Known Issues
------------

* Some key mappings like S-F4 may not work in some terminals, because the terminal intercepts it.

[vim-demo]: https://raw.github.com/gergap/vim/master/vim-demo.gif
[vim-demo-video]: https://raw.github.com/gergap/vim/master/vim-demo.mkv

