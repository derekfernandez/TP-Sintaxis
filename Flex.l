%{
    
    #include <stdio.h>
    #include "y.tab.h"
%}

%option noyywrap

palabrasReservadas               [inicio-fin-leer-escribir]
digito                           [0-9]
operador                         [+-]
caracter                         [a-zA-Z]
asignacion                       :=

%%

"inicio"								return INICIO;
"fin"									return FIN;
"leer"									return LEER;
"escribir"								return ESCRIBIR;
{caracter}({caracter}|{digito})*					return IDENTIFICADOR;
{digito}+								return CONSTANTE;
{operador}							        return OPERADOR;
":="					                                return ASIGNACION;
"("									return PARENABIERTO;
")"					                                return PARENCERRADO;
";"									return PUNTOYCOMA;
","									return CARACTERLISTA;
[ /t/n]									;
.									printf("ERROR\t");

%%
