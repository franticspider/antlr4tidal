lexer grammar Tidal1lexer;

CHANNEL
	: ('d') ('1'..'9')
	;

DOLLAR 
	: '$' 
	;

QUOT 
	: '"'
	;

SND_OP 
	: 'sound' 
	; 
	
CONT_OP
	: 'pan'
	| 'shape'
	;

BRAK	
	: 'brak' 
	;

SAMPLE 
	: 'bd' 
	| 'sn' 
	| 'cp' 
	| 'sd' 
	| 'hh'
	| 'ht'
	| 'lt'
	| 'mt'
	;
	
WAVE
	: 'sinewave1'
	| 'squarewave1'
	| 'triwave1'
	;	

KNIT : '|+|' ;

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

DIGIT
	: ('0'..'9');

WS 
    : [ \r\n\t]+ -> channel(HIDDEN)
    ;

