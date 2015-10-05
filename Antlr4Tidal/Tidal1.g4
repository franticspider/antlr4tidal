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

	
tidal : CHANNEL message (KNIT cont_frag )*; //d1 ...d9

message : (pattfrag)*; 


/* General and Nested Transformations */



//TODO: We always need a SND_OP to manip
pattfrag 
	: DOLLAR SND_OP sequence 
	| DOLLAR BRAK;


/* Sequence expressions */

sequence : QUOT sample_expr QUOT ;

sample_expr
	: (sample_atom)+ (COMMA (sample_atom)+ )*
//	| LSQB (sample_atom)+ RSQB (TIMES DIGIT)?
	;
	
//sample_comma_expr
//	: sample_atom COMMA sample_atom
//	;	
	
sample_atom
	: 	  (SAMPLE (COLON DIGIT)? ((TIMES|DIVID) DIGIT)? )+
	| LSQB sample_expr RSQB  (TIMES DIGIT)?
	| LCRB sample_expr RCRB  (TIMES DIGIT)? (MODUL DIGIT)?
	;

/* Continuous expressions */

cont_frag : CONT_OP cont_patt;

cont_patt
	: QUOT (number)* QUOT
	| WAVE
	;



/* Numeric expressions */
integer
	: (DIGIT)+;

number
    :  DIGIT+ (POINT DIGIT+)?
    ;  