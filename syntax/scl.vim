if exists("b:current_syntax")
    finish
endif

syntax keyword sclKeyword if else proc ret let import struct extern use switch union defer package as while
syntax match sclNumber "\<[0-9]+\>"
syntax match sclOperator "+"
syntax match sclOperator "-"
syntax match sclOperator "/"
syntax match sclOperator "*"
syntax match sclOperator "%"
syntax match sclOperator "&&"
syntax match sclOperator "=="
syntax match sclOperator "!="
syntax match sclOperator ">="
syntax match sclOperator "<="
syntax match sclOperator ">"
syntax match sclOperator "<"
syntax match sclOperator "="
syntax keyword sclType i8 u8 i16 u16 i32 u32 i64 u64 isize usize bool void string any
syntax match sclCustomType "\<[_A-Z][_a-zA-Z0-9]*\>"
syntax match sclVariable "\<[_a-z][_a-zA-Z0-9]*\>"
syntax keyword sclBool true false
syntax match sclParens "[][(){}]"
syntax match sclDelimiter ","
syntax match sclDelimiter ":"
syntax match sclDelimiter ";"
syntax match sclDelimiter "::"
syntax match sclDelimiter "\."
syntax match sclComment "//.*$"
syntax match sclBuiltin "@\<[a-zA-Z_][a-zA-Z0-9_]*\>"

syntax region sclString start=+"+ skip=+\\"+ end=+"+ contains=sclEscape
syntax match sclEscape "\\[nrt\\\"]" contained

highlight link sclKeyword Keyword
highlight link sclNumber Constant
highlight link sclOperator PreProc
highlight link sclType Type
highlight link sclCustomType Type
highlight link sclBool Boolean
highlight link sclInParen Delimiter
highlight link sclParens Delimiter
highlight link sclDelimiter Delimiter
highlight link sclVariable Identifier
highlight link Error NONE
highlight link sclString String
highlight link sclEscape SpecialChar
highlight link sclComment Comment
highlight link sclBuiltin PreProc

let b:current_syntax = "scl"
setlocal commentstring=//\ %s
