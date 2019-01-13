%{
#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include<string.h>

int linie=1;
int coloana=1;
int yyerror(const char *msg);
extern int yylex();

class TVAR
	{
	     char* nume;
	     int valoare;
	     TVAR* next;
	  
	  public:
	     static TVAR* head;
	     static TVAR* tail;

	     TVAR(char* n, int v = -1);
	     TVAR();
	     int exists(char* n);
             void add(char* n, int v = -1);
             int getValue(char* n);
	     void setValue(char* n, int v);
	};

	TVAR* TVAR::head;
	TVAR* TVAR::tail;

	TVAR::TVAR(char* n, int v)
	{
	 this->nume = new char[strlen(n)+1];
	 strcpy(this->nume,n);
	 this->valoare = v;
	 this->next = NULL;
	}

	TVAR::TVAR()
	{
	  TVAR::head = NULL;
	  TVAR::tail = NULL;
	}

	int TVAR::exists(char* n)
	{
	  TVAR* tmp = TVAR::head;
	  while(tmp != NULL)
	  {
	    if(strcmp(tmp->nume,n) == 0)
	      return 1;
            tmp = tmp->next;
	  }
	  return 0;
	 }

         void TVAR::add(char* n, int v)
	 {
	   TVAR* elem = new TVAR(n, v);
	   if(head == NULL)
	   {
	     TVAR::head = TVAR::tail = elem;
	   }
	   else
	   {
	     TVAR::tail->next = elem;
	     TVAR::tail = elem;
	   }
	 }

         int TVAR::getValue(char* n)
	 {
	   TVAR* tmp = TVAR::head;
	   while(tmp != NULL)
	   {
	     if(strcmp(tmp->nume,n) == 0)
	      return tmp->valoare;
	     tmp = tmp->next;
	   }
	   return -1;
	  }

	  void TVAR::setValue(char* n, int v)
	  {
	    TVAR* tmp = TVAR::head;
	    while(tmp != NULL)
	    {
	      if(strcmp(tmp->nume,n) == 0)
	      {
		tmp->valoare = v;
	      }
	      tmp = tmp->next;
	    }
	  }

	TVAR* ts = NULL;

%}

%union {int nr; char* sir;}

%token TOK_PROGRAM TOK_BEGIN TOK_VAR TOK_END TOK_pv TOK_dp TOK_INTEGER TOK_v
%token TOK_dpeq TOK_add TOK_min TOK_mul TOK_DIV TOK_int TOK_ps TOK_pd TOK_READ 
%token TOK_WRITE TOK_FOR TOK_DO TOK_TO TOK_id

%type<nr> val
%type<sir> nume

%%

%start prog;
 
 prog: TOK_PROGRAM prog_name TOK_VAR dec_list TOK_BEGIN stmt_list TOK_END
	;
   prog_name: TOK_id
	    ;
   dec_list: dec 
	   | dec_list TOK_pv dec
	   ;
   dec:id_list TOK_dp type
      ;
   type: TOK_INTEGER
       ;
   id_list: TOK_id
	  | id_list TOK_v TOK_id
	  ;
   stmt_list: stmt
	    | stmt_list TOK_pv stmt
	    ;
   stmt: assign
       | read
       | write
       | for
       ;
   assign: TOK_id TOK_dpeq exp
	 ;
   exp: term
      | exp TOK_add term
      | exp TOK_min term
      ;
   term: factor
       | term TOK_mul factor
       | term TOK_DIV factor
       ;
   factor: TOK_id
	 | TOK_int
	 | TOK_ps exp TOK_pd
	 ;
   read: TOK_READ TOK_ps id_list TOK_pd
       ;
   write: TOK_WRITE TOK_ps TOK_id TOK_pd
	;
   for: TOK_FOR index_exp TOK_DO body
      ;
   index_exp: TOK_id TOK_dpeq exp TOK_TO exp
	    ;
   body: stmt
       | TOK_BEGIN stmt_list TOK_END
       ;
%%



int yyerror(const char *msg)
{
	fprintf(stderr,"%s la linia %d, coloana %d:\n",msg,linie,coloana);
	 exit(1);
}


int main()
{
	yyparse();
	printf("CORECTA!");
	return 1;
}
