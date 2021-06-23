lexer grammar ChillLexer;

//Keywords
ABSOLUTE:           'ABSOLUTE';
ACCESS:             'ACCESS';
AFTER:              'AFTER';
ALL:                'ALL';
ALLOCATE:           'ALLOCATE';
AND:                'AND';
ANDIF:              'ANDIF';
ANY:                'ANY';
ANY_ASSIGN:         'ANY_ASSIGN';
ANY_DISCRETE:       'ANY_DISCRETE';
ANY_INT:            'ANY_INT';
ANY_REAL:           'ANY_REAL';
ARRAY:              'ARRAY';
ASM_KEYWORD:        'ASM_KEYWORD';
ASSERT:             'ASSERT';
ASSOCIATION:        'ASSOCIATION';
AT:                 'AT';

BASED:              'BASED';
BEGINTOKEN:         'BEGINTOKEN';
BIN:                'BIN';
BIT:                'BIT';
BITSTRING:          'BITSTRING';
BODY:               'BODY';
BOOL:               'BOOL';
BOOLS:              'BOOLS';
BUFFER:             'BUFFER';
BUFFERNAME:         'BUFFERNAME';
BUFFER_CODE:        'BUFFER_CODE';
BY:                 'BY';

CALL:               'CALL';
CASE:               'CASE';
CAUSE:              'CAUSE';
CDDEL:              'CDDEL';
CHAR:               'CHAR';
CHARS:              'CHARS';
CONST:              'CONST';
CONTEXT:            'CONTEXT';
CONTINUE:           'CONTINUE';
CYCLE:              'CYCLE';

DCL:                'DCL';
DELAY:              'DELAY';
DO:                 'DO';
DOWN:               'DOWN';
DYNAMIC:            'DYNAMIC';

ELSE:               'ELSE';
ELSIF:              'ELSIF';
END:                'END';
ENTRY:              'ENTRY';
ESAC:               'ESAC';
EVENT:              'EVENT';
EVENT_CODE:         'EVENT_CODE';
EVER:               'EVER';
EXCEPTIONS:         'EXCEPTIONS';
EXIT:               'EXIT';
EXPR:               'EXPR';

FI:                 'FI';
FLOATING:           'FLOATING';
FOR:                'FOR';
FORBID:             'FORBID';

GENERAL:            'GENERAL';
GOTO:               'GOTO';
GRANT:              'GRANT';

HEADEREL:           'HEADEREL';

IF:                 'IF';
IGNORED_DIRECTIVE:  'IGNORED_DIRECTIVE';
IN:                 'IN';
INIT:               'INIT';
INOUT:              'INOUT';
INLINE:             'INLINE';

LOC:                'LOC';
LPRN:               'LPRN';

MODULE:             'MODULE';

NAME:               'NAME';
NEW:                'NEW';
NEWMODE:            'NEWMODE';
NONREF:             'NONREF';
NOPACK:             'NOPACK';
NOT:                'NOT';
NUMBER:             'NUMBER';

OD:                 'OD';
OF:                 'OF';
ON:                 'ON';
OR:                 'OR';
ORIF:               'ORIF';
OUT:                'OUT';

PACK:               'PACK';
PARAMATTR:          'PARAMATTR';
PERVASIVE:          'PERVASIVE';
POS:                'POS';
POWERSET:           'POWERSET';
PREFIXED:           'PREFIXED';
PRIORITY:           'PRIORITY';
PROC:               'PROC';
PROCESS:            'PROCESS';

RANGE:              'RANGE';
READ:               'READ';
READTEXT:           'READTEXT';
RECEIVE:            'RECEIVE';
RECURSIVE:          'RECURSIVE';
REF:                'REF';
REGION:             'REGION';
REM:                'REM';
REMOTE:             'REMOTE';
RESULT:             'RESULT';
RETURN:             'RETURN';
RETURNS:            'RETURNS';
ROUND:              'ROUND';
ROW:                'ROW';
RPRN:               'RPRN';
RPRN_COLON:         'RPRN_COLON';

