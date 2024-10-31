program ejFinal;
type
  subRango=1..31
  vector=array[subRango]of integer;              //31 x 6
  prestamo=record
    nroPrestamo:integer;
    isbn:integer;
    nroSocio:integer;
    dia:subRango;
  end;
  
  info=record
    isbn:integer;
    cantidad:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:info;
    sig:lista;
  end;
  
procedure inicializaContador(var vec:vector);
var
  i:subRango;
begin
  for i:= 1 to 31 do 
    vec[i]:=0;
end;

procedure cargaInformacion(var lis:lista;var ve:vector,var par,imp:real);

  procedure leePrestamo(var p:prestamo);
  begin
    readln(p.isbn);
    if(p.isbn <> -1)then begin
      readln(p.nroPrestamo);
      readln(p.nroSocio);
      readln(p.dia);
    end;
  end;
  
  procedure agregaOrdenado(isbn:integer;cant:integer;var li:lista);
  var
    ant,act,nue:lista;
  begin
    new(nue);
    nue^.dato.isbn:=isbn;
    nue^.dato.cantidad:=cant;
    ant:=li;
    act:=li;
    while(act <> nil)and(act^.dato.isbn < isbn)do begin
      ant:=act;
      act:=act^.sig;
    end;
    if(act = ant)then
      li:=nue
    else
      ant^.sig:=nue;
    nue^.sig:=act; 
  end;
  
var
  pre:prestamo;
  mismo:integer;
  cuenta:integer;
  total:integer;
begin
  total:=0;
  leePrestamo(pre);
  while(pre.isbn <> -1)do begin
    mismo:=pre.isbn;
    cuenta:=0;
    while(pre.isbn <> -1)and(pre.isbn = mismo)do begin
       cuenta:=cuenta+1;
       ve[pre.dia]:=ve[pre.dia]+1;
       if(pre.nroPrestamo mod 2 = 0)then
         par:= par+1
       else 
         impar:= impar+1;
       total:= total+1;
    end;
    agregaOrdenado(pre.isbn,cuenta,lis);
    par:= par * 100/total;
    impar:= impar * 100/total;
  end;
end;

procedure calculaDiaMenosPrestamos(v:vector; var dia:subRango);
var
  i:subRango;
  min:integer;
begin
  min:=9999;
  for i:= 1 to 31 do begin
    if(v[i] < min )then begin
      dia:= i;
      min:= v[i];
    end;
  end;
end;

var                                                                     //programa principal.
  list:lista;                             //4 bytes
  vecto:vector;                           //186 bytes
  diaMenos:subRango;                      //6 bytes
  porpar,porimp:real;                     //20 bytes      
begin                                     //MEMORIA ESTATICA = 216 bytes
  porpar:=0;
  porimp:=0;
  list:=nil;
  inicializaContador(vecto);
  cargaInformacion(list,vecto,porpar,porimp);                       //Inciso A
  calculaDiaMenosPrestamos(vecto,diaMenos);
  writeln('Porcentaje de prestamos con numero de prestamos pares: ', porpar, 'Porcentaje de prestamos con numero de prestamos impares: ', porimp);  //Inciso C
  writeln('Dia del mes que se realizaron menos prestamos: ', diaMenos);                                                                             //Inciso B
end.
