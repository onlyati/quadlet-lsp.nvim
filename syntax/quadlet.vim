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

syn match  quadletLabel   "^.\{-}\ze\s*=" nextgroup=quadletAssign skipwhite
syn region quadletHeader  start="^\s*\[" end="\]"
syn match  quadletComment "^[#;].*$" contains=@Spell

syn match quadletAssign "=" contained nextgroup=quadletValue skipwhite

" Multi-line value:
"  - starts right after '='
"  - ends at end of line, UNLESS the line ends with '\'
"  - extend/keepend lets it flow across lines
syn region quadletValue start=/\s*/ms=s,hs=s
    \ end=/$/
    \ keepend extend
    \ skip=/\\\s*$/
    \ contains=quadletCont,quadletSep
    \ contained

" Effects in the quadletValue
syn match quadletCont "\\\s*$"  contained
syn match quadletSep  "[:=,/]"   contained

hi def link quadletHeader    ModeMsg
hi def link quadletComment   Comment
hi def link quadletLabel     Identifier
hi def link quadletValue     String
hi def link quadletCont      Special
hi def link quadletSep       Operator
hi def link quadletAssign    Special

let b:current_syntax = 'quadlet'

let &cpo = s:cpo_save
unlet s:cpo_save
