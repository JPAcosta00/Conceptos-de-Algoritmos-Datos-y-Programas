program ejFInal;
type
  cadena=string[50];
  vecNotas=array[1..24]of integer;
  alumno=record
    numero:integer;
    apellido:cadena;
    nombres:cadena;
    correo:cadena;
    añoIngreso:integer;
    añoEgreso:integer;
    notas:vecNotas;
    dimL:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:alumno;
    sig:lista;
  end;
procedure cargaEgresados(var lis:lista);

  procedure leeAlumno(var a:alumno);
  
    procedure agregaVector(var ve:vecNotas;var dimen:integer;numero:integer);
    var
      pos,i:integer;
    begin
      pos:=1;
      while((pos =< dimen)and(ve[pos] < numero))do
         pos:=pos+1;
      if(pos >= 1)and(pos < dimen)then begin
          for i:= dimen downto pos do 
            ve[i+1]:= ve[i];
          ve[pos]:=numero;
          dimen:= dimen+1;
      end;
    end;
    
  var
    i:integer;
    nota:integer;
  begin
    writeln('Ingrese un numero de alumno');
    readln(a.numero);
    if(a.numero <> -1)then begin
      writeln('Ingrese el apellido del alumno');
      readln(a.apellido);
      writeln('Ingrese los nombres del alumno');
      readln(a.nombres);
      writeln('Ingrese el correo electronico del alumno');
      readln(a.correo);
      writeln('Ingrese el año de ingreso del alumno a la facultad');
      readln(a.añoIngreso);
      writeln('Ingrese el año de ingreso del alumno');
      readln(a.añoEgreso);
      a.dimL:=0;
      for i:=1 to 24 do begin
        writeln('Ingrese la nota de la materia ', i);
        readln(nota);
        if(nota > 4)then
          agregaVector(a.notas,a.dimL,nota);
      end;
    end;
  end;
  
  procedure agregaAdelante(var li:lista; al:alumno);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=al;
    nue^.sig:=li;
    li:=nue;
  end;
  
var
  alu:alumno;
begin
  leeAlumno(alu);
  while(alu.numero <> -1)do begin
    agregaAdelante(lis,alu);
    leeAlumno(alu);
  end;
end;  
  
procedure procesaEgresados(l:lista);

  function calculaPromedio(v:vecNotas;dl:integer):real;
  var
    i:integer;
    aux:real;
  begin
    aux:=0;
    for i:= 1 to dl do 
      aux:= aux + v[i];
    aux:= aux/dl;
    calculaPromedio:=aux;
  end;
  
  function descompone(num:integer):boolean;
  var
    impar:integer;
    dig:integer;
    cant:integer;
    cumple:boolean;
  begin
    cumple:=false;
    impar:=0;
    cant:=0;
    while(num <> 0)do begin
      cant:= cant+1;
      dig:=num mod 10;
      if(dig mod 2 <> 0)then
        impar:= impar+1;
      num:= num div 10;
    end;
    if(impar = cant)then
       cumple:=true;
    descompone:=cumple;
  end;
  
  procedure calculaDosMas(anti:integer;apellido:cadena;nombre:cadena;correo:cadena;var no1,no2,ap1,ap2,co1,co2:cadena;var mini1,mini2:integer);
  begin
    if(anti < mini1)then begin
      no2:=no1;
      no1:=nombre;
      ap2:=ap1;
      ap1:=apellido;
      co2:=co1;
      co1:=correo;
      mini2:=mini1;
      mini1:=anti;
    end
    else begin
      if(anti < mini2)then begin
         no2:=nombre;
         ap2:=apellido;
         co2:=correo;
         mini2:=anti;
      end;
    end;
  end;
  
var
  promedio:real;
  cantidad:integer;
  nom1,nom2:cadena;
  ape1,ape2:cadena;
  correo1,correo2:cadena;
  min1,min2:integer;
  antiguedad:integer;
begin
  min1:=9999;
  min2=9999;
  cantidad:=0;
  while(l <> nil)do begin
    promedio:= calculaPromedio(l^.dato.notas,l^.dato.dimL);
    writeln('Promedio de notas del alumno: ', l^.dato.numero, ' = ', promedio);                
    if(l^.dato.añoIngreso = 2012)then begin
       if(descompone(l^.dato.numero))then 
          cantidad:= cantidad+1;
    end;
    antiguedad:= l^.dato.añoEgreso - l^.dato.añoIngreso;
    calculaDosMas(antiguedad,l^.dato.apellido,l^.dato.nombres,l^.dato.correo,nom1,nom2,ape1,ape2,correo1,correo2,min1,min2);
    l:=l^.sig;
  end;
  writeln('INCISO 2B',cantidad);
  writeln('INCISO 2C',nom1,ape1,correo1,nom2,ape2,correo2);
end;

procedure eliminaAlumno(var li:lista;numA:integer);
var
  ant,act:lista;
begin
  ant:=li;
  act:=li;
  while(act <> nil)and(act^.dato.numero <> numA)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act <> nil)and(act^.dato.numero = numA)then
     if(ant = act)then
       li:=act^.sig
     else
       ant^.sig:=act^.sig;
     dispose(act);
     writeln('Alumno eliminado correctamente.');
  else
    writeln('No se encontro un alumno con ese numero.'); 

end;

var                                                                           //programa principal
  list:lista;                 //4 bytes
  numAlumno:integer;          //6 bytes
begin                        //MEMORIA ESTATICA = 10 bytes
  list:=nil;
  cargaEgresados(list);                                                       //inciso 1
  procesaEgresados(list);                                                     //inciso 2 A,B,C
  writeln('Ingrese un numero de alumno a eliminar');
  readln(numAlumno);
  eliminaAlumno(list,numAlumno);                                              //inciso 3
end.
