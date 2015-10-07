lexer grammar Tidal1lexer;

CHANNEL	: ('d') ('1'..'9');
DOLLAR : '$' ;
QUOT : '"';

SND_OP : 'sound' ; 

//TODO: some CONT_OPs apply elsewhere
	
CONT_OP
	: 'pan'
	| 'shape'
	;

/* Pattern Transforms */
//0 args:
BRAK: 'brak' ;
DEGRADE: 'degrade';
REV	: 'rev';
PALIN : 'palindrome';

//1 integer arg:
ITER: 'iter';
DENSITY: 'density';

//1 float arg:
DEG_BY: 'degradeBy';
SLOW: 'slow';
TRUNC: 'trunc';

//complex:
EVERY: 'every';
JUX: 'jux';
STRIATE: 'striate';
STRIATE1: 'striate\'';
SLOWSPREAD: 'slowspread';
SMASH: 'smash';
SPREAD: 'spread';
SPREAD1: 'spread\'';
STUT: 'stut';

/* SAMPLE TRANSFORMS */
CHOP: 'chop';



SYNTH_OP
	: 'accelerate'
	| 'speed'
	;
	
VOWEL_OP: 'vowel';
VOWEL: 'a'|'e'|'i'|'o'|'u';
	

/* SAMPLES */

SAMPLE 
	: '~'
	| 'arpy'
	| 'bd' 
	| 'bev'
	| 'can'
	| 'cp'
	| 'feel' 
	| 'future'
	| 'hc'
	| 'hh'
	| 'ho'
	| 'ht'
	| 'jvbass'
	| 'kurt'
	| 'lt'
	| 'mt'
	| 'sn'  
	| 'sd'
	| 'sid' 
	;
	
WAVE
	: 'sinewave1'
	| 'squarewave1'
	| 'triwave1'
	;	

KNIT : '|+|' ;
BEATR : '~>';
BEATL : '<~';

LBRK	: '(';
RBRK	: ')';

//These all occur inside sound expressions:
LSQB	: '[';
RSQB	: ']';
LCRB	: '{';
RCRB	: '}';
COMMA	: ',';
COLON	: ':';

TIMES: '*';
POINT: '.';
MODUL: '%';
DIVID: '/';
MINUS: '-';
QUESM: '?';


//DIGIT: ('0'..'9');
//DIG19: ('1'..'9');
//INTEGER: ('0'..'9') | (('1'..'9')('0'..'9')+);  
INTEGER: ('0'..'9')+;// | (('1'..'9')('0'..'9')+);  

ZERO: '0';


/* This is from http://stackoverflow.com/questions/15503561/antlr4-whitespace-handling */
IDENTIFIER : [a-zA-Z]+;


WS : [ \r\n\t]+ -> channel(HIDDEN);
