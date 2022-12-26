/*************** DECLARATIONS ***************/

%{
    /* C Declarations*/
    #include <stdio.h>
    #include <stdlib.h>

    int pos = 0;

    int yylex();
    int yyerror(char *);
%}

%union{
    int* num;
    char* str;
};

/* Lex Declarations */
%token COMMENT KW_AND KW_OR KW_NOT KW_EQ KW_GT KW_SET KW_DEFV KW_DEFF KW_WHILE KW_IF KW_EXIT KW_TRUE KW_FALSE  
%token OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_COMMA
%token IDENTIFIER VALUEF

/* YACC Declarations  */
%start INPUT

%type <str> EXP
%type <num> EXPLIST
/* %type <num> FUNCTION */

%%

/*************** RULES ***************/
INPUT: EXP      { printf("EXP = %s\n", $1); }
     /* | FUNCTION {} */
     | EXPLIST  { printf("EXPLIST = %d\n", *($1)); }

/* Expression: returns the value of last expression, always fraction */
EXP: OP_OP OP_PLUS EXP EXP OP_CP        {}
   | OP_OP OP_MINUS EXP EXP OP_CP       {}
   | OP_OP OP_MULT EXP EXP OP_CP        {}
   | OP_OP OP_DIV EXP EXP OP_CP         {}
   | IDENTIFIER                         {}
   | VALUEF                             {}
   /* | FCALL                              {} */
   /* | ASG                                {} */
   | OP_OP KW_IF EXPB EXPLIST EXPLIST OP_CP     {}
   | OP_OP KW_WHILE EXPB EXPLIST OP_CP          {}
   | OP_OP KW_DEFV IDENTIFIER EXP OP_CP         { /* declare variable */ }
   | OP_OP KW_SET IDENTIFIER EXP OP_CP          { /* set variable */ }

/* FIX: grammar */
EXPLIST: OP_OP EXP OP_CP        {}
       | OP_OP EXPLIST OP_CP    {}
       /* | OP_OP EXP EXPLIST OP_CP    {} */

/* Assignment: EXP evaulated first */
/* ASG: OP_OP KW_SET IDENTIFIER EXP OP_CP  {} */

/* FUNCTION: OP_OP KW_DEFF IDENTIFIER OP_OP ( | IDENTIFIER | IDENTIFIER IDENTIFIER | IDENTIFIER IDENTIFIER IDENTIFIER ) OP_CP OP_OP EXPLIST OP_CP {} */

/* function definition is an expression, always returns 0f1 */
/* FCALL: OP_OP IDENTIFIER ( | EXP| EXP EXP | EXP EXP EXP ) OP_CP {} */

EXPB: OP_OP KW_EQ EXP EXP OP_CP     { /* returns true if equal */ } 
    | OP_OP KW_GT EXP EXP OP_CP     { /* returns true if greater */ }
    | KW_TRUE | KW_FALSE
    | OP_OP KW_AND EXPB EXPB OP_CP
    | OP_OP KW_OR EXPB EXPB OP_CP
    | OP_OP KW_NOT EXPB OP_CP

%%

/*************** FUNCTIONS ***************/
int yyerror(char *msg)
{
    printf("Syntax Error: '%s'.\n", msg);
    exit(1);
}

int main(int argc, char **argv)
{
    while(1){
        yyparse();
    }
    return 0;
}
