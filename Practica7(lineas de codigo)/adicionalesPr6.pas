program adicional15;
type
  alumno=record
    dni:integer;
    apellido:string;
    nombre:string;
    nota:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:alumno;
    sig:lista;
  end;
procedure crearTurno1(var T14:lista;A:alumnos);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=A;
  nue^.sig:=T14;
end;
procedure crearTurno2(var T235:lista;Al:alumnos);
var
  nueva:lista;
begin
  new(nueva);
  nueva^.dato:=Al;
  Nueva^.sig:=T235;
end;
procedure procesarAlumnos(l:lista;var T14,T235:lista);
var 
  a:alumnos;
begin
   while(l<>nil)do begin
     crearTurno1(T14,a);
     crearTurno2(T235,a);
     if(l^.dato.nota>=8)then 
        T14^.dato:=l^.dato;
     if((l^.dato.nota=5)or(l^.dato.nota=6)or(l^.dato.nota=7)or(l^.dato.nota=8))then
        T235^.dato:=l^.dato;
     l:=l^.sig;
   end;
end;
procedure imprimirTurno1a4(T14:lista);
begin
  while(T14<>nil)do begin
    writeln(T14^.dato);
    T14:=T14^.sig;
  end;
end;
procedure imprimirTurno235(T235:lista);
begin
  while(T235<>nil)do begin
    writeln(T235^.dato);
    T235:=T235^.sig;
  end;
end;
var
  l,T14,T235:lista;
begin
  T24:=nil;
  T235:=nil;
  l:=nil;                           //se dispone
  procesarAlumnos(l,T14,T235);
  imprimirTurno1a4(T14);
  imprimirTurno235(T235);
end;
