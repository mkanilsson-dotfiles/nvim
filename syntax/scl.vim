if exists("b:current_syntax")
    finish
endif

syntax keyword sclKeyword if else proc ret let import struct
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
syntax keyword sclType i32 u32 i64 u64 bool
syntax match sclCustomType "\<[_A-Z][_a-zA-Z0-9]*\>"
syntax match sclVariable "\<[_a-z][_a-zA-Z0-9]*\>"
syntax keyword sclBool true false
syntax match sclParens "[][(){}]"
syntax match sclDelimiter ","
syntax match sclDelimiter ":"
syntax match sclDelimiter ";"
syntax match sclDelimiter "::"
syntax match sclDelimiter "\."

highlight link sclKeyword Keyword
highlight link sclNumber Number
highlight link sclOperator PreProc
highlight link sclType Type
highlight link sclCustomType Type
highlight link sclBool Boolean
highlight link sclInParen Delimiter
highlight link sclParens Delimiter
highlight link sclDelimiter Delimiter
highlight link sclVariable Identifier
highlight link Error NONE
