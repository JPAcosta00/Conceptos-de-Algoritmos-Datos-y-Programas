program L14;
type
  subRango=1..1300;
  transporte=array[1..5]of integer;
  viaje=record
    codigo:subRango;
    dia:integer;
    facultad:string;
    medio:transporte;
    precio:integer;         //se dispone
  end;
  lista=^nodo;
  nodo=record
    dato:viaje;
    sig:lista;
  end;
procedure inicializar(var tr:transporte);
var
  i:integer;
begin
  for i:=1 to 5 do begin
    tr[i]:=0;
  end;
end;
procedure leerMedio(v:viaje);
var
  i:integer;
  t:transporte;
begin
  readln(v.medio);
  for i:=1 to 5 do begin
    t[i]:=v.medio;
    readln(v.medio);
  end;
end;
procedure crearNodo (via:viaje;var list:lista);
var 
 nue:lista;
begin
 new(nue);
 nue^.dato:=via;
 nue^.sig:=list;
end;
procedure LeerViaje(var lis:lista);
var 
  v:viajes;
  t:transporte;
begin
  inicializar(t);
  read(v.codigo);
  while(v.codigo<>-1)do begin
    readln(v.dia);
    readln(v.facultad);
    leerMedio(v.medio);
    readln(v.precio);
    readln(v.codigo);
  end;
  crearNodo(v,lis);
end;
function masdeSeis(medio:transporte):boolean;
var
 i:integer;
 cumple:boolean;
begin
 cumple:=false;
 for i:=1 to 5 do begin
   if(medio[i]>6)then
     cumple:=true;
 end;
 masdeSeis:=cumple;
end;
procedure dosMasUsados(med:transporte;max1,max2:integer);
var
  i:integer;
begin
  max1:=-1;
  max2:=-1;
  for i:=1 to 5 do begin
    if(med[i]>max1)then begin
      max2:=max1;
      max1:=med[i];
    end;
    else
      if(med[i]>max2)then begin
        max1:=max2;
        max2:=med[i];
      end;
  end;
end;
function combinan(med:transporte):boolean;
var
  cumple:boolean;
  i:integer;
begin
  cumple:=false;
  for i:=1 to 5 do begin
    if(med[i]='bicicleta')then
      cumple:=true;
  end;
  combinan:=cumple;
end;
procedure procesarViajes(l:lista);
var
  CantC,cantGastos,cantMas6,mUsados1,mUsados2:integer;
begin
  CantC:=0;
  mUsados1:=0;
  mUsados2:=0;
  cantMas6:=0;
  cantGastos:=0;
  while(l<>nil)do begin
   if(l^.dato.precio>80)then
     cantGastos:=cantGastos+1;
   if(masdeSeis(l^.dato.medio)=true)then
     cantMas6:=cantMas6+1;
   dosMasUsados(l^.dato.medio,mUsados1,mUsados2);
   if(combinan(l^.dato.medio)=true)and(l^.dato.medio='x')then
     CantC:=CantC+1;
   l:=l^.sig;
  end;
  writeln(CantC);                    //inciso D
  writeln(cantMas6);                 //inciso A
  writeln(mUsados1,mUsados2);        //inciso C
  writeln(cantGastos);               //inciso B
end;
var
 l:lista;
begin
 l:=nil;
 LeerViaje(l);
 while(l^.dato.codigo<>-1)do begin
   procesarViajes(l);
 end;
end.
