
%{
	#include <stdio.h>
%}

%union rutinas {
	int intval;
	char *id;
}

%token INICIO       
%token FIN
%token LEER
%token ESCRIBIR
%token ASIGNACION
%token <id> IDENTIFICADOR
%token OPERADOR
%token <intval> CONSTANTE
%token PUNTOYCOMA
%token PARENABIERTO
%token PARENCERRADO
%token CARACTERLISTA
%start programa

%%

programa: INICIO sentencias FIN
;

sentencias: /* vacio */
          | sentencia sentencias
;

sentencia: IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA 
         | LEER PARENABIERTO identificadores PARENCERRADO PUNTOYCOMA
         | ESCRIBIR PARENABIERTO expresiones PARENCERRADO PUNTOYCOMA
;

expresion: expresionPrimaria
	| expresionPrimaria OPERADOR expresionPrimaria
;

expresiones: expresion CARACTERLISTA expresion
;

expresionPrimaria: IDENTIFICADOR
	| CONSTANTE
	| PARENABIERTO expresion PARENCERRADO
;

identificadores: IDENTIFICADOR CARACTERLISTA IDENTIFICADOR

%%

main() {
	if (yyparse() ==0)
	printf ("\nAnalisis concluido sin errores\n");
	}

yyerror(char* mensaje) {
	printf("\nAnalisis suspendido\n");
	printf("\nMensaje: %s",mensaje);
	}
