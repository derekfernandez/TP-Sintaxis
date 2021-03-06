/*Parser*/

%{
	#include <stdio.h>
%}

%token INICIO       
%token FIN
%token LEER
%token ESCRIBIR
%token ASIGNACION
%token IDENTIFICADOR
%token OPERADOR
%token CONSTANTE
%token PUNTOYCOMA
%token PARENABIERTO
%token PARENCERRADO
%token CARACTERLISTA
%token ERRORLEXICO
%start programa

%%

programa: INICIO sentencias FIN
	| ERRORLEXICO {yyerror("Error Lexico");YYABORT;}
;

sentencias: /* vacio */
          | sentencia sentencias
;

sentencia: IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA 
         | LEER PARENABIERTO identificadores PARENCERRADO PUNTOYCOMA
         | ESCRIBIR PARENABIERTO expresiones PARENCERRADO PUNTOYCOMA
 	 | ERRORLEXICO {yyerror("Error Lexico");YYABORT;}
;

expresion: expresionPrimaria
	| expresionPrimaria OPERADOR expresionPrimaria
;

expresiones: expresion CARACTERLISTA expresion
;

expresionPrimaria: IDENTIFICADOR
	| CONSTANTE
	| PARENABIERTO expresion PARENCERRADO
	| ERRORLEXICO {yyerror("Error Lexico");YYABORT;}
;

identificadores: IDENTIFICADOR CARACTERLISTA IDENTIFICADOR
	| IDENTIFICADOR CARACTERLISTA ERRORLEXICO {yyerror("Error Lexico");YYABORT;}
	| ERRORLEXICO {yyerror("Error Lexico");YYABORT;}
;

%%

extern int yylineno;

yyerror(char* mensaje) {
	printf("\nAnalisis erroneo\n");
	printf("\nError Encontrado: %s en linea: %d\n",mensaje,yylineno);
	}

main() {
	if (yyparse() ==0)
	printf ("\nAnalisis concluido sin errores\n");
	}

