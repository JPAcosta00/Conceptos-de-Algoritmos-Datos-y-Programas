program ejFinal;
type
  subRango=1..12;
  cadena=string[50];
  publicacion=record
    titulo:cadena;
    autor:cadena;
    dni:integer;
    tipo:subRango;
  end;
  
  vector=array[subRango]of integer;

procedure inicializa(var vec:vector);
var
  i:subRango;
begin
  for i:= 1 to 12 do 
    vec[i]:=0;
end;

procedure procesaPublicaciones(var v:vector);
  
  procedure leePublicacion(var p:publicacion);
  begin
    readln(p.dni);
    if(p.dni <> 0)then begin
      readln(p.autor);
      readln(p.tipo);
      readln(p.titulo);
    end;
  end;
  
var
  mismo:integer;
  pu:publicacion;
  cantidad:integer;
begin
  leePublicacion(pu);
  while(pu.dni <> 0)do begin
    mismo:=pu.dni;
    cantidad:=0;
    while(pu.dni <> 0)and(pu.dni = mismo)do begin
      v[pu.tipo]:= v[pu.tipo]+1;
      cantidad:=cantidad+1;
      leePublicacion(pu);
    end;
    writeln('AUTOR: ', pu.autor, ' = ', cantidad);
  end;
end;

procedure calculaMasTipo(ve:vector; var masTipo:subRango);
var
  max:integer;
  i:subRango;
begin
  max:=-1;
  for i:=1 to 12 do begin
    if(ve[i] > max)then begin
       masTipo:=i;
       max:=ve[i];
    end;
  end;
end;

var                         //programa principal
  vecto:vector;
  tipoMas:subRango;
begin
  inicializa(vecto);
  procesaPublicaciones(vecto);
  calculaMasTipo(vecto,tipoMas);
end.