SAME:               'SAME';
SEIZE:              'SEIZE';
SEND:               'SEND';
SET:                'SET';
SHARED:             'SHARED';
SIGNAL:             'SIGNAL';
SIGNALNAME:         'SIGNALNAME';
SIMPLE:             'SIMPLE';
SINGLECHAR:         'SINGLECHAR';
SPEC:               'SPEC';
START:              'START';
STATIC:             'STATIC';
STEP:               'STEP';
STOP:               'STOP';
STREAM:             'STREAM';
STRING:             'STRING';
STRUCT:             'STRUCT';
SYN:                'SYN';
SYNMODE:            'SYNMODE';

TERMINATE:          'TERMINATE';
TEXT:               'TEXT';
THEN:               'THEN';
THIS:               'THIS';
TIMEOUT:            'TIMEOUT';
TO:                 'TO';
TRUNC:              'TRUNC';
TYPENAME:           'TYPENAME';

UP:                 'UP';
USAGE:              'USAGE';

VARYING:            'VARYING';

WHERE:              'WHERE';
WHILE:              'WHILE';
WITH:               'WITH';

XOR:                'XOR';

/* Compiler directives */
ALL_STATIC_OFF:                 'ALL_STATIC_OFF';
ALL_STATIC_ON:                  'ALL_STATIC_ON';
EMPTY_OFF:                      'EMPTY_OFF';
EMPTY_ON:                       'EMPTY_ON';
GRANT_FILE_SIZE:                'GRANT_FILE_SIZE';
PROCESS_TYPE_TOKEN:             'PROCESS_TYPE_TOKEN';
RANGE_OFF:                      'RANGE_OFF';
RANGE_ON:                       'RANGE_ON';
SEND_BUFFER_DEFAULT_PRIORITY:   'SEND_BUFFER_DEFAULT_PRIORITY';
SEND_SIGNAL_DEFAULT_PRIORITY:   'SEND_SIGNAL_DEFAULT_PRIORITY';
SIGNAL_CODE:                    'SIGNAL_CODE';
SIGNAL_MAX_LENGTH:              'SIGNAL_MAX_LENGTH';
USE_SEIZE_FILE:                 'USE_SEIZE_FILE';
USE_SEIZE_FILE_RESTRICTED:      'USE_SEIZE_FILE_RESTRICTED';
USE_GRANT_FILE:                 'USE_GRANT_FILE';


TRUE:               'TRUE';
FALSE:              'FALSE';

BOOL_LITERAL:       TRUE
            |       FALSE
            ;

NULL_LITERAL:       'NULL';

// Separators
LPAREN:             '(';
RPAREN:             ')';
LC:                 '{';
RC:                 '}';
LPC:                '['|
                    '(:';
RPC:                ']'|
                    ':)';
COLON:              ':';
SC:                 ';';
COMMA:              ',';
DOT:                '.';

STRING_CHAR_PREFIX: '\'';
WIDE_CHAR_PREFIX:   ('W\''|'w\'');
UNDERSCORE:         '_';
EXCLAMATION_MARK:   '!';
QUOTATION_MARK:     '"';
CIRCUMFLEX:         '^';

// Operators
ASGN:             ':=';
GT:                '>';
LT:                '<';
EQL:               '=';
LTE:               '<=';
GTE:               '>=';
PLUS:              '+';
SUB:               '-';
ARROW:             '->';
MUL:               '*';
EXPO:              '**';
DIV:               '/';
CONCAT:            '//';
NE:                '/=';
MOD:               '%';
HASHTAG:           '#';

DIRECTIVE_MARKER:  '<>';

