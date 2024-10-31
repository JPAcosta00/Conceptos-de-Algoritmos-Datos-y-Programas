program Fortacos;
type
   subRango=1..4;
   vector=array[1..4]of integer;
   cliente=record 
     nombre:string;
     dni:integer;
     edad:integer;
     sub:subRango;
   end;
   lista=^nodo;
   nodo=record
     dato:cliente;
     sig:lista;
   end;
procedure Inicializa (var vec:vector);
var 
 i:integer;
begin
  for i:=1 to 4 do begin
    vec[i]:=0;
  end;
end; 
procedure cargaPrecios(var ta:vector);                      //se dispone
procedure carga (var li:lista;var vec:vector);
var 
 cli:cliente;
begin
  LeeCliente(cli);
  while(cli.dni<>0)do begin
    AgregarAdelante(li,cli);
    LeeCliente(cli);
    vec[li^.dato.sub]:=vec[li^.dato.sub]+1;
  end;
end;
procedure LeeCliente(var cl:cliente);
begin
  readln(cl.dni);
  if(cl.dni<>0)then begin
    readln(cl.nombre);
    readln(cl.edad);
    readln(cl.sub);
  end;
end;
procedure AgregarAdelante (var lis:lista;clien:cliente);
var 
 nue:lista;
begin
 new(nue);
 nue^.dato:=clien;
 nue^.sig:=lis;
 lis:=nue;
end;
procedure RecorreCalcula (list:lista;var nu:lista;t:vector;var tot:integer);
begin
  while(list<>nil)do begin
    tot:=tot+t[list^.dato.sub];
    if(list^.dato.edad>40)and(list^.dato.sub=3)or(list^.dato.sub=4)then
       insertarOrdenado(nu,list^.dato);
    list:=list^.sig;
  end;
end;
procedure masSubs(var ma1,ma2:integer;vet:vector);
var 
  max1,max2,i:integer;
begin
  max1:=-1;
  max2:=-1;
  for i:=1 to 4 do begin
    if(vet[i]>=max1)then begin
      ma2:=ma1;
      ma1:=i;
      max2:=max1;
      max1:=vet[i];
    else 
      if(vet[i]>=max2)then begin
         ma1:=ma2;
         ma2:=i;
         max1:=max2;
         max2:=vet[i];
      end;
    end;
  end;
end;
procedure InsetarOrdenado(var w:lista;clien:cliente);
var
  ant,act,nue:integer;
begin
  new(nue);
  ant:=w;
  act:=w;
  while(act<>nil)and(act^.dato.dni<clien.dni)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then
    w:=nue;
  else 
    ant^.sig:=nue;
  nue^.sig:=act;
end;
var
  l,n:lista;
  v,tabla:vector;
  mas1,mas2,total:integer;
begin
  l:=nil;
  n:=nil;
  mas1:=0;
  mas2:=0;
  total:=0;
  Inicializa(v);
  cargarPrecios(tabla);                                     //se dispone
  carga(l,v);
  RecorreCalcula(l,n,tabla,total);
  masSubs(mas1,mas2,v);
  writeln(total);
  writeln(mas1,mas2);
end;