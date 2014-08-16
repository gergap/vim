augroup filetypedetect
  au BufNewFile,BufRead *.tex               setf tex
augroup END
augroup filetype
  au! BufRead,BufNewFile *.dis set filetype=mixed
augroup END

