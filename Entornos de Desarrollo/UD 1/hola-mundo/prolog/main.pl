% Programa: Hola mundo en Prolog
% Ejecutar: swipl -q -f main.pl
:- initialization(main).

main :- 
    writeln('Hola mundo'), % Imprime con salto de linea
    halt.
