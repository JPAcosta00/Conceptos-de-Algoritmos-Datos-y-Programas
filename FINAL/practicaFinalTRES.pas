program ejFinal;
type
  cadena=string[50];
  
  viaje=record
    numero:integer;
    codigoAuto:integer;
    direccionOrigen:cadena;
    direccionDestino:cadena;
    kilometros:real;
  end;
  lista= ^nodo;
  nodo=record
    dato:viaje;
    sig:lista;
  end; 
  
  listado= ^nodo1;
  nodo1=record
    dato:viaje;
    sig:listado;
  end;

procedure cargaListaViajes(var ele:lista);                                                                 //se dispone

procedure procesaInformacion(l:lista;var lisNueva:listado; var co1,co2:integer);

  procedure calculaMasKilometros(var m1,m2:real; codAuto:integer;var codi1,codi2:integer;kms:real);
  begin
    if(kms > m1)then begin
      codi2:=codi1;
      codi1:=codAuto;
      m2:=m1;
      m1:=kms;
    end
    else begin
      if(kms > m2)then begin
          codi2:=codAuto;
          m2:=kms;
      end;
    end;
  end;
  
  procedure insertaOrdenado(var ln:listado; vi:viaje);
  var
    ant,act,nue:listado;
  begin
    ant:=ln;
    act:=ln;
    new(nue);
    nue^.dato:=vi;
    nue^.sig:=nil;
    while(act <> nil)and(act^.dato.numero < vi.numero)do begin
      ant:=act;
      act:=act^.sig;
    end;
    if(ant = act)then
      ln:=nue
    else
      ant^.sig:=nue;
    nue^.sig:=act;
  end;
  
var
  mismo:integer;
  km:real;
  max1,max2:real;
begin
  max1:=-1;
  max2:=-1;
  while(l <> nil)do begin
    mismo:= l^.dato.codigoAuto;
    km:=0;
    while(l <> nil)and(l^.dato.codigoAuto = mismo)do begin
       km:= km + l^.dato.kilometros;
       if(l^.dato.kilometros > 5 )then
         insertaOrdenado(lisNueva,l^.dato);
       l:=l^.sig;
    end;
    calculaMasKilometros(max1,max2,l^.dato.codigoAuto,co1,co1,km);
  end;
end;

var                                                                                                 //programa principal
  list:lista;                    //4 bytes
  nueva:listado;                 //4 bytes
  cod1,cod2:integer;             //12 bytes
begin                            //MEMORIA ESTATICA = 20 bytes
  cod1:=0;
  cod2:=0;
  nueva:=nil;
  list:=nil;
  cargaListaViajes(list);                                                                          //se dispone
  procesaInformacion(list,nueva,cod1,cod2);
end.
