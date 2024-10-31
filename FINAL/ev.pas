Program pregunta;
function suma(x : integer) : integer;
var
   i, aux : integer;
begin
   aux := 0;
   for i:= 1 to x do
       aux := aux + i;
   suma := aux;
end;
begin
 writeln(suma(3));
end.
