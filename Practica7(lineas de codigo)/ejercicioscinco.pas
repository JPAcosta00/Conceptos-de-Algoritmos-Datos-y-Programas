program cinco;
type
 camion=record
   patente:integer;
   a:integer;
   capacidad:real;
 end;
 empresa=array[1..100] of camion;
 lista=^nodo;
 viaje=record
   codigoViaje:integer;
   codigoCamion:empresa;
   distancia:real;
   destino:string;
   anio:integer;
   dniChofer:integer;
 end;
 nodo=record
   dato:viaje;
   sig:lista;
 end;
procedure crearLista(via:viaje;li:lista);
var
  nuevo:lista;
begin
  new(nuevo);
  nuevo^.dato:=via;
  nuevo^.sig:=li;
end;
procedure leeCodigoCamion(vi:viaje;ca:camion);
begin
  readln(ca.patente);
  readln(ca.a);
  readln(ca.capacidad);
end;
procedure leerViajes (var lis:lista);
var
 v:viaje;
 c:empresa;
begin
 readln(v.codigoViaje);
 if(v.codigoViaje<>-1)then begin
   leeCodigoCamion(v,c);
   readln(v.distancia);
   readln(v.destino);
   readln(v.anio);
   readln(v.dniChofer);
 end;
 crearLista(v,lis);
end;
procedure MasyMenosKM(li:lista;maxPatente,minPatente:integer);
var
 max,min:real;
 c:empresa;
begin
  max:=-1;
  min:=9999;
  if(li^.dato.distancia>max)then begin
    max:=li^.dato.distancia;
    maxPatente:=c.camion.patente;
  end;
  if(li^.dato.distancia>min)then begin
    min:=li^.dato.distancia;
    minPatente:=c.patente;
  end;
end;
procedure cantidadViajes (em:empresa;lis:lista;cant:integer);
var
  i,antiguedad,y,x:integer;
begin
  cant:=0;
  y:=lis^.dato.anio;
  x:=em.camion.a;
  for i:=1 to 100 do begin
    antiguedad:=x-y;
    if((em.camion.capacidad>30,5)and(antiguedad > 5))then
       cant:cant+1;
  end;
end;
function descomponer(var le:lista):boolean;
var
  cumple:boolean;
  cant:integer;
begin
  cumple:=false;
  while(le^.dato.dniChofer<>0)do begin
    if(le^.dato.dniChofer:=le^.dato.dniChofer mod 10<>0)then
       cant:=cant+1;
    le^.dato.dniChofer:=le^.dato.dniChofer div 10;
  end;
  if(cant=9)then
    cumple:=true;
  descomponer:=cumple;
end;
procedure Codigos(liste:lista);
var
  codigo:integer
begin
  codigo:=liste^.dato.codigoViajes;
  if(descomponer=true)and(liste^.dato.codigoViajes<>codigo)then
     writeln('Codigos de viajes realizados por choferes con dni de numeros impares:',codigo);    
end;
procedure procesarViajes(var list:lista;camionMax,camionMin,cantViajes:integer);
var
  aux:=lista
  e:empresa
begin
  aux:=list;
  while(aux<>nil)do begin
    MasyMenosKM(list,m,camionMax,camionMin);   //inciso uno
    cantidadViajes(e,list,cantViajes);         //inciso dos
    Codigos(list);                             //inciso tres
    aux:=aux^.sig;
  end;
end;
var
 l:lista;
 minimaPatente,maximaPatente,cantidadViajesDos:integer;
begin
 l:nil
 leerViaje(l);
 while(l^dato.codigoViaje<>-1)do begin
   procesarViajes(l,maximaPatente,minimaPatente,cantidadViajesDos);
   writeln('Patente del camion con mas kilometros recorridos:',maximaPatente);
   writeln('Patente del camion con menos kilometros recorridos:',minimaPatente);
   writeln('Viajes con mayor capacidad y antiguedad:',cantidadViajesDos);
 end;
end;
