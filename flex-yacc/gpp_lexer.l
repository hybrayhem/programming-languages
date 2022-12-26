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
#include "gpp_interpreter.h"

extern YYSTYPE yylval;
int countl = 0;

char* lex_return(char*);
void lex_error(char*);
%}

%option yylineno

/* Lex Declarations */
digit			[0-9]
letter			[a-zA-Z_]
alphanumeric    ({letter}|{digit})
positivenum     ([1-9][0-9]*)
uint            ({positivenum}|{digit})

COMMENT         ";;"[^\n]*

KW_AND          "and"   
KW_OR           "or"    
KW_NOT          "not"   
KW_EQ           "eq"    
KW_GT           "gt"    
KW_SET          "set"   
KW_DEFV         "defvar"
KW_DEFF         "deffun"
KW_WHILE        "while" 
KW_IF           "if"    
KW_EXIT         "exit"  
KW_TRUE         "true"  
KW_FALSE        "false"

OP_PLUS         "+"
OP_MINUS        "-"
OP_DIV          "/"
OP_MULT         "*"
OP_OP           "("
OP_CP           ")"
OP_COMMA        ","

IDENTIFIER      {letter}({alphanumeric})*
VALUEF          {uint}f{uint} 


%%  /*************** RULES ******************/

COMMENT         { lex_return("COMMENT");  /* Comments */ }

KW_AND          { lex_return("KW_AND");  /* Keywords */ }
KW_OR           { lex_return("KW_OR"); }
KW_NOT          { lex_return("KW_NOT"); }
KW_EQ           { lex_return("KW_EQ"); }
KW_GT           { lex_return("KW_GT"); }
KW_SET          { lex_return("KW_SET"); }
KW_DEFV         { lex_return("KW_DEFV"); }
KW_DEFF         { lex_return("KW_DEFF"); }
KW_WHILE        { lex_return("KW_WHILE"); }
KW_IF           { lex_return("KW_IF"); }
KW_EXIT         { lex_return("KW_EXIT"); }
KW_TRUE         { lex_return("KW_TRUE"); }
KW_FALSE        { lex_return("KW_FALSE"); }

OP_PLUS         { lex_return("OP_PLUS");  /* Operators */ }
OP_MINUS        { lex_return("OP_MINUS"); }
OP_DIV          { lex_return("OP_DIV"); }
OP_MULT         { lex_return("OP_MULT"); }
OP_OP           { lex_return("OP_OP"); }
OP_CP           { lex_return("OP_CP"); }
OP_COMMA        { lex_return("OP_COMMA"); }

IDENTIFIER      { lex_return("IDENTIFIER");  /* Identifier */ }
VALUEF          { lex_return("VALUEF");  /* Unsigned fractions */ }

[ \t\n]+                        { /* remove whitespace */ }
<<EOF>>                         { return 0; /* End */ }    

[0]+[0-9]+                       { lex_error("Invalid integer. Multiple leading zeros"); }
{digit}+{letter}+                { lex_error("Invalid identifier. Identifiers can't start with number"); }
([0]+[0-9]+)f{uint}              { lex_error("Invalid fraction. More than one leading zero in numerator"); }
{uint}f([0]+[0-9]+)              { lex_error("Invalid fraction. More than one leading zero in denominator"); }

.                                { lex_error("Unrecognized token"); /* Other */ }


%%  /*************** FUNCTIONS ******************/

/* TODO: lex_return */
char* lex_return(char *name) {
    printf("%s : %s\n", yytext, name);
    return name;
}

void lex_error(char *msg) {
    printf("Syntax Error. %s: '%s'.\n", msg, yytext);
}


// Runs after lex initialization
int yywrap(){
    return 1;
}
/* int main(int argc, char *argv[]) {
    // REPL
    yylex();

    return 0;
} */
