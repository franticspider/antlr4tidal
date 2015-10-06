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

//1 integer arg:
SLOW: 'slow';
ITER: 'iter';
DENSITY: 'density';

//1 float arg:
DEG_BY: 'degradeBy';

//complex:
EVERY: 'every';
JUX: 'jux';
STRIATE: 'striate';
STRIATE1: 'striate\'';

SYNTH_OP
	: 'accelerate'
	| 'speed'
	;
	
VOWEL_OP: 'vowel';
VOWEL: 'a'|'e'|'i'|'o'|'u';
	

/* SAMPLES */

SAMPLE 
	: '~'
	| 'bd' 
	| 'bev'
	| 'can'
	| 'cp'
	| 'feel' 
	| 'hh'
	| 'ht'
	| 'kurt'
	| 'lt'
	| 'mt'
	| 'sn'  
	| 'sd' 
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

ZERO: '0';
DIGIT: ('0'..'9');

WS : [ \r\n\t]+ -> channel(HIDDEN);

