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

void lex_error(char const*);

int countln = 1;
extern YYSTYPE yylval;
%}

%option yylineno

/* Lex Declarations */
digit			[0-9]
letter			[a-zA-Z_]
alphanumeric    ({letter}|{digit})
positivenum     ([1-9][0-9]*)
uint            ({positivenum}|{digit})


%%  /*************** RULES ******************/

";;"[^\n]*      { return COMMENT;  /* Comments */ }

"and"           { return KW_AND;  /* Keywords */ }
"or"            { return KW_OR; }
"not"           { return KW_NOT; }
"eq"            { return KW_EQ; }
"gt"            { return KW_GT; }
"set"           { return KW_SET; }
"defvar"        { return KW_DEFV; }
"deffun"        { return KW_DEFF; }
"while"         { return KW_WHILE; }
"if"            { return KW_IF; }
"exit"          { return KW_EXIT; }
"true"          { return KW_TRUE; }
"false"         { return KW_FALSE; }

"+"             { return OP_PLUS;  /* Operators */ }
"-"             { return OP_MINUS; }
"/"             { return OP_DIV; }
"*"             { return OP_MULT; }
"("             { return OP_OP; }
")"             { return OP_CP; }
","             { return OP_COMMA; }

{letter}({alphanumeric})*       { strcpy(yylval.str, yytext); return IDENTIFIER;  /* Identifier */ }
{uint}f{uint}                   { strcpy(yylval.str, yytext); return VALUEF;  /* Unsigned fractions */ }

[\n]                            { countln++; /* New line */ /* yylineno = yylineno + 1; */}    
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

void lex_error(char const *msg) {
    printf("Syntax Error at line %d. %s: '%s'.\n", countln, msg, yytext);
    /* exit(1); */
}


// Runs after lex initialization
int yywrap(){}
