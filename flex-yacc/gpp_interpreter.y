/*************** DECLARATIONS ***************/

%{
    /* C Declarations*/
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include "gpp_lexer.c"

    void yyerror(const char *s);
    int yylex();
    int yywrap();

%}

/* Lex Declarations */
%token DIGIT
%token COMMENT KW_AND KW_OR KW_NOT KW_EQ KW_GT KW_SET KW_DEFV KW_DEFF KW_WHILE KW_IF KW_EXIT KW_TRUE KW_FALSE  
%token OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_COMMA
%token IDENTIFIER VALUEF

/* YACC Declarations  */
%start INPUT

%%

/*************** RULES ***************/
INPUT:
%%

/*************** FUNCTIONS ***************/
yyerror(char const *msg)
{
    printf("Error. %s: '%s'.\n", msg, yytext);
}

yylex(){
    char c;
    c = getchar();
    if(isdigit(c)){
        pos++;
        return DIGIT;
    }
    else if(c == ' '){
        yylex();         /*This is to ignore whitespaces in the input*/
    }
    else {
        return c;
    }
}

main()
{
	yyparse();
	return 1;
}
