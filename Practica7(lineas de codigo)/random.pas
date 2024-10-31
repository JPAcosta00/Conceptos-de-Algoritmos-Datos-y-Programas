program random1;
type
  subRango=1..26;
  categoria=record
    nombre:string;
    codigo:subRango;
    precio:real;
  end;
  vector=array[subRango]of categoria;
  compras:record
    dni:integer;
    cat:vector;
    cant:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:compra;
    sig:lista;
  end;
procedure leeInfo(var info:categoria);
begin
  writeln('ingrese un nombre');
  readln(info.nombre);
  writeln('ingrese un codigo');
  readln(info.codigo);
  writeln('ingrese el precio');
  readln(info.precio);
end;
procedure cargaCat(var vecto:vector;infor:categoria);
var
  i:integer;
begin
  for i:=1 to 26 do begin
   if(i=infor.codigo)then
      vecto[i]:=infor;
  end;
end;
procedure cargarEstructura(var lis:lista;var vec:vector);
var
  aux:lista;
  inf:categoria;
begin
  aux:=lis;
  while(aux<>nil)do begin
    leeInfo(inf);
    cargaCat(vec,inf);
    aux:=aux^.sig;
  end;
end;
procedure procesarCyC(li:lista;ve:vector,var montoT:real);
var
  precio:real;
begin
  montoT:=0;
  while(li<>nil)do begin
    montoT:=li^.dato.cant * precio;
    
  
  end;
end;
var
 l:lista;
 v:vector;
 mTotal:real;
begin
 l:=nil; //se dispone
 cargarEstructura(l,v);
 procesarCyC(l,v,mTotal);
 
  
