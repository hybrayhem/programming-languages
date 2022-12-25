/*************** DEFINITIONS ******************/
%{
/*
The G++ Language

Keywords: and, or, not, eq, gt, set, defvar, deffun, while, if, true, false
(KW_AND, KW_OR, KW_NOT, KW_EQ, KW_GT, KW_SET, KW_DEFV, KW_DEFF, KW_WHILE, KW_IF, KW_EXIT, KW_TRUE, KW_FALSE)
Operators: + - / * ( ) ,
(OP_PLUS, OP_MINUS, OP_DIV, OP_MULT, OP_OP, OP_CP, OP_COMMA)
Comment: Line or part of the line starting with ;;
(COMMENT)

Unsigned fractions: two unsigned integers separated by the character “f”. E.g., 123f12 is the fraction 123/12
(VALUEF)

Identifier: Any combination of alphabetical characters, digits and “_” with no leading digit.
(IDENTIFIER)

*/

/* C Declarations */
#include <stdio.h>

void lex_print(char*);
void lex_error(char*);
%}

/* Lex Declarations */
DIGIT			[0-9]
LETTER			[a-zA-Z_]
ALPHANUMERIC    ({LETTER}|{DIGIT})
POSITIVENUM     ([1-9][0-9]*)
UINT            ({POSITIVENUM}|{DIGIT})

%%  /*************** RULES ******************/

";;"[^\n]*      { lex_print("COMMENT");  /* Comments */ }

"and"           { lex_print("KW_AND");  /* Keywords */ }
"or"            { lex_print("KW_OR"); }
"not"           { lex_print("KW_NOT"); }
"eq"            { lex_print("KW_EQ"); }
"gt"            { lex_print("KW_GT"); }
"set"           { lex_print("KW_SET"); }
"defvar"        { lex_print("KW_DEFV"); }
"deffun"        { lex_print("KW_DEFF"); }
"while"         { lex_print("KW_WHILE"); }
"if"            { lex_print("KW_IF"); }
"exit"          { lex_print("KW_EXIT"); }
"true"          { lex_print("KW_TRUE"); }
"false"         { lex_print("KW_FALSE"); }

"+"             { lex_print("OP_PLUS");  /* Operators */ }
"-"             { lex_print("OP_MINUS"); }
"/"             { lex_print("OP_DIV"); }
"*"             { lex_print("OP_MULT"); }
"("             { lex_print("OP_OP"); }
")"             { lex_print("OP_CP"); }
","             { lex_print("OP_COMMA"); }

{LETTER}({LETTER}|{DIGIT})*     { lex_print("IDENTIFIER");  /* Identifier */ }
{UINT}                          { lex_print("VALUEI");  /* Unsigned integer */ }
{UINT}f{UINT}                   { lex_print("VALUEF");  /* Unsigned fractions */ }

[ \t\n]+                        { /* remove whitespace */ }
<<EOF>>                         { /* End */ }    

[0]+[0-9]+                       { lex_error("Invalid integer. Multiple leading zeros"); }
{DIGIT}+{LETTER}+                { lex_error("Invalid identifier. Identifiers can't start with number"); }
([0]+[0-9]+)f{UINT}              { lex_error("Invalid fraction. More than one leading zero in numerator"); }
{UINT}f([0]+[0-9]+)              { lex_error("Invalid fraction. More than one leading zero in denominator"); }

.                                { lex_error("Unrecognized token"); /* Other */ }

%%  /*************** FUNCTIONS ******************/

/* TODO: lex_return */
void lex_print(char *name) {
    printf("%s : %s\n", yytext, name);
}

void lex_error(char *msg) {
    printf("Lexical Error. %s: '%s'.\n", msg, yytext);
}


// Runs after lex initialization
int yywrap(){
    return 1;
}
int main(int argc, char *argv[]) {
    // REPL
    yylex();

    return 0;
}
