DIGIT			[0-9]
LETTER			[a-zA-Z_]
ALPHANUMERIC    ({LETTER}|{DIGIT})

%{
/*
The G++ Language

Keywords: and, or, not, equal, less, nil, list, append, concat, set, deffun, for, if, exit, load, disp, true, false 
(KW_AND, KW_OR, KW_NOT, KW_EQUAL, KW_LESS, KW_NIL, KW_LIST, KW_APPEND, KW_CONCAT, KW_SET, KW_DEFFUN, KW_FOR, KW_IF, KW_EXIT, KW_LOAD, KW_DISP, KW_TRUE, KW_FALSE)
Operators: + - / * ( ) ** “ “ ,
(OP_PLUS, OP_MINUS, OP_DIV, OP_DIV2, OP_MULT, OP_OP, OP_CP, OP_DBLMULT, OP_OC, OP_CC, OP_COMMA)
Comment: Line or part of the line starting with ;;
(COMMENT)

Unsigned integers: any combination of digits with no leading zeros on the left. 0 is considered an instance.
(VALUEI)
Unsigned fractions: two unsigned integers separated by the character “f”. E.g., 123f12 is the fraction 123/12
(VALUEF)
String: any combination of characters enclosed in double quotes. E.g., “G++ is best” is a string.

Identifier: Any combination of alphabetical characters, digits and “_” with no leading digit.
(IDENTIFIER)

*/

// Declarations
#include <stdio.h>
#include <stdlib.h>

FILE *src;

void lex_print(char*);
void is_string();
void lex_error(char*);
%}


%%
";;"[^\n]*      { lex_print("COMMENT");  /* Comments */ }

"and"           { lex_print("KW_AND");  /* Keywords */ }
"or"            { lex_print("KW_OR"); }
"not"           { lex_print("KW_NOT"); }
"equal"         { lex_print("KW_EQUAL"); }
"less"          { lex_print("KW_LESS"); }
"nil"           { lex_print("KW_NIL"); }
"list"          { lex_print("KW_LIST"); }
"append"        { lex_print("KW_APPEND"); }
"concat"        { lex_print("KW_CONCAT"); }
"set"           { lex_print("KW_SET"); }
"deffun"        { lex_print("KW_DEFFUN"); }
"for"           { lex_print("KW_FOR"); }
"if"            { lex_print("KW_IF"); }
"exit"          { lex_print("KW_EXIT"); }
"load"          { lex_print("KW_LOAD"); }
"disp"          { lex_print("KW_DISP"); }
"true"          { lex_print("KW_TRUE"); }
"false"         { lex_print("KW_FALSE"); }

"+"             { lex_print("OP_PLUS");  /* Operators */ }
"-"             { lex_print("OP_MINUS"); }
"/"             { lex_print("OP_DIV"); }
"*"             { lex_print("OP_MULT"); }
"("             { lex_print("OP_OP"); }
")"             { lex_print("OP_CP"); }
"**"            { lex_print("OP_DBLMULT"); }
","             { lex_print("OP_COMMA"); }

"\""	        { is_string(); /* Strings */ }
LETTER?\"(\\.|[^\\"\n])*\"	{ lex_print("STRING_LITERAL"); }

[{LETTER}][{LETTER}0-9]*  { lex_print("IDENTIFIER");  /* Identifiers */ }

[ \t\n]+        { /* remove whitespace */ }
<<EOF>>         { return 0; /* End */ }
.               { lex_print("Unrecognized token"); /* Other */ }
%%

void lex_print(char *name) {
    printf("%s : %s\n", yytext, name);
}

void is_string() {
	char c, prev = 0;

    lex_print("OP_OC");

	while ((c = input()) != EOF) {
        if(c != '"') printf("%c", c);
		if (c == '"' && prev != '\\') {
            printf(": VALUESTR\n");
			return lex_print("OP_CC");
        }
		prev = c;
	}
	lex_error("Not ending string");
}

void lex_error(char *msg) {
    printf("Lexical Error: %s\n", msg);
}

// Runs after lex initialization
int yywrap(){
    return 1;
}
int main(int argc, char *argv[]) {
    int i;
    for(i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }

    printf("here0");
    if(argc > 1) {
        for(i = 1; i < argc; i++) {
            printf("here0.5");
            src = fopen(argv[i], "r");
            if (src == NULL) {
                printf("Couldn't open file: %s\n", argv[i]);
                continue;
            }
            
            printf("\n\n\nLexing %s...\n\n", argv[i]);

            yyin = src;
            yylex();
            fclose(src);

            printf("\n");
        }
        printf("here1");
    }
    
    // REPL
    printf("here2");
    yyin = stdin;
    yylex();

    return 0;
}
