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
	: CHANNEL DOLLAR message ; //d1 ...d9

//TODO: Need to deal with a potential mix of dollars and brackets...
message 
	: (trans_spec DOLLAR)* (pattfrag)+ (KNIT cont_frag )*
	| trans_spec LBRK (pattfrag)+ RBRK (KNIT cont_frag )*
	| LBRK message RBRK (KNIT cont_frag )*
	; 


/* General and Nested Transformations */
pattfrag 
	:  SND_OP sequence 
	;


/* Sequence expressions */
sequence 
	: QUOT sample_expr QUOT 
	| LBRK trans_spec QUOT sample_expr QUOT RBRK
	| LBRK SAMPLES QUOT sample_expr QUOT samples_seqlist RBRK
	;
	
/* Ways of getting lists of integers for "samples" command */	
samples_seqlist	
	: LBRK RUN INTEGER RBRK
	| QUOT (INTEGER)+ QUOT
	| LBRK QUOT (INTEGER)+ QUOT RBRK
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
	| INTEGER
	| slow_pattern
	| cont_frag LBRK cont_frag RBRK
	| CONT_OP QUOT cont_patt QUOT 
	; 

cont_patt
	: cont_atom (COMMA cont_atom)*
	| WAVE
	| LBRK trans_spec WAVE RBRK 
	;

cont_atom
	: (number)+
	| (LSQB cont_patt RSQB ((TIMES|DIVID) INTEGER)*)+
	;
/* Transform exprssions */
//transform 
//	: trans_spec LBRK (pattfrag)* RBRK
//	| trans_spec DOLLAR (pattfrag)*
//	; 
	
//TODO: Fix all the 'TODO's in this spec:	
trans_spec
	: trans_0arg
	| LBRK trans_spec RBRK
	| slow_pattern
	| STUT INTEGER zero2one (zero2one | LBRK MINUS zero2one RBRK)
	| (KNIT)? SYNTH_OP cont_patt
	| (DEG_BY|TRUNC) zero2one
	| (number)? (BEATR|BEATL)
	| int_arg_trans INTEGER
	| EVERY INTEGER LBRK trans_spec RBRK 
	| FOLDEVERY LSQB INTEGER (COMMA INTEGER)+ RSQB LBRK trans_spec RBRK
	| (SOMETIMESBY_ALIASES | SOMETIMESBY zero2one) LBRK trans_spec RBRK
	| WHENMOD INTEGER INTEGER LBRK trans_spec RBRK 
	| WITHIN LBRK zero2one COMMA zero2one RBRK LBRK (trans_spec|(KNIT cont_frag )) RBRK //TODO: may need the 'KNIT' part in other commands
	| JUX LBRK trans_spec (POINT trans_spec)* RBRK //TODO: look at the point thing here for other functions
	| ZOOM LBRK zero2one COMMA zero2one RBRK
	| STRIATE1 INTEGER LBRK INTEGER DIVID INTEGER RBRK
	| SMASH INTEGER LSQB INTEGER (COMMA INTEGER)* RSQB
	| slowspread_pattern
	;	
	
trans_0arg //Transformations with no arguments
	: (BRAK | DEGRADE | REV | PALIN);
	
slow_pattern
	: SLOW number 
	| SLOW LBRK int_or_ratio RBRK
	;
	
slowspread_pattern
	//1: Spread a set of values over a single function:
	: (SPREAD|SLOWSPREAD) LBRK sample_trans RBRK LSQB int_or_ratio (COMMA int_or_ratio)* RSQB
	| (SPREAD|SLOWSPREAD) sample_trans LSQB int_or_ratio (COMMA int_or_ratio)* RSQB
	//2: Spread a bunch of different functions: 
	| SLOWSPREAD LBRK DOLLAR RBRK LSQB  int_or_ratio (COMMA int_or_ratio)* RSQB
	| SPREAD1 sample_trans QUOT (slowspread_atom) QUOT
	;	
	
slowspread_atom
	: int_or_ratio ((COMMA)? int_or_ratio)*
	| LSQB slowspread_atom RSQB
	;	
	
sample_trans_func
	: sample_trans
	;	
	
sample_trans
	: int_arg_trans
	| STUT INTEGER INTEGER
	| STRIATE
	;
	
/* Transformations with a single integer argument */
//TODO: Maybe we can use this wherever we use slow..?	
int_arg_trans
	: (CHOP|DENSITY|SLOW|ITER|STRIATE|GAP)
	;	

/* Numeric expressions */

/*Any number from 0.0 to 0.9999999999 recurring iyswim */
zero2one
	: ONE | (ZERO (POINT INTEGER)?);

/* Any Digit */
//digit: ZERO|DIG19;

	
int_or_ratio
	: INTEGER //number
	| (INTEGER MODUL INTEGER)
	;	

number
    : MINUS? (ZERO|INTEGER)+ (POINT (ZERO|INTEGER)*)?
    ;
    
    
/* any positive integer including 00007 
integer	: DIG19 (DIGIT);*/