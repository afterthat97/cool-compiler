 /*
  *  The scanner definition for COOL.
  */

 /*
  *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
  *  output, so headers and global definitions are placed here to be visible
  * to the code in the file.  Don't remove anything that was here initially
  */
%{

#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>
#include <stdint.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

char string_const[MAX_STR_CONST];
int string_const_len;
bool str_contain_null_char;

%}

 /*
  * Define names for regular expressions here.
  */

%option noyywrap
%x LINE_COMMENT BLOCK_COMMENT STRING

DARROW			=>
ASSIGN			<-
LE				<=

%%

\n				{ curr_lineno++; }
[ \t\r\v\f]+	{}
 
 /*
  *  Nested comments
  */

"--"			{ BEGIN LINE_COMMENT; }
"(\*"			{ BEGIN BLOCK_COMMENT; }
"\*)"			{
	strcpy(cool_yylval.error_msg, "Unmatched *)");
	return (ERROR);
}

<LINE_COMMENT>\n		{ BEGIN 0; curr_lineno++; }
<BLOCK_COMMENT>\n		{ curr_lineno++; }
<BLOCK_COMMENT>"\*)"	{ BEGIN 0; }
<BLOCK_COMMENT><<EOF>>	{ 
	strcpy(cool_yylval.error_msg, "EOF in comment");
	BEGIN 0; return (ERROR);
}

<LINE_COMMENT>.			{}
<BLOCK_COMMENT>.		{}

 /*
  *  The multiple-character operators.
  */

{DARROW}		{ return (DARROW); }
{ASSIGN}		{ return (ASSIGN); }
{LE}			{ return (LE); }

 /*
  *  The single-character operators.
  */

"{"			{ return '{'; }
"}"			{ return '}'; }
"("			{ return '('; }
")"			{ return ')'; }
"~"			{ return '~'; }
","			{ return ','; }
";"			{ return ';'; }
":"			{ return ':'; }
"+"			{ return '+'; }
"-"			{ return '-'; }
"*"			{ return '*'; }
"/"			{ return '/'; }
"%"			{ return '%'; }
"."			{ return '.'; }
"<"			{ return '<'; }
"="			{ return '='; }
"@"			{ return '@'; }

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */

(?i:CLASS)		{ return (CLASS); }
(?i:ELSE)		{ return (ELSE); }
(?i:FI)			{ return (FI); }
(?i:IF)			{ return (IF); }
(?i:IN)			{ return (IN); }
(?i:INHERITS)	{ return (INHERITS); }
(?i:LET)		{ return (LET); }
(?i:LOOP)		{ return (LOOP); }
(?i:POOL)		{ return (POOL); }
(?i:THEN)		{ return (THEN); }
(?i:WHILE)		{ return (WHILE); }
(?i:CASE)		{ return (CASE); }
(?i:ESAC)		{ return (ESAC); }
(?i:OF)			{ return (OF); }
(?i:NEW)		{ return (NEW); }
(?i:LE)			{ return (LE); }
(?i:NOT)		{ return (NOT); }
(?i:ISVOID)		{ return (ISVOID); }

t[rR][uU][eE]		{ 
	cool_yylval.boolean = 1;
	return (BOOL_CONST);
}

f[aA][lL][sS][eE]	{ 
	cool_yylval.boolean = 0;
	return (BOOL_CONST);
}

 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */

\"	{
	memset(string_const, 0, sizeof string_const);
	string_const_len = 0; str_contain_null_char = false;
	BEGIN STRING;
}

<STRING><<EOF>>	{
	strcpy(cool_yylval.error_msg, "EOF in string constant");
	BEGIN 0; return (ERROR);
}

<STRING>\\.		{
	if (string_const_len >= MAX_STR_CONST) {
		strcpy(cool_yylval.error_msg, "String constant too long");
		BEGIN 0; return (ERROR);
	} 
	switch(yytext[1]) {
		case '\"': string_const[string_const_len++] = '\"'; break;
		case '\\': string_const[string_const_len++] = '\\'; break;
		case 'b' : string_const[string_const_len++] = '\b'; break;
		case 'f' : string_const[string_const_len++] = '\f'; break;
		case 'n' : string_const[string_const_len++] = '\n'; break;
		case 't' : string_const[string_const_len++] = '\t'; break;
		case '0' : string_const[string_const_len++] = 0; 
			   str_contain_null_char = true; break;
		default  : string_const[string_const_len++] = yytext[1];
	}
}

<STRING>\\\n	{ curr_lineno++; }
<STRING>\n		{
	curr_lineno++;
	strcpy(cool_yylval.error_msg, "Unterminated string constant");
	BEGIN 0; return (ERROR);
}

<STRING>\"		{ 
	if (string_const_len > 1 && str_contain_null_char) {
		strcpy(cool_yylval.error_msg, "String contains null character");
		BEGIN 0; return (ERROR);
	}
	cool_yylval.symbol = stringtable.add_string(string_const);
	BEGIN 0; return (STR_CONST);
}

<STRING>.		{ 
	if (string_const_len >= MAX_STR_CONST) {
		strcpy(cool_yylval.error_msg, "String constant too long");
		BEGIN 0; return (ERROR);
	} 
	string_const[string_const_len++] = yytext[0]; 
}

 /*
  *  Integers and identifiers.
  */

[0-9]+				{ 
	cool_yylval.symbol = inttable.add_string(yytext); 
	return (INT_CONST);
}

[A-Z][A-Za-z0-9_]*	{
	cool_yylval.symbol = idtable.add_string(yytext);
	return (TYPEID);
}

[a-z][A-Za-z0-9_]*	{
	cool_yylval.symbol = idtable.add_string(yytext);
	return (OBJECTID);
}

 /*
  *  Other errors.
  */

.	{
	strcpy(cool_yylval.error_msg, yytext); 
	return (ERROR); 
}

%%
