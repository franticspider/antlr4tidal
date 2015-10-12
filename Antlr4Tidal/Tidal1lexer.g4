lexer grammar Tidal1lexer;

CHANNEL	: ('d') ('1'..'9');
DOLLAR : '$' ;
QUOT : '"';

SND_OP : 'sound' ; 

//TODO: some CONT_OPs apply elsewhere
	

/* Pattern Transforms */
//0 args:
BRAK: 'brak' ;
DEGRADE: 'degrade';
REV	: 'rev';
PALIN : 'palindrome';

//1 integer arg:
ITER: 'iter';
DENSITY: 'density';
CHOP: 'chop';
STRIATE: 'striate';
GAP: 'gap';

//This is different from the above, but still has 1 arg
RUN: 'run';


//1 float arg:
DEG_BY: 'degradeBy';
SLOW: 'slow';
TRUNC: 'trunc';


//complex:
EVERY: 'every';
FOLDEVERY: 'foldEvery';
JUX: 'jux';
SAMPLES: 'samples';
SLOWSPREAD: 'slowspread';
SMASH: 'smash';
SOMETIMESBY: 'sometimesBy';
SPREAD: 'spread';
SPREAD1: 'spread\'';
STRIATE1: 'striate\'';
STUT: 'stut';
WHENMOD: 'whenmod';
WITHIN: 'within';
ZOOM: 'zoom';

SOMETIMESBY_ALIASES
	: 'sometimes'
	| 'often'
	| 'rarely'
	| 'almostNever'
	| 'almostAlways'
	;

//TODO: possibly reorganize so that patterns from 0 to 1 are separate
SYNTH_OP
	: 'accelerate'
	| 'crush'
	| 'shape'
	| 'speed'
	;

CONT_OP
	: 'pan'
	| 'shape'
	;
	
PICK_OP
	: 'pick'
	;	
	
VOWEL_OP: 'vowel';
VOWEL: 'a'|'e'|'i'|'o'|'u';
	
/* COMPOSITIONS */

APPEND: 'append';
APPEND1: 'append\'';
CAT: 'cat';
INTERLACE: 'interlace';
SEQP: 'seqP';
SLOWCAT: 'slowcat';
SPIN: 'spin'; //shouldn't be in compositions imho
STACK: 'stack';
SUPERIMP: 'superimpose';
WEAVE: 'weave';
WEAVE1: 'weave\'';
WEDGE: 'wedge';


/* SAMPLES */

SAMPLE 
	: '~'
	| 'arp'
	| 'arpy'
	| 'bass3'
	| 'bd' 
	| 'bd8' //often we have several directories of bd
	| 'bev'
	| 'blip'
	| 'can'
	| 'cp'
	| 'drum'
	| 'feel' 
	| 'future'
	| 'hc'
	| 'hh'
	| 'ho'
	| 'ht'
	| 'jvbass'
	| 'kurt'
	| 'lt'
	| 'mouth'
	| 'mt'
	| 'odx'
	| 'rave'
	| 'sn'  
	| 'sd'
	| 'sid' 
	| 'tabla'
	;
	
WAVE
	: 'sinewave1'
	| 'sine1'
	| 'squarewave1'
	| 'triwave1'
	;	

KNIT : '|+|' ;
BEATR : '~>';
BEATL : '<~';

APDOLL: '<$>';
APSTAR: '<*>';

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
STAR:  '*';	

//zero needs to be before Integer (I think..)
ZERO: '0';
ONE: '1';
//DIGIT: ('0'..'9');
//DIG19: ('1'..'9');
//INTEGER: ('0'..'9') | (('1'..'9')('0'..'9')+);  
INTEGER: ('0'..'9')+;// | (('1'..'9')('0'..'9')+);  



/* This is from http://stackoverflow.com/questions/15503561/antlr4-whitespace-handling */
IDENTIFIER : [a-zA-Z]+;


WS : [ \r\n\t]+ -> channel(HIDDEN);
