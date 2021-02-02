scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

"syntax match TranslatorQuery               /\v⟦.*⟧/
"syntax match TranslatorDelimiter           /\v\─.*\─/

"hi def link TranslatorQuery             Identifier
"hi def link TranslatorDelimiter         Comment

hi def link OrgBG                  Normal
hi def link OrgBorder            String

let b:current_syntax = 'Org'
