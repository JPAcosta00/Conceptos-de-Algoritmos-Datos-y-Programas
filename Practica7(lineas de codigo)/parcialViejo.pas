program estancias;
type 
  subRango:1..23;
  cadena:string[20];
  estancia=record
   cod:integer;
   localidad:cadena;
   codProvincia:subRango;
   cant:integer;
  end;
  lista:^.nodo;
  nodo=record 
    dato:estancia;
    sig:lista;
  end;
procedure agregarAdelante(var l:lista;estan:estancia);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=estan;
  nue^.sig:=l;
  l:=nue;
end;
procedure leerEstancia(var est:estancia);
begin
  readln(est.cod);
  if(est.cod<>0)then begin
    readln(est.localidad);
    readln(est.codProvincia);
    readln(est.cant);
  end;
end;
procedure cargaInformacion(var li:lista);
var
  es:estancia;
begin 
  leerEstancia(es);
  while(es.cod<>0)do begin  
    agregarAdelante(li,es);
    leerEstancia(es);
  end;
end;
function cod234(ele:lista):boolean;
var 
  cumple:boolean;
begin
  cumple:=false;
  while(ele<>nil)do begin
    if(ele^.cod=234)then 
      cumple:=true;
    ele:=ele^.sig;
  end;
  cod234:=cumple;
end;
procedure calculaDOS(list:lista);
var
  max1,max2:integer;
  cod1,cod2:subRango;
begin
  max1:=-1;
  max2:=-1;
  cod1:=0;
  cod2:=0;
  while(list<>nil)do begin 
    if(list^.dato.cant>max1)then begin 
      cod2:=cod1;
      cod1:=list^.dato.codProvincia;
      max2:=max1;
      max1:=list^.dato.cant;
    else 
      if(list^.dato.cant>max2)then begin
         cod2:=list^.dato.codProvincia;
         max2:=list^.dato.cant;
      end;
    end;
     list:=list^.sig;
  end;
end;
var
  lis:lista;
begin
  lis:=nil;
  cargaInformacion(lis);                                                 //inciso 1
  cod234(lis);                                                           //inciso 2
  calculaDOS(lis);                                                       //inciso 3
end.