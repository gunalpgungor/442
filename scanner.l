%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

void yyerror(const char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(1);
}
union {
    char *sval;
    int ival;
    char cval;
}
%}


%%

[ \t\r\n]+                ;

"/*"([^*]|(\*+([^*/])))*"*"+"/" ;
"//".*                    ;

"array"                   { return ARRAY; }
"auto"                    { return AUTO; }
"boolean"                 { return BOOLEAN; }
"char"                    { return CHAR; }
"else"                    { return ELSE; }
"false"                   { return FALSE; }
"for"                     { return FOR; }
"function"                { return FUNCTION; }
"if"                      { return IF; }
"integer"                 { return INTEGER; }
"print"                   { return PRINT; }
"return"                  { return RETURN; }
"string"                  { return STRING; }
"true"                    { return TRUE; }
"void"                    { return VOID; }
"while"                   { return WHILE; }

[a-zA-Z_][a-zA-Z0-9_]{0,255} { yylval.sval = strdup(yytext); return IDENTIFIER; }

[-+]?[0-9]+               { yylval.ival = atoi(yytext); return INTEGER_LITERAL; }

\'(\\.|[^\\\'])\'         { yylval.cval = yytext[1]; return CHARACTER_LITERAL; }

\"([^\"\\]|\\.){0,255}\"  { 
                            char *str = strdup(yytext + 1);
                            str[strlen(str) - 1] = '\0';
                            yylval.sval = str;
                            return STRING_LITERAL;
                          }

"=="                     { return EQ; }
"!="                     { return NEQ; }
"<="                     { return LE; }
">="                     { return GE; }
"<"                      { return LT; }
">"                      { return GT; }
"&&"                     { return AND; }
"||"                     { return OR; }
"="                      { return ASSIGN; }
"!"                      { return NOT; }
"^"                      { return EXP; }
"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return MULTIPLY; }
"/"                      { return DIVIDE; }
"%"                      { return MODULUS; }
"++"                     { return INCREMENT; }
"--"                     { return DECREMENT; }

"("                      { return LPAREN; }
")"                      { return RPAREN; }
"["                      { return LBRACKET; }
"]"                      { return RBRACKET; }
"{"                      { return LBRACE; }
"}"                      { return RBRACE; }
";"                      { return SEMICOLON; }
","                      { return COMMA; }
":"                      { return COLON; }

.                        { fprintf(stderr, "scan error: %s is not a valid character\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}
