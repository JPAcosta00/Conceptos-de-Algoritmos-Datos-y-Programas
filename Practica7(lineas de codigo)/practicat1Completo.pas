program tema1Completo;
type
  subRango=1..26;
  categoria=record
    nombre:string;
    codigo:subRango;
    precioxKg:integer;
  end;
  vector=array[1..26]of categoria;
  compras=record
    dniCliente:integer;
    cat:vector;
    cantCompra:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:compras;
    sig:lista;
  end;
procedure leerCategoria(var cat:categoria);
begin
  writeln('ingrese un nombre');
  readln(cat.nombre);
  writeln('ingrese un codigo');
  readln(cat.codigo);
  writeln('ingrese el precio por kilo');
  readln(cat.precioxKg);
end;
procedure DniMasComprador(cantCompradas:integer;dniC:integer;var DNI:integer);
var
 max:integer;
begin
  max:=-1;
  if(cantCompradas>max)then begin
    max:=cantCompradas;
    DNI:=dniC;
  end;
end;
procedure montoTotal(cate:vector;var monto:integer);
var 
  i:integer;
begin
  monto:=0;
  for i:=1 to 26 do begin
    monto:=monto+cate[i];
  end; 
end;
function descomponeDni(var dni:integer):boolean;
var 
  cumple:boolean;
  pares:integer;
begin
  pares:=0;
  cumple:=false;
  while(dni<>0)do begin
    if(dni mod 2=0)then
      pares:=pares+1;
    dni:=dni div 10;
  end 
  if(pares>=3)then
    cumple:=true;
  descomponeDni:=cumple;
end;
procedure procesar (lis:lista;cat:vector;var dni,mTotal,cant:integer);
begin
  mTotal:=0;
  dni:=0;
  cant:=0;
  while(lis<>nil)do begin
    DniMasComprador(lis^.dato.cantCompra,lis^.dato.dniCliente,dni);
    montoTotal(cat,mTotal);
    if(descomponeDni(lis^.dato.dniCliente)=true)then
       cant:=cant+1;
    lis:=lis^.sig
  end;
end;
procedure leerCategorias(var vec:vector);
var 
  i:integer;
  c:categoria;
begin
  for i:=1 to 26 do begin
     leerCategoria(c);
     vec[i]:=c;
  end;
end;
var
  l:lista;
  v:vector;
  dniCompra,MONTOtotal,cantidadDni:integer;
begin
  leerCategorias(v);
  procesar(l,v,dniCompra,MONTOtotal,cantidadDni);
end.
