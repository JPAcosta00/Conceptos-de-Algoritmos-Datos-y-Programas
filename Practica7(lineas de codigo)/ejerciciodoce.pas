program doce;
type
 subRango=1..4;
 lista=^nodo;
 vector=array[subRango]of real;                //se dispone
 cliente=record
   nombre:string;
   DNI:integer;
   edad:integer;
   tipoSuscripcion:vector;
 end;
 nueva=record
   dni:integer;
   nombre:string;
 end;
 lista2=^nodo2;
 nodo2=record
   dato:nueva;
   sig:lista2;
 end;
 nodo=record
   dato:cliente;
   sig:lista;
 end;
procedure leerTipo(var sup:subRango);
var
  i:integer;
  v:vector;
begin
  for i:=1 to 4 do begin
    readln(v[i]);
    sup:=i;
    
  end;
end;
procedure leerCliente(var cli:cliente);
begin
  readln(cli.DNI);
  while(cli.DNI<>0)do begin
    readln(cli.nombre);
    readln(cli.edad);
    leerTipo(cli.suscripcion);
  end;
end;
procedure crearNodo(var list:lista;var cli:cliente);
var 
  nueva:lista;
begin
  new(nueva);
  nueva^.dato:=cli;
  nueva^.sig:=list;
end;
procedure LeeAlmacena(var lis:lista);
var
  aux:lista;
  c:cliente;
begin
  leerCliente(c);
  crearNodo(lis,c);
end;
procedure gananciaFortaco(sub:subRango;vecto:vector;var total:real);
var
  i:subRango;
begin
  for i:=1 to 4 do begin
    if(sub=i)then
      total:=total+vecto[i];
  end;
end;
procedure masClientes (vek:vector;var maximaS1,maximaS2:integer);
var
  i:subRango;
  max1,max2:real;
begin
  max1:=-1;
  max2:=-1;
  maximaS1:=0;
  maximaS2:=0;
  for i:=1 to 4 do begin
    if(vek[i]>max1)then begin
      maximaS2:=maximaS1;
      maximaS1:=i;
      max2:=max1;
      max1:=vek[i];
    end
    else 
      if(vek[i]>max2)then begin
        maximaS1:=maximaS2;
        maximaS2:=i;
        max1:=max2;
        max2:=vek[i];
      end;
  end;
end;
procedure crearNodo(var nuevita:lista2 );
var
  nu:lista2;
begin
  new(nu);
  nu^.dato:=nil;
  nu^.sig:=nuevita;
end;
procedure cargarNuevaOrdenada(var nuev:lista2;var lis:lista);
var
  act,ant:lista;
begin
  crearNodo(nuev);
  act:=nuev;
  ant:=nuev;
  while(act<>nil)and(act^.dato.dni<nuev^.dato.dni)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then
    nuev:lis;
  else
    ant^sig:=nuev;
  nue^.sig:=act;
end;
function sub(subs:integer):boolean;
var
  cumple:boolean;
begin
  cumple:=false;
  if((subs=1)and(subs=2)and(subs=3)and(subs=4))then
     cumple:=true;
  sub:=cumple;
end;
procedure procesarInfo(liste:lista,var nueva:lista2);
var
 gananciaTotal:real;
 vec:vector;
 maxSub1,maxSub2:integer;
 cli:cliente;
begin
 gananciaTotal:=0;
 while(liste<>nil)do begin
  gananciaFortaco(liste^.dato.tipoSuscripcion,vec,gananciaTotal);
  masClientesDos(vec,maxSub1,maxSub2);
  if((liste^.dato.edad>40)and(liste^.dato.tipoSuscripcion=3)or(sub(liste^.dato.tipoSuscripcion)=true))then
    cargarNuevaOrdenada(nue,liste);
  liste:=liste^.sig;
 end;
 writeln('La ganancia total de furtaco`s es:',gananciaTotal);  //inciso A
 writeln('Estas son las dos suscripciones con mas clientes:',maxSub1,maxSub2);  //inciso B
end;
var
  l,nu:lista;
begin
  nu:nil
  l:nil;
  LeeAlmacena(l);
  procesarInfo(l,nu);
end.
