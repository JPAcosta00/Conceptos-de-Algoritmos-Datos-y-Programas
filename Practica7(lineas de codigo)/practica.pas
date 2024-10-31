procedure cargarLista (var lis:lista);
var
  j:jugador;
begin
  leerJugador(j)
  while(j.dni<>0)do begin
    insertarOrdenado(lis,j);
    leerJugador(j);
  end;
end;

procedure insertarOrdenado(var list:lista;ju:jugador);
var 
 nue,act,ant:lista;
begin
  new(nue);
  nue^.dato:=ju;
  nue^.sig:=list;
  act:=list;
  act:=list;
  while(act<>nil)and(j.altura<nue^.dato.altura)do begin
  ant:=act;
  act:=act^.sig;
  end;
  if(ant=act)then begin
    list:=nue;
  end
  else 
    ant^.sig:=nue;
  nue^.sig:=act;
end;



//////////////////////////////////////////////
procedure cargarLista(var lis:lista);
var 
  cli:cliente;
begin
  leerClient(cli);
  while(cli.dni<>0)do begin
    insertarOrdenado(cli,lis);
    leerClient(cli);
  end;
end;
procedure insertarOrdenado(clien:cliente;var nu:lista);
var 
  act,ant,nue:lista;
begin
  new(nue);
  nue^.dato:=clien;
  nue^.sig:=nu;
  act:=nue;
  ant:=nue;
  while(act<>nil)and(clien.dni<act^.dato.dni)do begin
     ant:=act;
     act:=act^.sig;
  end;
  if(ant=act)then
   nu:=nue;
  else
    ant^.sig:=nue;
  nue^.sig:act
end,
////////////////////////////////////////////////////////
var 
  l:lista;
  lu:lugar;
begin 
  leerLugar(lu);
  while(lu.coordenadas<>0)do begin
    agregarAdelante(l,lu);
    imprimirLista(l);
  end;
end;

procedure agregarAdelante(var lis:lista;lug:lugar);
var 
 nue:lista;
begin
  new(nue);
  nue^.dato:=lug;
  nue^.sig:=lis;
  lis:=nue;
end;
procedure imprimirLista(liste:lista);
begin
  while(liste<>nil)do begin
    writeln(liste^.dato);
    liste:=liste^.sig;
  end;
end;
/////////////////////////////////////////////////
var 
 n:lista;
 g:grupo;
begin
 n:=nil;
 leerGrupo(g);
 while(g.num<>22)do begin
   agregarAtras(n,g)
   imprimir(n);
 end;
end;
procedure agregarAtras (var nu:lista;gru:grupo);
var 
 nueva,ult:lista;
begin
 new(nueva);
 nueva^.dato:=gru;
 nueva^.sig:=nil;
 if(nu=nil)then
   nu:=nueva;
 else
   ult^.sig:=nueva;
 ult:=nueva;
end;

procedure agregarAtras(var l,ULT:lista;jugador:player);
var 
  nue:lista;
begin
  new(nue);
  nue^.dato:=jugador;
  nue^.sig:=nil;
  if(l=nil)then
    l:=nue;
  else
    ULT^.sig:=nue;
  ULT:=nue;
end;

procedure InsertarOrdenado(var l:lista;mago:juego);
var
  nue,act,ant:lista;
begin
  new(nue);
  nue^.dato:=mago;
  nue^.sig:=l;
  act:=l;
  ant:=l;
  while(l<>nil)and(mago.edad<l^.dato.edad)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then
    l:=nue;
  else
    ant^.sig:=nue;
  nue^.sig:=act;
end;
 
procedure AgregarAdelante(var liste:lista;p:pistolas);
var
  nueva:lista;
begin
  new(nueva);
  nueva^.dato:=p;
  nueva^.sig:=liste;
  liste:=nueva;
end;

procedure AgregarAtras(var lis,ULT:lista;p:pistolas);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=p;
  nue^.sig:=nil;
  if(lis=nil)then
    lis:=nue;
  else
    ULT^.sig:=nue;
  ULT:=nueva;
end;

procedure insertaOrdenado(dni:integer;nue:lista);
var 
  nueva,act,ant:lista;
begin
  new(nueva);
  nueva^.dato:=dni;
  nueva^.sig:=nue;
  act:=nue;
  ant:=nue;
  while(act<>nil)and(dni<act^.dato.dni)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act=ant)then
    nue:=nueva;
  else 
    ant^sig:=nueva;
  nueva^.sig:=act;
end

procedure Atras (var n,ULT:lista;num:integer);
var 
 nue:lista;
begin
 new(nue);
 nue^dato:=num;
 nue^.sig:=nil;
 if(n=nil)then
   n:=nue;
 else
   ULT^.sig:=nue;
 ULT:=nue;
end;

 
 
 

  
  

