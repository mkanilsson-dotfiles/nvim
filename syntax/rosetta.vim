if exists("b:current_syntax")
    finish
endif

syntax keyword rosettaKeyword fn
syntax keyword rosettaInstruction add subtract multiply divide phi allocate store load jump return
syntax match rosettaInstruction "greater_than"
syntax match rosettaInstruction "conditional_jump"
syntax match rosettaOperator "="
syntax keyword rosettaType i8 u8 i16 u16 i32 u32 i64 u64 bool f32 f64 ptr
syntax match rosettaCustomType "\<[_A-Z][\._a-zA-Z0-9]*\>"
syntax match rosettaVariable "%\<[_a-z][\._a-zA-Z0-9]*\>"
syntax match rosettaArgumentLabel "\<[\._a-zA-Z0-9]*\>:"
syntax keyword rosettaBool true false
syntax match rosettaParens "[][(){}]"
syntax match rosettaDelimiter ","
syntax match rosettaDelimiter ":"
syntax match rosettaComment "#.*$"
syntax match rosettaLabel "@\<[a-zA-Z_][a-zA-Z0-9_]*\>"
syntax match rosettaNumber "\<\d\+\>"

syntax region rosettaString start=+"+ skip=+\\"+ end=+"+ contains=rosettaEscape
syntax match rosettaEscape "\\[nrt\\\"]" contained

highlight link rosettaKeyword Keyword
highlight link rosettaInstruction PreProc
highlight link rosettaNumber Constant
highlight link rosettaArgumentLabel Special
highlight link rosettaType Type
highlight link rosettaCustomType Type
highlight link rosettaBool Boolean
highlight link rosettaParens Delimiter
highlight link rosettaDelimiter Delimiter
highlight link rosettaOperator Delimiter
highlight link rosettaVariable Identifier
highlight link Error NONE
highlight link rosettaString String
highlight link rosettaEscape SpecialChar
highlight link rosettaComment Comment
highlight link rosettaLabel Label

let b:current_syntax = "rosetta"
setlocal commentstring=#\ %s