DECIMAL_NUMBER:    '0' | [1-9] (DIGIT? | UNDERSCORE+ DIGIT);
HEX_NUMBER:        '0' [0-9a-fA-F] ([0-9a-fA-F_]* [0-9a-fA-F])?;
OCT_NUMBER:        '0' '_'* [0-7] ([0-7_]* [0-7])?;
BINARY_NUMBER:     '0' [01] ([01_]* [01])?;

DECIMAL_LITERAL_PREFIX:       'D\''|'d\'';
BINARY_LITERAL_PREFIX:        'B\''|'b\'';
HEX_LITERAL_PREFIX:           'H\''|'h\'';
OCT_LITERAL_PREFIX:           'O\''|'o\'';

DECIMAL_LITERAL:       DECIMAL_LITERAL_PREFIX? DECIMAL_NUMBER;
BINARY_LITERAL:        BINARY_LITERAL_PREFIX? BINARY_NUMBER;
HEX_LITERAL:           HEX_LITERAL_PREFIX? HEX_NUMBER;
OCT_LITERAL:           OCT_LITERAL_PREFIX? OCT_NUMBER;

BRACKETED_COMMENT
    : '/*'.*?'*/'-> channel(HIDDEN)
    ;

LINE_END_COMMENT
    : SUB SUB ~[\r\n]* -> channel(HIDDEN)
    ;

WS
    : [ \t\r\n\u000C]+ -> channel(HIDDEN)
    ;

SIMPLE_NAME_STRING
    : LETTER (LETTER|DIGIT|UNDERSCORE)*
    ;

//TODO check
NON_RESERVED_CHARACTER
    : LETTER
    ;

//TODO check
NON_RESERVED_WIDE_CHARACTER
    : NON_RESERVED_CHARACTER
    ;

COMMENT
    : BRACKETED_COMMENT
    | LINE_END_COMMENT
    ;


FILE_NAME_NAME
    : (LETTER | DIGIT | UNDERSCORE )+;

FILE_EXTENSION
    : (LETTER | DIGIT | UNDERSCORE )+;

FILE_NAME
    : FILE_NAME_NAME DOT FILE_EXTENSION;

DIRECTIVE
    : DIRECTIVE_MARKER DIRECTIVE_BODY DIRECTIVE_MARKER;

DIRECTIVE_BODY
    : ALL_STATIC_OFF
    | ALL_STATIC_ON
    | EMPTY_OFF
    | EMPTY_ON
    | IGNORED_DIRECTIVE
    | PROCESS_TYPE_TOKEN EQL DECIMAL_LITERAL
    | RANGE_OFF
    | RANGE_ON
    | SEND_SIGNAL_DEFAULT_PRIORITY EQL DECIMAL_LITERAL
    | SEND_BUFFER_DEFAULT_PRIORITY EQL DECIMAL_LITERAL
    | SIGNAL_CODE EQL DECIMAL_LITERAL
    | USE_SEIZE_FILE STRING_CHAR_PREFIX FILE_NAME STRING_CHAR_PREFIX
    | USE_SEIZE_FILE_RESTRICTED STRING_CHAR_PREFIX FILE_NAME STRING_CHAR_PREFIX;

FLOATING_POINT_MODE_NAME
    : 'FLOAT'
    | 'LONG_FLOAT'
    | 'SHORT_FLOAT'
    ;

CHARACTER_MODE_NAME
    : CHAR
    | 'WCHAR'
    ;

WIDE_CHARACTER_PREFIX
    : 'W\''
    | 'w\''
    ;

//TODO check, as these are only the predefined
INTEGER_MODE_NAME
    : 'INT'
    | 'LONG_INT'
    | 'SHORT_INT'
    | 'UNSIGNED_INT'
    ;

STRING_TYPE
    : BOOLS
    | CHARS
    | 'WCHARS'
    ;

E: 'E';

LETTER
    : 'A' | 'B' | 'C' | 'D' |  E  | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M'
    | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'
    | 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'
    | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z'
    ;

DIGIT
    : '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
    ;