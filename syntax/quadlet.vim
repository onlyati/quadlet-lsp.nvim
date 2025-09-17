" Vim syntax file
" Language:  quadlet

if !exists('b:current_syntax')
  " Looks a lot like dosini files.
  runtime! syntax/dosini.vim
  let b:current_syntax = 'quadlet'
endif
