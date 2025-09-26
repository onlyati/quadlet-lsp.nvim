" Vim syntax file
" Language:  quadlet

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" using of line-continuation requires cpo&vim
let s:cpo_save = &cpo
set cpo&vim

" shut case off
syn case ignore

syn match  quadletLabel   "^.\{-}\ze\s*=" nextgroup=quadletValue
syn region quadletHeader  start="^\s*\[" end="\]"
syn match  quadletComment "^[#;].*$" contains=@Spell

" Visual marker for the trailing backslash
syn match quadletCont "\\\s*$"

" Multi-line value:
"  - starts right after '='
"  - ends at end of line, UNLESS the line ends with '\'
"  - extend/keepend lets it flow across lines
syn region quadletValue start=/=\s*/ms=s+1,hs=s+1
      \ end=/$/
      \ keepend extend
      \ skip=/\\\s*$/
      \ contains=quadletCont

hi def link quadletHeader   Modemsg
hi def link quadletComment  Comment
hi def link quadletLabel    Identifier
hi def link quadletValue    String
hi def link quadletCont     Special

let b:current_syntax = 'quadlet'

let &cpo = s:cpo_save
unlet s:cpo_save
