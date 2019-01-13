%{

#include "y.tab.h"
#include<stdio.h>
#include<stdlib.h>

	extern int coloana;
	extern int linie;

%}

%option noyywrap

%%
"PROGRAM"		{coloana+=strlen(yytext); return TOK_PROGRAM;}
"BEGIN"			{coloana+=strlen(yytext); return TOK_BEGIN;}
"VAR"			{coloana+=strlen(yytext); return TOK_VAR;}
"END"			{coloana+=strlen(yytext); return TOK_END;}
"id"			{coloana+=strlen(yytext); return TOK_id;}
";"			{coloana++; return TOK_pv;}
":"			{coloana++; return TOK_dp;}
"INTEGER"		{coloana+=strlen(yytext); return TOK_INTEGER;}
","			{coloana++; return TOK_v;}
":="			{coloana+=strlen(yytext); return TOK_dpeq;}
"+"			{coloana++; return TOK_add;}
"-"			{coloana++; return TOK_min;}
"*"			{coloana++; return TOK_mul;}
"DIV"			{coloana+=strlen(yytext); return TOK_DIV;}
"int"			{coloana+=strlen(yytext); return TOK_int;}
"("			{coloana++; return TOK_ps;}
")"			{coloana++; return TOK_pd;}
"READ"			{coloana+=strlen(yytext); return TOK_READ;}
"WRITE"			{coloana+=strlen(yytext); return TOK_WRITE;}
"FOR"			{coloana+=strlen(yytext); return TOK_FOR;}
"DO"			{coloana+=strlen(yytext); return TOK_DO;}
"TO"			{coloana+=strlen(yytext); return TOK_TO;}
0|([1-9][0-9]*) 	{return TOK_int;}
([a-zA-Z][a-zA-Z0-9_]*)	{return TOK_id;}
"\n"			{coloana=0; linie++; }
[ \t\v]                 { ; }
[$%.#@!]		{ /*yyerror("caractere invalide")*/;}
%%
