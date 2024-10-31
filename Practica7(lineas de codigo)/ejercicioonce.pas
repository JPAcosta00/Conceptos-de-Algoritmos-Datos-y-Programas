program once;
type 
  subRango=1..5;
  rango=1..100;
  lista=^nodo;
  lista2=^nodo2;
  evento=record
    nombre:string;
    tipo:subRango;
    lugar:string;
    cantMax:integer;
    costo:real;
  end;
  nodo=record
    dato:evento;
    sig:lista;
  end;
  venta=record;
    codigoVenta:integer;
    numeroEvento:rango;
    dni:integer;
    cantAdd:integer;
  end;
  nodo2=record;
    dato:venta;
    sig:lista2;
  end;
procedure leerVenta(var ven:venta);
var
begin
 readln(ven.codigoVenta);
 while(ven.codigoVenta<>-1)do begin
  readln(ven.numeroEvento);
  readln(ven,dni);
  readln(ven.cantAdd);
  readln(ven.codigoVenta);
 end;
end;
procedure cargarLista(var li:lista2);
var
  v:venta;
  nueva:lista2;
begin
  leerVenta(v);
  new(nueva);
  nueva^.dato:=v;
  nueva^.sig:=li;
end;
procedure menosRecaudacion(list:lista2;primera:lista;nombreMin1,nombreMin2,lugarMin1,lugarMin2);
var 
  min1,min2:integer;
begin
  min1;=9999;
  min2:=9999;
  if(list^.dato.cantAdd<min1)then begin
    nombreMin2:=nombreMin1;
    nombreMin1:=primera^.dato.nombre;
    lugarMin2:=lugarMin1;
    lugarMin1:=primera^.dato.lugar;
    min2:=min1;
    min1:=list^.dato.cantAdd;
  end
  else
    if(list^.dato.cantAdd<min2)then begin
      nombreMin1:=nombreMin2;
      nombreMin2:=primera^.dato.nombre;
      lugarMin1:=lugarMin2;
      lugarMin2:=primera^.dato.lugar;
      min1:=min2;
      min2:=list^.dato.cantAdd;
    end;
end;
function DNIcomprador (var dni:integer):boolean;
var
  cumple:boolean;
  pares,impares:integer;
begin
  pares:=0;
  impares:=0;
  cumple:=false;
  while(dni<>0)do begin
    if(dni mod 10=0)then 
      pares:=pares+1;
    else 
      impares:=impares+1;
    dni:=dni div 10:
  end;
  if(pares>impares)then
    cumple:=true;
  DNIcomprador:=cumple;
end; 
procedure recorrerLista (lis:lista2;pri:lista);
var
  cant:integer;
  AlcanzoMaxima:boolean;
begin
  AlcanzoMaxima:=false;
  cant:=0;
  while(lis<>nil)do begin
    menosRecaudacion(lis,pri,nomin1,nomin2,lugar1,lugar2);
    if(DNIcomprador(lis^.dato.dni)=true)and(pri^.dato.tipo=3)then
      cant:cant+1;
    if((lis^.dato.numeroEvento=50)and(pri^.dato.cantMax=lis^.dato.cantAdd))then
      AlcanzoMaxima:=true;
    lis:=lis^.sig;
  end;
  writeln('cantidad de entradas del inciso 2B:',cant);
  writeln('respuesta inciso 2C:',AlcanzoMaxima);
  writeln('respuesta inciso 2A:',nomin1,nomin2,lugar1,lugar2);
end;
var
  l:lista2;
  pri:lista;
begin
  l:=nil;
  cargarLista(l);                   //inciso 1
  recorrerLista(l,pri);             //inciso 2
end.








