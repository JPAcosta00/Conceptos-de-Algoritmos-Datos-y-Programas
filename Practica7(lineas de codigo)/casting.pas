program casting;
type
  cadena=string[20];
  vector=array[1..5]of integer;
  int:1..5;
  persona=record
    dni:integer;
    ape:cadena;
    nom:cadena;
    edad:integer;
    cod:int;
    end;
  lista=^nodo;
  nodo=record
    dato:persona;
    sig:lista;
    end;
procedure Inicializa (var ve:vector);
var 
  i:integer;
begin
  for i:1..5 da
    ve[i]:=0;
end;
procedure LeePersona (var pe:persona);
begin
  readln(pe.dni);
  readln(pe.ape);
  readln(pe.nom);
  readln(pe.edad);
  readln(pe.cod);
end;
procedure AgregarAdelante (var li:lista; per:persona);
var 
  nue:lista;
begin 
  new(nue);
  nue^.dato:=per;
  nue^.sig:=li;
  li:=nue;
end;
function DescomponeDni(dni:integer)of boolean;
var
  par,impar:integer;
  cumple:boolean;
begin
 par:=0;
 impar:=0;
 cumple:=false;
 while(dni<>0)do begin
  dni:=dni mod 10;
  if(dni mod 2=0)then
    par:=par+1;
    else 
      impar:=impar+1;
  dni:=dni div 10;
 end;
 if(par>impar)then
   cumple:=true;
 DescomponeDni:=cumple;
end;
procedure RecorreL(list:lista;var c:integer;var vec:vector);
begin
  while(list<>nil)do begin
    vec[list^.dato.cod]:=vec[list^.dato.cod]+1;
    if(DescomponeDni(list^.dato.dni)=true)then
      c:=c+1;
    list:=list^.sig;
    end;
end;
procedure MasElegidos(vecto:vector;var co1,co2:integer);
var 
  max1,max2,i:integer;
begin 
  max1:=-1;
  max2:=-1;
  for i:=1 to 5 do begin
    if(vecto[i]>=max1)then begin
      co2:=co1;
      co1:=i;
      max2:=max1;
      max1:=vecto[i];
    else 
      if(vecto[i]>=max2)then begin
         co1:=co2;
         co2:=i;
         max1:=max2;
         max2:=vecto[i];
       end;
    end;s
  end;
end;
procedure EliminaDni (var l:lista;docu:intger);
var
  ant,act:lista;
begin
  ant:l;
  act:l;
  while(act<>nil)and(act^.dato.dni<>docu)do begin
    ant:=act;
    act:=act^.sig;
    end;
  if(act<>nil)then begin
    if(ant=act)then
      l:=act^.sig;
    else 
      ant^.sig:=act^.sig;
    dispose(act);
  end;
end;
var
 v:vector;
 lis:lista;
 p:persona;
 cant,cod1,cod2,Dni:integer;
begin                                           
 cant:=0;
 cod1:=0;
 cod2:=0;
 Inicializa(v);
 repeat
   LeePersona(p);
   AgregarAdelante(lis,p);
 until(p.dni=33555444);
 RecorreL(lis,cant,v);
 MasElegidos(v,cod1,cod2);
 writeln('ingrese un dni');
 readln(dni);
 EliminaDni(lis,dni)
 writeln(cant);
 writeln(cod1,cod2);
end. 


