
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
%start programa

%%

programa: #comenzar INICIO sentencias FIN
;

sentencias: sentencia
          | sentencia sentencias
;

sentencia: IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA #asignar
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