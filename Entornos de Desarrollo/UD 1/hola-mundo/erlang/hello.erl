%% Programa: Hola mundo en Erlang
%% Compilar: erlc hello.erl  Ejecutar: erl -noshell -s hello start -s init stop
-module(hello).
-export([start/0]).

start() ->
    io:format("Hola mundo~n"). % ~n = newline
