/**************** DEFINITIONS *****************/
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
#include "gpp_interpreter.h"

extern YYSTYPE yylval;
int countl = 0;

void* lex_return(char*);
void lex_error(char*);
%}

%option yylineno

/* Lex Declarations */
digit			[0-9]
letter			[a-zA-Z_]
alphanumeric    ({letter}|{digit})
positivenum     ([1-9][0-9]*)
uint            ({positivenum}|{digit})


%%  /*************** RULES ******************/

";;"[^\n]*      { lex_return(COMMENT);  /* Comments */ }

"and"           { lex_return(KW_AND);  /* Keywords */ }
"or"            { lex_return(KW_OR); }
"not"           { lex_return(KW_NOT); }
"eq"            { lex_return(KW_EQ); }
"gt"            { lex_return(KW_GT); }
"set"           { lex_return(KW_SET); }
"defvar"        { lex_return(KW_DEFV); }
"deffun"        { lex_return(KW_DEFF); }
"while"         { lex_return(KW_WHILE); }
"if"            { lex_return(KW_IF); }
"exit"          { lex_return(KW_EXIT); }
"true"          { lex_return(KW_TRUE); }
"false"         { lex_return(KW_FALSE); }

"+"             { lex_return(OP_PLUS);  /* Operators */ }
"-"             { lex_return(OP_MINUS); }
"/"             { lex_return(OP_DIV); }
"*"             { lex_return(OP_MULT); }
"("             { lex_return(OP_OP); }
")"             { lex_return(OP_CP); }
","             { lex_return(OP_COMMA); }

{letter}({alphanumeric})*       { lex_return(IDENTIFIER);  /* Identifier */ }
{uint}f{uint}                   { lex_return(VALUEF);  /* Unsigned fractions */ }

[\n]                            { countl++; /* New line */ /* yylineno = yylineno + 1; */}    
[ \t]+                          { /* remove whitespace */ }
<<EOF>>                         { return 0; /* End */ }    

[0]+[0-9]+                       { lex_error("Invalid integer. Multiple leading zeros"); }
{digit}+{letter}+                { lex_error("Invalid identifier. Identifiers can't start with number"); }
([0]+[0-9]+)f{uint}              { lex_error("Invalid fraction. More than one leading zero in numerator"); }
{uint}f([0]+[0-9]+)              { lex_error("Invalid fraction. More than one leading zero in denominator"); }

.                                {  lex_error("Unrecognized token"); /* Other */
                                    // return *yytext; 

                                    // TODO: add valuei error, negative valuef
                                 }


%%  /*************** FUNCTIONS ******************/

void* lex_return(char const *name) {
    printf("%s : %s\n", yytext, name);
    return name;
}

void lex_error(char const *msg) {
    printf("Syntax Error. %s: '%s'.\n", msg, yytext);
}


// Runs after lex initialization
int yywrap(){ return 1; }
