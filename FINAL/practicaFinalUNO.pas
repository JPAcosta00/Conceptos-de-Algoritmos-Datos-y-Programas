program practicaX;
type
  cadena=String[50];
  subCodigo=1..5;
  persona = record
    dni:integer;
    apeNom:cadena;
    edad:integer;
    codigo:subCodigo;
  end;
  lista=^nodo;
  nodo=record 
    dato:persona;
    sig:lista;
  end;
  vector=array[1..5] of integer;               //30 bytes

procedure inicializa(var ve:vector);
var 
  i:subCodigo;
begin
  for i:= 1 to 5 do 
    ve[i]:=0;
end;
procedure cargaInformacion (var li:lista);

  procedure leePersona(var p:persona);
  begin
    writeln('Ingrese un DNI');
    readln(p.dni);
    writeln('Ingrese un codigo');
    readln(p.codigo);
    writeln('Ingrese un Nombre y Apellido');
    readln(p.apeNom);
    writeln('Ingrese la edad');
    readln(p.edad);
    writeln('--------------------------');
  end;
  
  procedure agregaAdelante(var l:lista; pe:persona);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=pe;
    nue^.sig:=l;
    l:=nue;
  end;
  
var
  per:persona;
begin
  repeat 
    leePersona(per);
    agregaAdelante(li,per);
  until (per.dni = 0);
end;

procedure procesaInformacion (ele:lista;var v:vector;var canti:integer);

  function descompone (docu:integer):boolean;
  var
    cumple:boolean;
    dig:integer;
    par,impar:integer;
  begin
    par:=0;
    impar:=0;
    cumple:=false;
    while(docu <> 0)do begin
      dig:= docu mod 10;
      if(dig mod 2 = 0)then 
        par:= par+1
      else
        impar:= impar+1;
      docu:= docu div 10;
    end;
    if(par > impar)then 
      cumple:=true; 
    descompone:=cumple;
  end;
  
begin
  while(ele <> nil)do begin
    if(descompone (ele^.dato.dni))then 
      canti:=canti+1;
    v[ele^.dato.codigo]:=v[ele^.dato.codigo]+1;
    ele:=ele^.sig;
  end;
end;

procedure informaDosMas (vet:vector);
var
  cod1,cod2:subCodigo;
  i:subCodigo;
  max1,max2:integer;
begin
  max1:=-1;
  max2:=-1;
  cod1:=1;
  cod2:=1;
  for i:= 1 to 5 do begin
    if(vet[i] > max1)then begin
      cod2:=cod1;
      cod1:=i;
      max2:=max1;
      max1:=vet[i];
    end
    else
      if(vet[i] > max2)then begin
         cod2:=i;
         max2:=vet[i];
      end;
  end;
  writeln('Los DOS codigos de genero mas elegidos son: ', cod1,' y ',cod2);
end;

procedure elimina (var lis:lista; num:integer);
var
  ant,act:lista;
begin
  ant:=lis;
  act:=lis;
  while(lis <> nil)and(act^.dato.dni <> num) do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act <> nil)then begin
    if(ant = act)then
       lis:= act^.sig
    else
      ant^.sig:=act^.sig;
    dispose(act);
  end
  else 
    writeln('No existe una persona con ese DNI.')
end;

var                                               //programa principal
  vect:vector;                    //30 bytes
  list:lista;                     //4 bytes
  cantidad:integer;               //6 bytes
  dni:integer;                    //6 bytes
begin                             //MEMORIA ESTATICA = 46 bytes
  cantidad:=0;
  list:=nil;
  inicializa(vect);
  cargaInformacion(list);                          
  procesaInformacion(list,vect,cantidad);
  writeln(cantidad);                                 //Inciso A
  informaDosMas(vect);                               //Inciso B
  writeln('Ingrese un DNI a eliminar de la lista de personas para el casting ');
  readln(dni);
  elimina(list,dni);                                 //Inciso C
end. 
