program tres;
type 
  lista=^nodo;
  viajes=record
    numeroViaje:integer;
    codigoAuto:integer;
    direccionOrigen:string;
    direccionDestino:string;
    kilometros:real;
  end;
  nodo=record
    dato:viajes;
    sig:lista;
  end;
procedure maximos (list:lista;cod1,cod2:integer);
var 
 max1,max2:real;
begin
  max1:=-1;
  max2:=-1;
  if(list^.dato.kilometros>max1)then begin
    max2:=max1;
    max1:=list^.dato.kilometros;
    cod2:=cod1;
    cod1:=list^.dato.codigoAuto;
  else
    if(list^.dato.kilometros>max2)then begin
       min1:=min2;
       min2:=list^.dato.kilometros;
       cod1:=cod2;
       cod2:=list^.dato.codigoAuto;
    end;
  end;
end;
procedure generaraNuevaLista (listita:lista)
var
 nueva,act,ant:lista
begin
  new(nueva);
  nueva^.dato:=listita^.dato;
  nueva^.sig:listita;
  if(listita=nil)then
    listita:=nueva;
    act:=listita;
    act:=listita;
  while ((act<>nil)and(act^.dato.numeroViaje>nueva^.dato.numeroViaje))do begin
    ant:=actual;
    act:=act^.sig;
  end;
  if(act=listita)then begin
    nuevo^.sig:=listita;
    listita:=nueva;
  else
    begin
      ant^.sig:=nueva;
      nueva^.sig:=act;
    end;
  end; 
end;
procedure procesarViajes (var lis:lista;codMax1;codMax2:integer);
var
 aux:lista;
begin
  aux:=lis;
  while(aux<>nil)do begin
    maximos(lis,codmax1,codmax2); //inciso A
    if(lis^.dato.kilometros>5)then 
       generarNuevaLista(l);       //inciso B
  end;
end;
var
 l:lista;
 codigoMaximo1,codigoMaximo2:integer;
begin
  Leer(l);
  procesarViajes(l,codigoMaximo1,codigoMaximo2);
  writeln('Autos que mas kilometros recorrieron:',codigoMaximo1,codigoMaximo2);
end;
