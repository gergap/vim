" Vim syntax file
" Language:	IEC61131 Structured Text
" Version: 0.1


if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

syn keyword iecBoolean		true false
syn keyword iecSimpleOperator	ld ldn st stn s r s1 r1 clk cu cd pv in pt
syn keyword iecOperator		and div mod not or xor with
syn keyword iecConditional	if else then elsif end_if
syn keyword iecLabel		case of else end_case
syn keyword iecRepeat		for to by do end_for 
syn keyword iecRepeat		while do end_while 
syn keyword iecRepeat		repeat until end_repeat
syn keyword iecFunction		continue exit
syn keyword iecStatement	configuration end_configuration
syn keyword iecStatement	resource end_resouce
syn keyword iecStatement	task end_task
syn keyword iecStatement	program end_program
syn keyword iecStatement	function_block end_function_block
syn keyword iecStatement	function end_function
syn keyword iecStatement	var end_var
syn keyword iecStatement	var_input end_var
syn keyword iecStatement	var_output end_var
syn keyword iecStatement	var_in_out end_var
syn keyword iecStatement	var_tmp end_var
syn keyword iecStatement	var_external end_var
syn keyword iecStatement	var_global end_var
syn keyword iecStatement	var_access end_var
syn keyword iecAttribute	constant retain non_retain r_edge f_edge
syn keyword iecStruct		struct end_struct
syn keyword iecStruct		type end_type
syn keyword iecType		array string 
syn keyword iecType		bool byte word dword lword
syn keyword iecType		char
syn keyword iecType		int sint dint lint usint uint udint ulint
syn keyword iecType		real lreal
syn keyword iecType		time date date_and_time time_of_day tod dt


if !exists("iec_2nd_ed")
  syn keyword iecStatement	class extend end_class
  syn keyword iecStatement	interface end_interface
  syn keyword iecStatement	method end_method
  syn keyword iecAccessor       private public protected internal 
  syn keyword iecPredefined 	this super
endif

" String
if !exists("iec_one_line_string")
  syn region  iecString matchgroup=iecString start=+'+ end=+'+ contains=iecStringEscape
  if exists("iec_gpc")
    syn region  iecString matchgroup=iecString start=+"+ end=+"+ contains=iecStringEscapeGPC
  else
    syn region  iecStringError matchgroup=iecStringError start=+"+ end=+"+ contains=iecStringEscape
  endif
else
  "wrong strings
  syn region  iecStringError matchgroup=iecStringError start=+'+ end=+'+ end=+$+ contains=iecStringEscape
  if exists("iec_gpc")
    syn region  iecStringError matchgroup=iecStringError start=+"+ end=+"+ end=+$+ contains=iecStringEscapeGPC
  else
    syn region  iecStringError matchgroup=iecStringError start=+"+ end=+"+ end=+$+ contains=iecStringEscape
  endif

  "right strings
  syn region  iecString matchgroup=iecString start=+'+ end=+'+ oneline contains=iecStringEscape
  if exists("iec_gpc")
    syn region  iecString matchgroup=iecString start=+"+ end=+"+ oneline contains=iecStringEscapeGPC
  else
    syn region  iecStringError matchgroup=iecStringError start=+"+ end=+"+ oneline contains=iecStringEscape
  endif
end
syn match   iecStringEscape	     contained "''"
syn match   iecStringEscapeGPC	     contained '""'


if exists("iec_symbol_operator")
  syn match   iecSymbolOperator      "[+\-/*=]"
  syn match   iecSymbolOperator      "[<>]=\="
  syn match   iecSymbolOperator      "<>"
  syn match   iecSymbolOperator      ":="
  syn match   iecSymbolOperator      "[()]"
  syn match   iecSymbolOperator      "\.\."
  syn match   iecSymbolOperator      "[\^.]"
  syn match   iecMatrixDelimiter     "[][]"
  if !exists("iec_2nd_ed")
    syn match   iecSymbolOperator    "?="
  endif
endif

syn match  iecNumber		"-\=\<\d\+\>"
syn match  iecFloat		"-\=\<\d\+\.\d\+\>"
syn match  iecFloat		"-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
syn match  iecBinaryNumber	"2\#[0-1]\+\>"
syn match  iecOctalNumber	"8\#[0-8]\+\>"
syn match  iecHexNumber		"16\#[0-9a-fA-F]\+\>"
syn match  iecTime		"time\#[0-9a-fA-Fhms]\+\>"
syn match  iecTime		"t\#[0-9a-fA-Fhms]\+\>"
syn match  iecILLabel		"[a-z_]\+:"

syn region iecComment		start="(\*"  end="\*)" 
syn region iecComment        	start="//" end="$" 

" Standard Functions
"numeric function
syn keyword iecFunction 	abs sqr sqrt exp expd ln log acos asin atan cos sin tan

" bit string funcdtion
syn keyword iecFunction 	rol ror shl shr

" bit string funcdtion
syn keyword iecFunction 	len concat left right mid insert delete replace find
syn keyword iecFunction 	eq_string ge_string gt_string
syn keyword iecFunction 	int_to_string string_to_int


" Define the default highlighting.
if version >= 508 || !exists("did_iec_syn_inits")
  if version < 508
    let did_iec_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink iecAccessor		iecStatement
  HiLink iecAttribute		iecStatement
  HiLink iecBoolean		Boolean
  HiLink iecComment		Comment
  HiLink iecConditional		Conditional
  HiLink iecFloat		Float
  HiLink iecFunction		Function
  HiLink iecLabel		Label
  HiLink iecILLabel		Label
  HiLink iecMatrixDelimiter	Identifier
  HiLink iecNumber		Number
  HiLink iecSimpleOperator	Statement
  HiLink iecOperator		Operator
  HiLink iecPredefined		iecStatement
  HiLink iecRepeat		Repeat
  HiLink iecStatement		Statement
  HiLink iecString		String
  HiLink iecStringEscape	Special
  HiLink iecStringEscapeGPC	Special
  HiLink iecStringError		Error
  HiLink iecStruct		iecStatement
  HiLink iecSymbolOperator	iecOperator
  HiLink iecType		Type

  delcommand HiLink
endif


let b:current_syntax = "iec"

" vim: ts=8 sw=2
