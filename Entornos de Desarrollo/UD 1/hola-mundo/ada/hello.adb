-- Programa: Hola mundo en Ada
-- Compilar: gnatmake hello.adb  Ejecutar: ./hello


with Ada.Text_IO; use Ada.Text_IO;
procedure Hello is
begin
  Put_Line("Hola mundo"); -- Escribe en stdout
end Hello;
