/* DECLARATIONS */

%{
    /* C Declarations*/
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    // #include "gpp_lexer.c"

    /* Custom function to print an operator*/
    void print_operator(char op);

    /* Variable to keep track of the position of the number in the input */
    int pos=0;

%}

/* YACC Declarations  */
%token DIGIT
%left '+' /* left associative, to remove shift reduce conflicts */
%left '*' /* '*' is left associative and has higher precedence over '+' */

%%

/* RULES */
start : expr '\n'		{exit(1);}
      ;

expr: expr '+' expr     {print_operator('+');}
    | expr '*' expr     {print_operator('*');}
    | '(' expr ')'
    | DIGIT             {printf("NUM%d ",pos);}
    ;

%%

/* AUXILIARY FUNCTIONS */

void print_operator(char c){
    switch(c){
        case '+'  : printf("PLUS ");
                    break;
        case '*'  : printf("MUL ");
                    break;
    }
    return;
}

yyerror(char const *s)
{
    printf("yyerror %s",s);
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
