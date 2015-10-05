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

BRAK	
	: 'brak' 
	;

SAMPLE 
	: 'bd' 
	| 'sn' 
	| 'cp' 
	| 'sd' 
	| 'hh'
	;

KNIT : '|+|' ;

//These all occur inside sound expressions:
LSQB	: '[';
RSQB	: ']';
COMMA	: ',';
COLON	: ':';

TIMES: '*';
POINT: '.';

DIGIT
	: ('0'..'9');

WS 
    : [ \r\n\t]+ -> channel(HIDDEN)
    ;

