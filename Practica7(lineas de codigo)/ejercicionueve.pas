program ocho;
type 
  subRango=1..8;
  lista=^nodo;
  cod=array[subRango]of integer;
  pelicula=record
    codigo:integer;
    titulo:string;
    codigoGenero:cod;
    pPromedio:real;
  end;
  critica=record;
    dni:integer;
    apellido:string;
    nombre:string;
    codPelicula:integer;
    puntaje:real;
  end;
  nodo=record
    dato:pelicula;
    sig:lista;
  end;
procedure leerPelicula(var lis:lista);      //se dispone
procedure leer(var cri:critica):
begin
  writeln('ingrese un codigo de pelicula');
  readln(cri.codPelicula);
  if(codPelicula<>-1)then begin
    writeln('igrese un dni');
    readln(cri.dni);
    writeln('ingrese un apellido');
    readln(cri.apellido);
    writeln('ingrese un nombre');
    readln(cri.nombre);
    writeln('ingrese un puntaje');
    readln(cri.puntaje);
  end;
end;
procedure leerCritica(var ls:lista);
var
  cri:critica;
  nueva:lista;
begin
  leer(cri);
  new(nueva);
  nueva^.dato:=cri;
  nueva^.sig:=ls;
end;
procedure inicializar(var vector:cod);
var
  i:subRango;
begin
  for i:=1 to 8 do begin
     vector[i]:=0;
  end;
end;
procedure calcularMaximo(pun:real;codigoM:integer;cr:critica);
var
  max:real;
begin
  max:=0;
  if(pun>max)then begin
    max:=pun;
    codigoM:=cr.codPelicula;
  end;
end;
procedure actualizar(var list:lista);
var
  c:critica;
  aux,nue:lista;
  puntaje:real;
  maxCod:integer;
  co:cod;
begin
  maxCod:=0;
  puntaje:=0;
  incializar(co);              
  leerPelicula(list);
  aux:=list;
  while(aux<>nil)do begin
    while(aux<>nil)and(c.codPelicula=aux^.dato.codigo)do begin
      aux^.dato.pPromedio:=c.puntaje;
      puntaje:=puntaje+aux^.dato.pPromedio;
      aux:=aux^.sig;
    end;
    calcularMaximo(puntaje,maxCod,c.codPelicula); 
  end;
  Writeln('Codigo de genero que mas puntaje obtuvo entre todas las criticas:',maxCod);
end;
function descomponer(var com:critica):boolean;
var
  pares,impares:integer;
  cumple:boolean;
begin
  cumple:=false;
  pares:=0;
  impares:=0;
  while(com.dni<>0)do begin
    if(com.dni mod 10=0)then begin
       pares:=pares+1;
    else
       impares:=impares+1;
    end;
  end;
  if(pares=impares)then
    cumple:=true;
  descomponer:=cumple;
end;
procedure criticos(listaNueva:lista);
var
  nombrePar,apellidoPar:string;
  c:critica;
begin
  while(listaNueva<>nil)do begin
   if(descomponer(c)=true)then 
   begin
     nombrePar:=listaNueva^.dato.nombre;
     apellidoPar:=listaNueva^.dato.apellido;
   end;
   writeln(nombrePar);
   writeln(apellidoPar);
  end;
end;
procedure eliminarPelicula(var listaP:lista);
var
  act,ant:lista;
  codigo:integer;
begin
  act:listaP;
  ant:listaP;
  writeln('ingrese el codigo de la pelicula a eliminar');
  readln(codigo);
  while(act<>nil)and(act^.dato.codigo<>codigo)do 
  begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act<>nil)then 
  begin
    if(act=ant)then
      listaP:=act^.sig;
    else
      ant^.sig:=act^.sig;
    dispose(act);
  end;
end;
var
  l,n:lista;
begin
  n:=nil;
  leerCritica(l); //se dispone 
  actualizar(l);
  criticos(n);
  eliminarPelicula(l);
end;
