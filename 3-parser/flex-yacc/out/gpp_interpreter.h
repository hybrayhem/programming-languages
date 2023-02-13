/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_OUT_GPP_INTERPRETER_H_INCLUDED
# define YY_YY_OUT_GPP_INTERPRETER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    COMMENT = 258,
    KW_AND = 259,
    KW_OR = 260,
    KW_NOT = 261,
    KW_EQ = 262,
    KW_GT = 263,
    KW_SET = 264,
    KW_DEFV = 265,
    KW_DEFF = 266,
    KW_WHILE = 267,
    KW_IF = 268,
    KW_EXIT = 269,
    KW_TRUE = 270,
    KW_FALSE = 271,
    OP_PLUS = 272,
    OP_MINUS = 273,
    OP_DIV = 274,
    OP_MULT = 275,
    OP_OP = 276,
    OP_CP = 277,
    OP_COMMA = 278,
    IDENTIFIER = 279,
    VALUEF = 280
  };
#endif
/* Tokens.  */
#define COMMENT 258
#define KW_AND 259
#define KW_OR 260
#define KW_NOT 261
#define KW_EQ 262
#define KW_GT 263
#define KW_SET 264
#define KW_DEFV 265
#define KW_DEFF 266
#define KW_WHILE 267
#define KW_IF 268
#define KW_EXIT 269
#define KW_TRUE 270
#define KW_FALSE 271
#define OP_PLUS 272
#define OP_MINUS 273
#define OP_DIV 274
#define OP_MULT 275
#define OP_OP 276
#define OP_CP 277
#define OP_COMMA 278
#define IDENTIFIER 279
#define VALUEF 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 22 "gpp_interpreter.y"


    int num;
    int *nums;
    double fnum; // fraction number
    double *fnums; // fraction number array
    char str[247];
    

#line 117 "out/gpp_interpreter.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_OUT_GPP_INTERPRETER_H_INCLUDED  */
