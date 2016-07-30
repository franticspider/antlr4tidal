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
//	package com.antlr4.tidal;
//}
 
	  
tidal    
	: CHANNEL DOLLAR message 
//	| MIDICHAN DOLLAR midimsg
	; //d1 ...d9
/* 
midimsg
	: NOTE_OP QUOT (midi_atom)+ QUOT 
	;
	
midi_atom
	: INTEGER|PAUSE
	;
*/

//TODO: Need to deal with a potential mix of dollars and brackets...
//TODO: Need to put KNIT within the cont_frag - would be neater
//TODO: Need to put the (cont_frag)* stuff at the end of each of these (I think)
message 
	: (trans_spec DOLLAR)* (pattfrag)+ (KNIT cont_frag )*
	| trans_spec LBRK (pattfrag)+ RBRK (KNIT cont_frag )*
	| LBRK message RBRK (KNIT cont_frag )*
	| (APPEND|APPEND1|INTERLACE| (WEDGE LBRK intint DIVID intint RBRK)) LBRK message RBRK LBRK message RBRK
	| (CAT|SLOWCAT|STACK) LSQB pattfrag (COMMA pattfrag)* RSQB
	| SEQP LSQB seqp_spec (COMMA seqp_spec)* RSQB
	| WEAVE INTEGER LBRK trans_spec RBRK LSQB message (COMMA message)* RSQB
	| WEAVE1 INTEGER LBRK message (COMMA pattfrag)* RBRK LSQB trans_spec (COMMA trans_spec)* RSQB
	; 


/* COMPOSITION SPECS */
seqp_spec
	: LBRK (ZERO|INTEGER) COMMA INTEGER  COMMA message RBRK
	;

/* General and Nested Transformations */
pattfrag 
	:  SND_OP sequence
	;

/* Sequence expressions */
sequence 
	: QUOT sample_expr QUOT 
	| trans_spec (POINT LBRK trans_spec RBRK)* QUOT sample_expr QUOT //This causes problems with the next line
	| LBRK sequence RBRK 
	| SAMPLES QUOT sample_expr QUOT samples_seqlist
	| app_func_pattern
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
//	: PAUSE
	: (SAMPLE (COLON intint)? ((TIMES|DIVID) intint)? | (LBRK intint COMMA intint RBRK)) (QUESM)?
	| LSQB sample_expr RSQB  ((TIMES|DIVID) intint)? (QUESM)?//(MODUL DIGIT)? <- I've never seen this with square brackets...
	| LCRB sample_expr RCRB  ((TIMES|DIVID) intint)? (MODUL intint)? (QUESM)?
	;


/* APPLICATIVE FUNCTOR STUFF */

app_func_pattern
	: ((LBRK STAR RBRK)|SYNTH_OP|PICK_OP) 
		APDOLL sequence APSTAR cont_frag
	;



/* Continuous expressions (usually involves |+|)*/
cont_frag 
	: (KNIT)? SYNTH_OP QUOT cont_patt QUOT
	| SYNTH_OP cont_patt
//	|         SYNTH_OP QUOT cont_patt QUOT (KNIT)?
	| VOWEL_OP QUOT (VOWEL)+ QUOT
	| intint //TODO: This shouldn't be here should it?
	| slow_pattern
	//| (cont_frag)? LBRK cont_frag RBRK
	//| CONT_OP cont_patt  
	; 

//TODO: We have both quotes AND brackets around these - need to disentangle the rules!
// pan: uses either quoted number strings or waves
//
cont_patt
	: cont_atom (COMMA cont_atom)*
	| WAVE
	| LBRK trans_spec WAVE RBRK 
	| LBRK cont_patt RBRK
	| QUOT cont_patt QUOT 
	;

cont_atom
	: (number)+
	| (LSQB cont_patt RSQB ((TIMES|DIVID) intint)*)+
	;
/* Transform exprssions */
//transform 
//	: trans_spec LBRK (pattfrag)* RBRK
//	| trans_spec DOLLAR (pattfrag)*
//	; 
	
//TODO: Fix all the 'TODO's in this spec:	
trans_spec
	: trans_0arg
	| LBRK trans_spec  RBRK (POINT LBRK trans_spec RBRK)*
	| slow_pattern
	| STUT INTEGER zero2one (zero2one | LBRK MINUS zero2one RBRK)
	| SUPERIMP LBRK trans_spec RBRK //DOLLAR message
	| cont_frag//(KNIT)? SYNTH_OP cont_patt
	| (DEG_BY|TRUNC) zero2one
	| (number)? (BEATR|BEATL)
	| int_arg_trans intint
	| EVERY INTEGER ((LBRK trans_spec RBRK)| trans_spec) 
	| FOLDEVERY LSQB INTEGER (COMMA INTEGER)+ RSQB LBRK trans_spec RBRK
	| (SOMETIMESBY_ALIASES | SOMETIMESBY zero2one) trans_spec
	| WHENMOD INTEGER INTEGER LBRK trans_spec RBRK 
	| WITHIN LBRK zero2one COMMA zero2one RBRK LBRK (trans_spec|(KNIT cont_frag )) RBRK //TODO: may need the 'KNIT' part in other commands
	| JUX LBRK trans_spec (POINT trans_spec)* RBRK //TODO: look at the point thing here for other functions
	| ZOOM LBRK zero2one COMMA zero2one RBRK
	| STRIATE1 INTEGER LBRK (ONE|INTEGER) DIVID (ONE|INTEGER) RBRK
	| SMASH intint LSQB number (COMMA number)* RSQB
	| slowspread_pattern
	;	
	
trans_0arg //Transformations with no arguments
	: (BRAK | DEGRADE | REV | PALIN);
	
slow_pattern
	//: SLOW (number) //<- this seems to be matching sequences of ints as a single number	 
	: SLOW intint LBRK (int_or_ratio | cont_frag) RBRK
//Experimental for app_func
	| SLOW intint	QUOT (slowspread_atom) QUOT
	;
	
slowspread_pattern
	//1: Spread a set of values over a single function:
	: (SPREAD|SLOWSPREAD) sample_trans LSQB (number|int_or_ratio) (COMMA (number|int_or_ratio))* RSQB
	//2: Spread a bunch of different functions: 
	//| SLOWSPREAD LBRK DOLLAR RBRK LSQB  (number) (COMMA (number))* RSQB
	| SLOWSPREAD LBRK DOLLAR RBRK LSQB trans_spec (COMMA trans_spec)* RSQB
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
	| LBRK sample_trans RBRK
	| STUT intint intint
	| STRIATE
	;
	
/* Transformations with a single integer argument */
//TODO: Maybe we can use this wherever we use slow..?	
int_arg_trans
	: (CHOP|DENSITY|SLOW|ITER|STRIATE|GAP|SPIN)
	;	

/* Numeric expressions */

/*Any number from 0.0 to 0.9999999999 recurring iyswim */
zero2one
	: ONE | (ZERO (POINT INTEGER)?)
	| LBRK zero2one RBRK;

/* Any Digit */
//digit: ZERO|DIG19;

intint
	: (ONE|INTEGER)
	| LBRK intint RBRK
	;
	
int_or_ratio
	: INTEGER //number
	| (INTEGER MODUL INTEGER)
	;	

number
    : MINUS? (ZERO|intint)+ (POINT (ZERO|intint)*)?
    ;
    
    
/* any positive integer including 00007 
integer	: DIG19 (DIGIT);*/