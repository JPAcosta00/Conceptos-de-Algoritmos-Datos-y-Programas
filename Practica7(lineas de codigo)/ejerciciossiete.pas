program siete;
type
  rango=0..10;
  notas=array[1..24]of rango;
  informacion=record
    numAlumno:integer;
    apellido:string;
    nombres:string;
    correo:string;
    anioIngreso:integer;
    anioEgreso:integer;
    nota:notas;
  end;
  lista=^nodo;
  nodo=record
    dato:informacion;
    sig:lista;
  end;
procedure inicializar(var note:notas);
var
  i:integer;
begin
  for i:=1 to 24 do begin
    note[i]:=0;
  end;
end;
procedure leerNota(var no:notas;informa:informacion);
var
  i,notaX:integer;
begin
  readln(notaX);
  for i:=1 to 24 do begin
    no[i]:=notaX;
  end;
end;
procedure crearNodo(var lis:lista;inf:informacion;ne:notas);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=inf;
  nue^.sig:=lis;
end;
procedure leerAlumno(var li:lista);
var
  n:notas;
  info:informacion;
begin
  inicializar(n);
  readln(info.numAlumno);
  while(info.numAlumno<>-1)do begin
    readln(info.apellido);
    readln(info.nombres);
    readln(info.correo);
    readln(info.anioIngreso);
    readln(info.anioEgreso);
    leerNota(n,info);
    readln(info.numAlumno);
  end;
  crearNodo(li,info,n);
end;
procedure promedio(var promedio:integer);
var
  vect:notas;
  suma,i:integer;
begin
  suma:=0;
  inicializar(vect);
  for i:=1 to 24 do begin
    if(vect[i]<>0)then 
     suma:=suma+vect[i];
  end;
  promedio:=suma div 24;
end;
function numDigImpares(listarda:lista):boolean;
var
  cumple:boolean;
begin
  cumple:=false;
  while(listarda^.dato.numAlumno<>0)do begin
     if(listarda^.dato.numAlumno mod 10<>0)then
        cumple:=true;
     listarda^.dato.numAlumno:=listarda^.dato.numAlumno div 10;
  end;
  numDigImpares:=cumple;
end;
procedure masRapidos(liste:lista;var correo1,correo2,nombre1,nombre2,ap1,ap2:string);
var
  max1,max2,menos:integer;
begin
  max1:=-1;
  max2:=-1;
  menos:=liste^.dato.anioEgreso-liste^.dato.anioIngreso;
  if(menos>max1)then begin
    max2:=max1;
    max1:=menos;
    correo2:=correo1;
    correo1:=liste^.dato.correo;
    nombre2:=nombre1;
    nombre1:=liste^.dato.nombres;
    ap2:=ap1;
    ap1:=liste^.dato.apellido;
  end
  else
    if(menos>max2)then begin
       max1:=max2;
       max2:=menos;
       correo1:=correo2;
       correo2:=liste^.dato.correo;
       nombre1:=nombre2;
       nombre2:=liste^.dato.nombres;
       ap1:=ap2;
       ap2:=liste^.dato.apellido;
    end;
end;
procedure calcularAlumnos(list:lista;cant:integer);
var
  promedioAlumno:integer;
  corre1,corre2,nom1,nom2,ape1,ape2:string;
begin
  cant:=0;
  while(list<>nil)do begin
    promedio(promedioAlumno);                                            //inciso 2A
    if((list^.dato.anioIngreso=2012)and(numDigImpares(list)=true))then begin       //inciso 2B
      cant:=cant+1;
    end;
    masRapidos(list,corre1,corre2,nom1,nom2,ape1,ape2);
    writeln('Promedio de notas del Alumno:',promedioAlumno);
    list:=list^.sig;
  end;
end;
procedure eliminarAlumno(var elista:lista);
var
  act,ant:lista;
  alumno:integer;
begin
  act:=elista;
  writeln('ingrese un numero de alumno');
  readln(alumno);
  while(act<>nil)do begin
    if(act^.dato.numAlumno<>alumno)then begin
      ant:=act;
      act:=act^.sig;
    end
    else
      begin
        if(act<>nil)then begin
           if(act=elista)then
              elista:=elista^.sig
           else
             ant^.sig:=act^.sig;
        dispose(act);
        act:=ant;
        end;
      end;
    end;
end;
var
 l:lista;
 cantidad:integer;
 Correo1,Correo2,Nombre1,Nombre2,Apellido1,Apellido2:string;
begin
  l:=nil;
  cantidad:=0;
  leerAlumno(l);                                                        //inciso 1
  calcularAlumnos(l,cantidad);                                          //inciso 2
  writeln('Cantidad de alumnos que ingresaron en el año 2012 y su numero de alumnos contiene solo numeros impares:',cant);
  writeln('Nombres,Apellidos y direcciones de correo electronico que los dos alumnos que mas rapido se recibieron:',Correo1,Correo2,Nombre1,Nombre2,Apellido1,Apellido2);
  eliminarAlumno(l);
end.
