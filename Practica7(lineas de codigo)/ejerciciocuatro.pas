program cuatro;
type 
  lista=^nodo;
  semanas=array[1..42]of real;
  embarazada=record
    nombre:string;
    apellido:string;
    peso:semanas;
    cantSemanas:integer;
  end;
  nodo=record
    dato:embarazada;
    sig:lista;
  end;
procedure MayorAumento(var vec:semanas;aumento:real;diml:integer);
var
 i:integer;
 aux,max:real;
begin
  max:=-1;
  for i:=1 to diml do begin
     aux:=vec[i]-vec[i-1];
     if(aux>max)then begin
        max:=aux;
        aumento:=vec[i];
     end;
  end;
end;
procedure aumentoTotal (vecto:semanas;totalAumento:real;dl:integer);
var
 i:integer;
begin
  for i:=1 to dl do begin 
    totalAumento:=Vecto[dl]-vecto[1];
  end;
end;
procedure procesarEmbarazada(lis:lista;aumentoMayor,totalAumento:real);
var
 v:semanas;
 cantS:integer;
begin
   cantS:=0;
   while(lis<>nil)do begin
     mayorAumento(v,aumentoMayor,cantS);
     aumentoTotal(v,totalAumento,cantS);
     writeln('La semana con mayor aumento de la embarazada fue:', aumentoMayor);
     writeln('El aumento de peso total durante el embarazo es:',totalAumento);
   end;
end;
var
  l:lista;
  mayorAumento,totalAumento:real;
begin
   l:=nil;
   leerInformacion(l);             //se dispone
   procesarEmbarazada(l,mayorAumento,totalAumento);
end.
 
