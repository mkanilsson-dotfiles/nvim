if exists("b:current_syntax")
    finish
endif

syntax keyword slKeyword if else fn ret let import struct
syntax match slNumber "\<[0-9]+\>"
syntax match slOperator "+"
syntax match slOperator "-"
syntax match slOperator "/"
syntax match slOperator "*"
syntax match slOperator "%"
syntax match slOperator "&&"
syntax match slOperator "=="
syntax match slOperator "!="
syntax match slOperator ">="
syntax match slOperator "<="
syntax match slOperator ">"
syntax match slOperator "<"
syntax match slOperator "="
syntax keyword slType i32 u32 i64 u64 bool
syntax match slCustomType "\<[_A-Z][_a-zA-Z0-9]*\>"
syntax match slVariable "\<[_a-z][_a-zA-Z0-9]*\>"
syntax keyword slBool true false
syntax match slParens "[][(){}]"
syntax match slDelimiter ","
syntax match slDelimiter ":"
syntax match slDelimiter ";"
syntax match slDelimiter "::"
syntax match slDelimiter "\."

highlight link slKeyword Keyword
highlight link slNumber Number
highlight link slOperator PreProc
highlight link slType Type
highlight link slCustomType Type
highlight link slBool Boolean
highlight link slInParen Delimiter
highlight link slParens Delimiter
highlight link slDelimiter Delimiter
highlight link slVariable Identifier
highlight link Error NONE
