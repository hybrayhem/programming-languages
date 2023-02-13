/*************** DECLARATIONS ***************/

%{
    /* C Declarations*/
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    #define TABLE_SIZE 256

    int pos = 0;

    int yylex();
    int yyerror(char*);

    double parse_fractd(char const *);
    double get_symbol_value(char const *);

    double *list_create(double);
    double *list_append(double *, double);
    void list_print(double *);

    typedef struct {
        char *name;
        double value;
    } symbol_t;

    symbol_t symbol_table[TABLE_SIZE];

    void insert_symbol(char const *, double);
%}

%union{

    int num;
    int *nums;
    double fnum; // fraction number
    double *fnums; // fraction number array
    char str[247];
    
};

/* YACC Declarations  */
%start START

%token COMMENT KW_AND KW_OR KW_NOT KW_EQ KW_GT KW_SET KW_DEFV KW_DEFF KW_WHILE KW_IF KW_EXIT KW_TRUE KW_FALSE  
%token OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_COMMA
%token <str> IDENTIFIER 
%token <fnum> VALUEF

%type <fnum> INPUT
%type <fnum> EXP
%type <num> EXPB
%type <fnums> EXPLIST
/* %type <fnums> FUNCTION */

%%

/*************** RULES ***************/
START: INPUT
     | INPUT START

INPUT: EXP          { printf("> %f\n", $1); }
     /* | FUNCTION {} */
     | EXPLIST  { printf("> "); list_print($1); }
     | COMMENT  {}
     /* | EXPB | INPUT EXPB        { printf("EXPB = %d \n", $1); } // remove after test */


/* Expression: returns the value of last expression, always fraction */
EXP: OP_OP OP_PLUS EXP EXP OP_CP        { $$ = $3 + $4; /* printf("%f = %f + %f\n", $$, $3, $4); */ }
   | OP_OP OP_MINUS EXP EXP OP_CP       { $$ = $3 - $4; /* printf("%f = %f - %f\n", $$, $3, $4); */ }
   | OP_OP OP_MULT EXP EXP OP_CP        { $$ = $3 * $4; /* printf("%f = %f * %f\n", $$, $3, $4); */ }
   | OP_OP OP_DIV EXP EXP OP_CP         { $$ = $3 / $4; /* printf("%f = %f / %f\n", $$, $3, $4); */ }
   | IDENTIFIER                         { $$ = get_symbol_value($1); /* printf("%s : %f\n", $1, $$); */ }
   | VALUEF                             { $$ = $1; /* printf("%f\n", $$); */ }
   /* | FCALL                              { printf("EXP7\n"); } */
   /* | ASG                                { printf("EXP8\n"); } */
//   | OP_OP KW_IF EXPB EXPLIST EXPLIST OP_CP     { printf("EXP9\n"); }
//   | OP_OP KW_WHILE EXPB EXPLIST OP_CP          { printf("EXP10\n"); }
//   | OP_OP KW_DEFV IDENTIFIER EXP OP_CP         { printf("EXP11\n"); /* declare variable */ }
   | OP_OP KW_SET IDENTIFIER EXP OP_CP          { $$ = $4; insert_symbol($3, $4); /* set variable */ }

EXPLIST: OP_OP EXP OP_CP            { $$ = list_create($2); }
       | OP_OP EXPLIST EXP OP_CP    { $$ = list_append($2, $3); }

/* Assignment: EXP evaulated first */
// ASG: OP_OP KW_SET IDENTIFIER EXP OP_CP  { printf("ASG\n"); }
// FUNCTION: OP_OP KW_DEFF IDENTIFIER OP_OP ( | IDENTIFIER | IDENTIFIER IDENTIFIER | IDENTIFIER IDENTIFIER IDENTIFIER ) OP_CP OP_OP EXPLIST OP_CP { printf("FUNCTION\n"); }
/* function definition is an expression, always returns 0f1 */
// FCALL: OP_OP IDENTIFIER ( | EXP| EXP EXP | EXP EXP EXP ) OP_CP { printf("FCALL\n"); }

EXPB: OP_OP KW_EQ EXP EXP OP_CP     { $$ = ($3 == $4); /* returns true if equal */ } 
    | OP_OP KW_GT EXP EXP OP_CP     { $$ = ($3 > $4); /* returns true if greater */ }
    | KW_TRUE                       { $$ = 1; }
    | KW_FALSE                      { $$ = 0; }
    | OP_OP KW_AND EXPB EXPB OP_CP  { $$ = ($3 == 1 && $4 == 1); }
    | OP_OP KW_OR EXPB EXPB OP_CP   { $$ = ($3 == 1 || $4 == 1); }
    | OP_OP KW_NOT EXPB OP_CP       { $$ = ($3 == 0); }

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
    // printf("Fraction: %d/%d\n", num, den);
    // printf("Fraction as double: %f\n", (double) num / den);
    return (double) num / den;
}

// Create list of doubles
double *list_create(double val) {
    double *list = malloc(sizeof(double) * 2);
    list[0] = val;
    list[1] = 0.0;
    return list;
}

// Append value to list of doubles
double *list_append(double *list, double val) {
    int size = sizeof(list) / sizeof(list[0]);
    list = realloc(list, sizeof(double) * (size + 1));
    list[size] = val;
    return list;
}

// Print list of doubles
void list_print(double *list) {
    int size = sizeof(list) / sizeof(list[0]);
    int i;
    for (i = 0; i < size; i++) {
        printf("%f ", list[i]);
    }
    printf("\n");
}

void insert_symbol(char *name, double value) {
  // Check if the symbol already exists in the table
  for (int i = 0; i < TABLE_SIZE; i++) {
    if (symbol_table[i].name != NULL && strcmp(symbol_table[i].name, name) == 0) {
      // If it does, update its value
      symbol_table[i].value = value;
      return;
    }
  }

  // If the symbol does not exist in the table, find the first empty slot and insert it there
  for (int i = 0; i < TABLE_SIZE; i++) {
    if (symbol_table[i].name == NULL) {
      symbol_table[i].name = strdup(name); // Make a copy of the name string
      symbol_table[i].value = value;
      return;
    }
  }

  // If the symbol table is full, we cannot insert any more symbols
  fprintf(stderr, "Error: symbol table is full\n");
  exit(1);
}

// Get identifier value by name from symbol table
int get_symbol_value(char *name) {
  for (int i = 0; i < TABLE_SIZE; i++) {
    if (symbol_table[i].name != NULL && strcmp(symbol_table[i].name, name) == 0) {
      return symbol_table[i].value;
    }
  }

  // If the symbol was not found in the table, return 0
  return 0;
}
