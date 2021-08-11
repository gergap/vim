" Vim syntax file
" Language: NC 
" Maintainer: Dave Eno <daveeno@gmail.com>
" Last Change: 2014 April 03

" Quit when a (custom syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn case ignore

syn  match ncComment /(.*)/ contains=ncTodo
syn  match ncComment /;.*/
syntax match ncGCodes "\<G\d\+\>"
syntax match ncMCodes "\<M\d\+\>"

syntax match ncXAxis "\<[XY]-\?\d\+\>"
syntax match ncXAxis "\<[XY]-\?\.\d\+\>"
syntax match ncXAxis "\<[XY]-\?\d\+\."
syntax match ncXAxis "\<[XY]-\?\d\+\.\d\+\>"

syntax match ncZAxis "\<Z-\?\d\+\>"
syntax match ncZAxis "\<Z-\?\.\d\+\>"
syntax match ncZAxis "\<Z-\?\d\+\."
syntax match ncZAxis "\<Z-\?\d\+\.\d\+\>"

syntax match ncAAxis "\<[ABC]-\?\d\+\>"
syntax match ncAAxis "\<[ABC]-\?\.\d\+\>"
syntax match ncAAxis "\<[ABC]-\?\d\+\."
syntax match ncAAxis "\<[ABC]-\?\d\+\.\d\+\>"

syntax match ncIAxis "\<[IJKR]-\?\d\+\>"
syntax match ncIAxis "\<[IJKR]-\?\.\d\+\>"
syntax match ncIAxis "\<[IJKR]-\?\d\+\."
syntax match ncIAxis "\<[IJKR]-\?\d\+\.\d\+\>"

syntax match ncRapid "\<G\(0\+\)\>"

syntax match ncFeed "\<F-\?\d\+\>"
syntax match ncFeed "\<F-\?\.\d\+\>"
syntax match ncFeed "\<F-\?\d\+\."
syntax match ncFeed "\<F-\?\d\+\.\d\+\>"

syntax match ncTool "\<T\d\+\>"

hi def link ncComment Comment
hi def link ncGCodes MoreMsg
hi def link ncMCodes WarningMsg
hi def link ncXAxis Keyword
hi def link ncYAxis Keyword
hi def link ncZAxis WarningMsg
hi def link ncAAxis VimString

hi def link ncRapid WarningMsg
hi def link ncIAxis Identifier
hi def link ncSpecials SpecialChar
hi def link ncFeed SpecialChar
hi def link ncTool Define

let b:current_syntax = "nc"
