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

// Definitions
int count = 0;
%}


%%
[pattern]  { /* code */ }

[A-Z] {printf("%s capital letter\n", yytext);
       count++;}
.     {printf("%s not a capital letter\n", yytext);}
EOF   {return 0;}
%%


// Runs after lex initialization
int yywrap(){}
int main(int argc, char *argv[]) {
    int i;
    for(i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }
    
    yylex();
    printf("\ncapital letter number = %d\n", count);

    return 0;
}
