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
 
	
tidal 
	: CHANNEL DOLLAR message (KNIT cont_frag )*; //d1 ...d9

//TODO: Need to deal with a potential mix of dollars and brackets...
message 
	: (trans_spec DOLLAR)* (pattfrag)+
	| trans_spec LBRK (pattfrag)+ RBRK
	| LBRK message RBRK
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
	: (SAMPLE (COLON INTEGER)? ((TIMES|DIVID) INTEGER)? | (LBRK INTEGER COMMA INTEGER RBRK)) (QUESM)?
	| LSQB sample_expr RSQB  ((TIMES|DIVID) INTEGER)? (QUESM)?//(MODUL DIGIT)? <- I've never seen this with square brackets...
	| LCRB sample_expr RCRB  ((TIMES|DIVID) INTEGER)? (MODUL INTEGER)? (QUESM)?
	;

/* Continuous expressions */

cont_frag 
	: (KNIT)? SYNTH_OP QUOT cont_patt QUOT
	| VOWEL_OP QUOT (VOWEL)+ QUOT
	| DENSITY INTEGER
	| slow_pattern
	| cont_frag LBRK cont_frag RBRK
	| CONT_OP QUOT cont_patt QUOT 
	; 

cont_patt
	: cont_atom
	| WAVE
	| LBRK trans_spec WAVE RBRK 
	;

cont_atom
	: (number)+
	| LSQB cont_patt RSQB ((TIMES|DIVID) INTEGER)?
	;
/* Transform exprssions */
//transform 
//	: trans_spec LBRK (pattfrag)* RBRK
//	| trans_spec DOLLAR (pattfrag)*
//	; 
	
trans_spec
	: trans_0arg
	| LBRK trans_spec RBRK
	| slow_pattern
	| (KNIT)? SYNTH_OP cont_patt
	| (DEG_BY|TRUNC) zero2one
	| (number)? (BEATR|BEATL)
	| (DENSITY|ITER) INTEGER
	| EVERY INTEGER LBRK trans_spec RBRK
	| JUX LBRK trans_spec (POINT trans_spec)* RBRK
	| STRIATE INTEGER
	| STRIATE1 INTEGER LBRK INTEGER DIVID INTEGER RBRK
	| SMASH INTEGER LSQB INTEGER (COMMA INTEGER)* RSQB
	| slowspread_pattern
	;	
	
trans_0arg //Transformations with no arguments
	: (BRAK | DEGRADE | REV | PALIN);
	
slow_pattern
	: SLOW number 
	| SLOW LBRK numorratio RBRK
	;
	
slowspread_pattern
	//1: Spread a set of values over a single function:
	: (SPREAD|SLOWSPREAD) LBRK sample_trans RBRK LSQB numorratio (COMMA numorratio)* RSQB
	| (SPREAD|SLOWSPREAD) sample_trans LSQB numorratio (COMMA numorratio)* RSQB
	//2: Spread a bunch of different functions: 
	| SLOWSPREAD LBRK DOLLAR RBRK LSQB  numorratio (COMMA numorratio)* RSQB
	| SPREAD1 sample_trans QUOT slowspread_atom QUOT
	;	
	
slowspread_atom
	: numorratio (COMMA numorratio)*
	| LSQB slowspread_atom RSQB
	;	
	
sample_trans_func
	: sample_trans
	;	
	
sample_trans
	: (CHOP|DENSITY|SLOW)
	| STUT INTEGER INTEGER
	| STRIATE
	;
	

/* Numeric expressions */

/*Any number from 0.0 to 0.9999999999 recurring iyswim */
zero2one
	: ZERO (POINT INTEGER)?;

/* Any Digit */
//digit: ZERO|DIG19;

	
numorratio
	: number
	| (INTEGER MODUL INTEGER)
	;	

number
    : MINUS? INTEGER+ (POINT (INTEGER)*)?
    ;
    
    
/* any positive integer including 00007 
integer	: DIG19 (DIGIT);*/