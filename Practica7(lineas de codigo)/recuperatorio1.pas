program nuevepr7;
type
  vector=array[1..8]of integer;
  pelicula=record
    codP:integer;
    titulo:string;
    codG:vector;
    puntaje:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:pelicula;
    sig:lista;
  end;
  critica=record
    dni:integer;
    apellido:string;
    nombre:string;
    cod:integer;
    puntaje:integer;
  end;
  lista2=^nodo2;
  nodo2=record
   dato:critica;
   sig:lista2;
  end;
procedure leerCritica(cri:critica);
begin
 readln(c.cod);
 if(c.cod<>-1)then
   readln(c.dni);
   readln(c.apellido);
   readln(c.nombre);
   readln(c.puntaje);
   readln(c.cod);
end;
procedure agregarAdelante (var lis:lista;crit:critica);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=crit;
  nue^.sig:=lis;
  lis:=nue;
end;
procedure cargarCritica(var li:lista);
var
 c:critica;
begin
  leerCritica(c);
  while(c.cod<>-1)do begin
    agregarAdelante(l,c);
    leerCritica(c);
  end;
end;
procedure MasPuntajeObtuvo(codigo:vector;var mas:integer);
var
  i,max:integer;
begin
  max:=-1;
  for i:=1 to 8 do begin
    if(codigo[i]>max)then begin
      max:=codigo[i];
      mas:=codigo;
    end;
  end;
end;
function descomponer(var dni:integer):boolean;
var
  cumple:boolean;
  pares,impares:integer;
begin 
  pares:=0;
  impares:=0;
  while(dni<>0)do begin
    if(dni mod 2=0)then 
      pares:=pares+1;
    else 
      impares:=impares+1;
  end;
  if(pares=impares)then
    cumple:=true;
  descomponer:=cumple;
end;
procedure actualizaryCalcular(var v:lista;list:lista2;var masPuntaje:integer);
var
  aux:lista;
begin
  masPuntaje:=0;
  aux:=v;
  while(aux<>nil)do begin
    while(aux^.dato.codP=listP.dato.cod)do begin
       aux^.dato.puntaje:=list^.dato.puntaje;
       MasPuntajeObtuvo(aux^.dato.codG,masPuntaje);
       if(descomponer(list^.dato.dni)=true)then begin
          writeln(list^.dato.apellido);
          writeln(list^.dato.nombres);
        end;
    end;
  end;
end;
procedure eliminarPelicula(var vieja:lista;pelicula:integer);
var 
  act,ant:lista;
begin
  ant:=vieja;
  act:=vieja;
  while(act<>nil)do begin
    if(act^.dato.codP<>pelicula)then begin
      ant:=act;
      act:=act^.sig;
    end;
    else 
      if(act<>nil)then begin
        if(act=vieja)then
          vieja:=vieja^.sig;
        else
          ant^.sig:=act^.sig
       dispose(act);
       act:=ant;
      end;
  end;
end;
var
 l:lista2;
 v:lista;
 MPCriticas:integer;
 peli:integer;
begin
  l:=nil;
  cargarCritica(l);
  while(l^.dato.cod<>-1)do begin
    actualizaryCalcular(v,l,MPCriticas);
  end;
  writeln('ingrese el codigo de una pelicula para eliminar');
  readln(peli);
  eliminarPelicula(v,peli);
  writeln('codigo de genero de la pelicula que mas puntaje obtuvo en las criticas:',MPCriticas);
end.
    
