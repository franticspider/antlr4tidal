/**
 * Define a grammar called Hello
 */
grammar Hello;     // match keyword hello followed by an identifier

num_seq: (MYINT)*;

MYINT: ('1'..'9')('0'..'9')*;

ID : [a-z]+ ;             // match lower-case identifiers

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

