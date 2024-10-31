program practica;
type
  lista:^nodo;
  info=record
    codigo:integer;
    cantidad:integer;
  end;
  nodo=record
    dato:info;
    sig:lista;
  end;
  venta=record
    numero:integer;
    monto:real;
    productos:lista;
  end;
  vector=array[1..500] of venta;
  
procedure cargaVentas(var vec:vector;var diml:integer);   //se dispone

function analiza(li:lista):boolean;
var
  cant:integer;
  cumple:boolean;
begin
  cumple:=false;
  cant:=0;
  while(li <> nil)do 
    cant:= cant + li^.dato.cantidad;
  if(cant = 5)
    cumple:=true;
  analiza:=cumple;
end;
procedure elimina(var v:vector;var dimel:integer;lugar:integer;);
var
  i:integer;
begin
  for i:= lugar to (dimel-1) do
     v[i]:= v[i+1];
  dimel:= dimel-1;
end;
procedure eliminaVentas(var ve:vector; var dim:integer);
var
  i:integer;
begin
  for i:=1 to dim do begin
    si(analiza(ve[i].productos))
      elimina(ve,dim,i);
  end;
end;
var                                              //programa principal
  vecto:vector;
  dimen:integer;
begin
  dimen:=0;
  cargaVentas(vecto,dimen);
  eliminaVentas(vecto,dimen);
end.


2) Estructuras de Control:
   - While
   - repeat-until
   - if - else
   - case
  
   *Repeat-until: Es una estructura de control que evalua cada iteracion incluyendo
       la ultima opcion(el caso limite), en comparacion a el "While".
      -Sintaxis:
          repeat
            //codigo
            //codigo 
            //codigo
          until(condicion)
        //(hasta que no se cumple esa condicion y pase por el codigo dentro del repeat
        // no sale de la estructura).
    
   * ENUNCIADO: Escribir un modulo que lea todas las ventas de un supermercado.De cada venta
        se lee el codigo, tipo, monto total de la venta y la cantidad de productos. Se lee hasta
        que se ingresa el codigo de venta numero 100 (El cual debe leerse la venta entera).
    
   * MODULO:
     procedure leeVentas(var ven:venta);
     begin
       repeat
         readln(ven.codigo);
         readln(ven.tipo);
         readln(ven.monto);
         readln(ven.cantidad);
       until(ven.codigo = 100);                     //lee hasta que el codigo es igual a 100(inclusive).
     end;


3)
  Memoria Estatica = 160 bytes
  Memoria Dinamica = 54 bytes

4)
  Tiempo de Ejecucion = 2 + (3(N+1) + 3N)
