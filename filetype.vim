augroup filetypedetect
    autocmd!
    autocmd BufNewFile,BufRead *.tex set filetype=tex
    autocmd BufNewFile,BufRead *.dis set filetype=mixed
    autocmd BufNewFile,BufRead *.md  set filetype=markdown
    autocmd BufNewFile,BufRead *.markdown  set filetype=markdown
    autocmd BufNewFile,BufRead *.iec  set filetype=iec
    autocmd BufNewFile,BufRead *.py  set filetype=python
augroup END

