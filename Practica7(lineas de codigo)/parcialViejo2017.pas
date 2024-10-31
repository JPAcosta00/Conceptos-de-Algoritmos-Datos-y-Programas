program parcialViejo2017;
type
  subRango=1..100;
  vector=array[1..5]of integer;
  evento=record
    nombre:string;
    tipo:vector;
    lugar:string;
    CantMax:integer;
    costo:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:evento;
    sig:lista;
  end;
  venta=record
    codigo:integer;
    numero:subRango;
    dniCompra:integer;
    cantAdd:integer;
  end;
  lista2=^nodo2;
  nodo2=record
    dato:venta;
    sig:lista2;
  end;
procedure leerVenta(ven:venta);
begin
  readln(ven.codigo);
  if(ven.codigo<>-1)then begin  
    readln(ven.numero);
    readln(ven.dniCompra);
    readln(ven.canAdd);
    readln(ven.codigo);
  end;   
end;
procedure agregarAdelante(var nuev:lista2;vent:ventas);
var
  nue:lista2;
begin
  new(nue);
  nue^.dato:=vent;
  nue^.sig:=nuev;
  nuev:=nue;
end;
procedure cargarVenta(var nueva:lista2);
var 
  v:ventas;
begin 
  leerVenta(v);
  if(v.codigo<>-1)then  begin
    agregarAdelante(nueva,v);
    leerVenta;
  end;
end;
procedure menosRecaudacion(compra:integer;nombre,lugar:string;var nm1,nm2,lm1,lm2:string);
var
  min1,min2:integer;
begin
  min1:=9999;
  min2:=9999;
  if(compra<min1)then begin
    min2:=min1;
    min1:=compra;
    nm2:=nm1;
    nm1:=nombre;
    lm2:=lm1;
    lm1:=lugar;
  end;
  else
    if(compra<min2)then begin
      min1:=min2;
      min2:=compra;
      nm1:=nm2;
      nm2:=nombre;
      lm1:=lm2;
      lm2:=lugar;
    end; 
end;
function descomponerDni(dniComprador:integer):boolean;
var
 cumple:boolean;
 pares,impares:integer;
begin
  cumple:=false;
  pares:=0;
  impares:=0;
  while(dniComprador<>0)do begin
     if(dniComprador mod 2=0)then
       pares:=pares+1;
     else 
       impares:=impares+1;
     dniComprador:=dniComprador div 10; 
  end;
  if(pares>impares)then
     cumple:=true;
  descomponerDni:=cumple;
end;
function tipoEvento(tipoE:vector):boolean;
var
  cumple:boolean;
  i:integer;
begin
  cumple:=false;
  for i:=1 to 5 do begin
     if(tipoE[i]=3)then 
       cumple:=true;
  end;
  tipoEvento:=cumple;
end;
procedure cantidadDigPares(var dni:integer;tipo:vector;cantidad:integer);
var
begin
  cantidad:=0;
  if(descomponerDni(dni)=true)and(tipoEvento(tipo)=true)then
    cantidad:=cantidad+1;
end;
procedure procesar (nueva:lista2;lis:lista;var nomin1,nomin2,lugar1,lugar2:string;var cant:integer,var alcanzo:boolean);
begin
  alcanzo:=false;
  cant:=0;
  while(nueva<>nil)and(lis<>nil)do begin
    menosRecaudacion(nueva^.dato.cantAdd,lis^.dato.nombre,lis^.dato.lugar,nomin1,nomin2,lugar1,lugar2);
    cantidadDigPares(nueva^.dato.dniCompra,lis^.dato.tipo,cant);
    if((nueva^.dato.numero=50)and(nueva^.dato.cantAdd=lis^.dato.CantMax))then
       alcanzo:=true;
    nueva:=nueva^.sig;
    lis:=lis^.sig;
  end;
end;
var
  l:lista;                //se dispone
  n:lista2;
  nombreM1,nombreM2,lugarM1,lugarM2:string;
  cantidadComprador:integer;
  alcanzoMax:boolean;
begin
  l:=nil;
  n:=nil;
  alcanzoMax:=false;
  cantidadComprador:=0;
  cargarVenta(n);
  while(n^.dato.codigo<>-1)do begin
     procesar(n,l,nombreM1,nombreM2,lugarM1,lugarM2,cantidadComprador,alcanzoMax);
  end;
  writeln('nombre y lugar de los eventos que han tenido menos recaudacion:',nombreM1,nombreM2,lugarM1,lugarM2);
  writeln('cantidad de entradas venidas con comprador con dni mas digitos pares que impares y el tipo es de obra de teatro:',cantidadComprador);
  writeln(alcanzoMax);
end.
  
