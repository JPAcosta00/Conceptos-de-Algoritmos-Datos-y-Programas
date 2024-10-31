program ejFInal;
type
  cadena=string[50];
  subGenero=1..8;
  pelicula=record
    codigo:integer;
    titulo:cadena;
    genero:subGenero;
    puntaje:real;
  end;
  lista=^nodo;
  
  nodo=record
    dato:pelicula;
    sig:lista;
  end;
  
  critica=record
    dni:integer;
    apeNom:cadena;
    codigo:integer;
    puntaje:real;
  end;

  vector=array[subGenero]of real;          //800

procedure cargaPeliculas(var listP:lista);                //se dispone

procedure inicializaVector(var vec:vector);
var
  i:subGenero;
begin
  for i:=1 to 8 do 
    vec[i]:=0;
end;

procedure actualiza(var lis:lista; var ve:vector);

  procedure leeCritica(var c:critica);
  begin
    readln(c.codigo);
    if(c.codigo <> -1)then begin
      readln(c.dni);
      readln(c.apeNom);
      readln(c.puntaje);
    end;
  end;
  
  procedure actualizaPuntaje(var l:lista;cr:critica;var v:vector);
  begin
    while(l <> nil)and(l^.dato.codigo <> cr.codigo)do
      l:= l^.sig;
    if(l <> nil)and(l^.dato.codigo = cr.codigo)then begin
      l^.dato.puntaje:= cr.puntaje;
      v[l^.dato.genero]:=v[l^.dato.genero] + cr.puntaje;
    end
    else
      writeln('No existe una pelicula con ese codigo de genero para actualizar el puntaje');
  end;
  
  function descomponeDNI(num:integer):boolean;
  var
    par:integer;
    impar:integer;
    dig:integer;
    cumple:boolean;
  begin
    par:=0;
    impar:=0;
    cumple:=false;
    while(num <> 0)do begin
      dig:= num mod 10;
      if(dig mod 2 = 0)then 
        par:= par+1
      else
        impar:= impar+1;
      num:= num div 10;
    end;
    if(impar = par)then
      cumple:=true;
    descomponeDNI:= cumple;
  end;
  
var 
  cri:critica;
  misma:integer;
begin
  leeCritica(cri);
  while(cri.codigo <> -1)do begin
     misma:=cri.codigo;
     while(cri.codigo <> -1)and(cri.codigo = misma)do begin
        actualizaPuntaje(lis,cri,ve);
        if(descomponeDNI(cri.dni))then
          writeln(cri.apeNom); 
        leeCritica(cri);
     end;
  end;
end;

procedure calculaMasGenero(vet:vector; var codi:integer);
var
  i:subGenero;
  max:real;
begin
  for i:=1 to 8 do begin
    if(vet[i] > max)then begin
      codi:=i;
      max:=vet[i];
    end;
  end;
end;

procedure eliminaPelicula(var li:lista; cod:integer);
var
  ant:lista;
  act:lista;
begin
  act:=li;
  ant:=li;
  while(act <> nil)and(li^.dato.codigo <> cod)do begin
    ant:=act;
    act:= act^.sig;
  end;
  if(act <> nil)and(li^.dato.codigo = cod)then begin
    if(ant = act)then
      li:=act^.sig
    else
      ant^.sig:=act^.sig;
    dispose(act);
  end
  else 
    writeln('No existe ninguna pelicula con ese codigo, por lo tanto no se pudo eliminar ningun elemento de la lista.');
end;

var                                                                                            //programa principal
  LP:lista;                             //4 bytes
  codigoEliminar:integer;               //6 bytes
  vecto:vector;                         //800 bytes
  codigoMas:subGenero;                  //6 bytes
begin                                  //MEMORIA ESTATICA = 816 bytes 
  LP:=nil;
  inicializaVector(vecto);
  cargaPeliculas(LP);
  actualiza(LP,vecto);                                                                         //INCISO A y C
  calculaMasGenero(vecto,codigoMas);
  writeln('Codigo del genero que obtuvo mayor puntaje entre todas las criticas: ',codigoMas);  //INCISO B
  readln(codigoEliminar);
  eliminaPelicula(LP,codigoEliminar);                                                          //INCISO D    
end.
