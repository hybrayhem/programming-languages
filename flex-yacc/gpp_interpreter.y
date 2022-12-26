/*************** DECLARATIONS ***************/

%{
    /* C Declarations*/
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    int pos = 0;

    int yylex();
    int yyerror(char*);

    double parse_fractd(char const *);
    double get_id_value(char const *);
%}

%union{

    int num;
    int *nums;
    double fnum; // fraction number
    double *fnums; // fraction number array
    char str[247];
    
};

/* YACC Declarations  */
%start INPUT

%token COMMENT KW_AND KW_OR KW_NOT KW_EQ KW_GT KW_SET KW_DEFV KW_DEFF KW_WHILE KW_IF KW_EXIT KW_TRUE KW_FALSE  
%token OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_COMMA
%token <str> IDENTIFIER 
%token <fnum> VALUEF

%type <fnum> INPUT
%type <fnum> EXP
// %type <fnum> EXPB
// %type <fnums> EXPLIST
/* %type <fnums> FUNCTION */

%%

/*************** RULES ***************/
INPUT: EXP            { printf("EXP = %f\n", $1); }
     | INPUT EXP      {}
     /* | FUNCTION {} */
//      | EXPLIST  { printf("EXPLIST = %d\n", *($1)); }
     | COMMENT        {}
     | INPUT COMMENT  {}


/* Expression: returns the value of last expression, always fraction */
EXP: OP_OP OP_PLUS EXP EXP OP_CP        { $$ = $3 + $4; /* printf("%f = %f + %f\n", $$, $3, $4); */ }
   | OP_OP OP_MINUS EXP EXP OP_CP       { $$ = $3 - $4; /* printf("%f = %f - %f\n", $$, $3, $4); */ }
   | OP_OP OP_MULT EXP EXP OP_CP        { $$ = $3 * $4; /* printf("%f = %f * %f\n", $$, $3, $4); */ }
   | OP_OP OP_DIV EXP EXP OP_CP         { $$ = $3 / $4; /* printf("%f = %f / %f\n", $$, $3, $4); */ }
   | IDENTIFIER                         { $$ = get_id_value($1); /* printf("%s : %f\n", $1, $$); */ }
   | VALUEF                             { $$ = $1; /* printf("%f\n", $$); */ }
   /* | FCALL                              { printf("EXP7\n"); } */
   /* | ASG                                { printf("EXP8\n"); } */
//   | OP_OP KW_IF EXPB EXPLIST EXPLIST OP_CP     { printf("EXP9\n"); }
//   | OP_OP KW_WHILE EXPB EXPLIST OP_CP          { printf("EXP10\n"); }
//   | OP_OP KW_DEFV IDENTIFIER EXP OP_CP         { printf("EXP11\n"); /* declare variable */ }
//   | OP_OP KW_SET IDENTIFIER EXP OP_CP          { printf("EXP12\n"); /* set variable */ }

/* FIX: grammar */
// EXPLIST: OP_OP EXP OP_CP        { printf("EXPLIST1\n"); }
//        | OP_OP EXPLIST OP_CP    { printf("EXPLIST2\n"); }
       /* | OP_OP EXP EXPLIST OP_CP    { printf("EXPLIST3\n"); } */

/* Assignment: EXP evaulated first */
// ASG: OP_OP KW_SET IDENTIFIER EXP OP_CP  { printf("ASG\n"); }

// FUNCTION: OP_OP KW_DEFF IDENTIFIER OP_OP ( | IDENTIFIER | IDENTIFIER IDENTIFIER | IDENTIFIER IDENTIFIER IDENTIFIER ) OP_CP OP_OP EXPLIST OP_CP { printf("FUNCTION\n"); }

/* function definition is an expression, always returns 0f1 */
// FCALL: OP_OP IDENTIFIER ( | EXP| EXP EXP | EXP EXP EXP ) OP_CP { printf("FCALL\n"); }

// EXPB: OP_OP KW_EQ EXP EXP OP_CP     { printf("EXPB1\n"); /* returns true if equal */ } 
//     | OP_OP KW_GT EXP EXP OP_CP     { printf("EXPB2\n"); /* returns true if greater */ }
//     | KW_TRUE | KW_FALSE            { printf("EXPB3\n");}
//     | OP_OP KW_AND EXPB EXPB OP_CP  { printf("EXPB4\n"); }
//     | OP_OP KW_OR EXPB EXPB OP_CP   { printf("EXPB5\n"); }
//     | OP_OP KW_NOT EXPB OP_CP       { printf("EXPB6\n"); }

%%

/*************** FUNCTIONS ***************/
int yyerror(char *msg)
{
    printf("Syntax Error: '%s'.\n", msg);
    /* exit(1); */
}

int main(int argc, char **argv)
{
    while(1){
        yyparse();
    }
    return 0;
}

// Parse fraction from string "nfd" as double
double parse_fractd(char const *str) {
    int num, den;
    num = atoi(str);
    den = atoi(strchr(str, 'f') + 1);
    // printf("> Fraction: %d/%d\n", num, den);
    // printf("> Fraction as double: %f\n", (double) num / den);
    return (double) num / den;
}


// Get identifier value by name from symbol table
double get_id_value(char const *name) {
    return 0.0;
}
