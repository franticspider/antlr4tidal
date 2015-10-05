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

	
tidal : CHANNEL pattern; //d1 ...d9

pattern : (pattfrag)+; 

//TODO: We always need a SND_OP to manip
pattfrag 
	: DOLLAR SND_OP sample_set 
	| DOLLAR BRAK;



sample_set : QUOT sample_expr QUOT ;

sample_expr
	: (sample_atom)+ (COMMA (sample_atom)+ )*
//	| LSQB (sample_atom)+ RSQB (TIMES DIGIT)?
	;
	
//sample_comma_expr
//	: sample_atom COMMA sample_atom
//	;	
	
sample_atom
	: 	  (SAMPLE (COLON DIGIT)? (TIMES DIGIT)? )+
	| LSQB sample_expr RSQB  (TIMES DIGIT)?
	;

integer
	: (DIGIT)+;

number
    :  DIGIT+ (POINT DIGIT+)?
    ;  