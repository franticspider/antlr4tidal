lexer grammar Tidal1lexer;

CHANNEL	: ('d') ('1'..'9');
DOLLAR : '$' ;
QUOT : '"';

SND_OP : 'sound' ; 


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
//SEE  tidalGE.java for ranges for these ops..
SYNTH_OP
	: 'accelerate'
	| 'bandf'
	| 'bandq'
	| 'begin'
	| 'crush'
	| 'cutoff'
	| 'delay'
	| 'delayfeedback'
	| 'delaytime'
	| 'end'
	| 'hcutoff'
	| 'hresonance'
	| 'pan' 
	| 'resonance'
	| 'shape'
	| 'speed'
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
	| '20010320-Samples' | 'breaks157' | 'flick' | 'lighter' | 'sax' | '20020506' | 'breaks165' | 'foo' | 'lt' | 'seawolf' | '808' | 'breath' | 'fuckable' | 'made' | 'sequential' | '909' | 'bubble' | 'future' | 'made2' | 'sf' |
	'ab' | 'can' | 'gab' | 'mash' | 'sheffield' | 'ade' | 'casio' | 'gabba' | 'mash2' | 'short' | 'ades2' | 'cc' | 'gabbaloud' | 'metal' | 'sid' |
	'ades3' | 'chin' | 'gabbalouder'|  'miniyeah'|    'sine'|
	'ades4'|            'chink'|      'glasstap'|     'moan'|        'sitar'|
	'alex'|              'circus'|     'glitch'|       'monsterb'|    'sn'|
	'alphabet' |          'clak' |       'glitch2' |      'moog' |        'space' |
	'amencutup' |         'click' |      'gretsch' |      'mouth' |       'speech' |
	'armora' |            'co' |         'h' |            'mp3' |         'speechless' |
	'arp' |               'cosmicg' |    'hand' |         'msg' |         'speedupdown' |
	'arpy' |              'cp' |         'hardcore' |     'mt' |          'stab' |
	'auto' |              'cr' |         'haw' |          'mute' |        'stomp' |
	'baa' |               'crow' |       'hc' |           'newnotes' |    'subroc3d' |
	'baa2' |              'd' |          'hh' |           'noise' |       'sugar' |
	'bass' |              'db' |         'hh27' |         'noise2' |      'sundance' |
	'bass0' |             'diphone' |    'hit' |          'notes' |      'tabla' |
	'bass1' |             'diphone2' |   'hmm' |          'numbers' |     'tabla2' |
	'bass2' |            'dist' |        'ho' |           'oc' |          'tablex' |
	'bass3' |             'dork2' |     'house' |        'odx' |         'tacscan' |
	'bassdm' |           'dorkbot' |    'ht' |           'off' |         'tech' |
	'bassfoo' |           'dr' |         'if' |           'pad' |         'techno' |
	'battles' |           'dr2' |        'ifdrums' |      'padlong' |     'tink' |
	'bd' |                'dr55' |       'incoming' |     'pebbles' |     'tok' |
	'bend' |              'dr_few' |     'industrial' |   'perc' |        'toys' |
	'bev' |               'drum' |       'insect' |       'peri' |        'trump' |
	'bin' |               'drumtraks' |  'invaders' |     'pluck' |       'ul' |
	'birds3' |            'e' |          'jazz' |         'print' |       'ulgab' |
	'bleep' |             'east' |       'jungbass' |     'printshort' |  'uxay' |
	'blip' |              'electro1' |   'jungle' |       'proc' |        'v' |
	'blue' |              'erk' |        'jvbass' |       'procshort' |   'voodoo' |
	'bottle' |            'f' |          'koy' |          'psr' |         'wind' |
	'breaks125' |         'feel' |       'kurt' |         'rave' |        'wobble' |
	'breaks152' |         'feelfx' |     'latibro' |      'rave2' |       'world' |
	'breaks152loud' |     'fest' |       'led' |          'ravemono' |    'xmas' |
	'breaks152louder' |   'fire' |       'less' |         'rm' |          'yeah'
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
QUESM: '?'; //This is shorthand for the degrade function
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
