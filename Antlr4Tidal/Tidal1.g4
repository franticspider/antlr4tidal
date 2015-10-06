/**
 * Define a grammar called Tidal1
 */
 
grammar Tidal1;

options{
	language = Java;
	tokenVocab=Tidal1lexer;   
}

//TODO: Need to be able to specify the path to the lexer before we create this package
//@header{
//	package com.grammar.tidal;
//}
 
	
tidal : CHANNEL DOLLAR message (KNIT cont_frag )*; //d1 ...d9

//TODO: Need to deal with a potential mix of dollars and brackets...
message 
	: (trans_spec DOLLAR)* (pattfrag)+
	| trans_spec LBRK (pattfrag)+ RBRK
	; 


/* General and Nested Transformations */

pattfrag 
	:  SND_OP sequence 
	;


/* Sequence expressions */

sequence 
	: QUOT sample_expr QUOT 
	| LBRK trans_spec QUOT sample_expr QUOT RBRK
	;

sample_expr
	: (sample_atom)+ (COMMA (sample_atom)+ )*
//	| LSQB (sample_atom)+ RSQB (TIMES DIGIT)?
	;
	
sample_atom
	: (SAMPLE (COLON DIGIT)? ((TIMES|DIVID) integer)? | (LBRK integer COMMA integer RBRK)) (QUESM)?
	| LSQB sample_expr RSQB  ((TIMES|DIVID) integer)? (QUESM)?//(MODUL DIGIT)? <- I've never seen this with square brackets...
	| LCRB sample_expr RCRB  ((TIMES|DIVID) integer)? (MODUL DIGIT)? (QUESM)?
	;

/* Continuous expressions */

cont_frag 
	: CONT_OP cont_patt
	| SYNTH_OP cont_patt
	| VOWEL_OP QUOT (VOWEL)+ QUOT
	| DENSITY integer
	| cont_frag LBRK cont_frag RBRK
	| KNIT cont_frag
	;

cont_patt
	: QUOT (number)* QUOT
	| WAVE
	| LBRK trans_spec WAVE RBRK
	;

/* Transform exprssions */
//transform 
//	: trans_spec LBRK (pattfrag)* RBRK
//	| trans_spec DOLLAR (pattfrag)*
//	; 
	
trans_spec
	: REV
	| BRAK
	| DEGRADE
	| DEG_BY zero2one
	| (number)? (BEATR|BEATL)
	| (SLOW|DENSITY|ITER) integer
	| EVERY DIGIT LBRK trans_spec RBRK
	| JUX LBRK trans_spec RBRK
	| STRIATE integer
	| STRIATE1 integer LBRK integer DIVID integer RBRK
	;	
	



/* Numeric expressions */
zero2one
	: ZERO (POINT integer)?;

integer
	: (DIGIT)+;

number
    :  (MINUS)? DIGIT+ (POINT DIGIT+)?
    ;  