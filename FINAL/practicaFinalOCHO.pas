program ejFInal;
type
  subRango=1..7;
  cadena=String[50];
  tipofecha=record
    mes:cadena;
    dia:integer;
  end;
  transferencia=record
    numOrigen:integer;
    dniOrigen:integer;
    numDestino:integer;
    dniDestino:integer;
    fecha:tipoFecha;
    hora:integer;
    monto:real;
    motivo:subRango;
  end;
  lista=^nodo;
  nodo=record
    dato:transferencia;
    sig:lista;
  end;
  
  vecMotivos:array[subRango]of integer;      //42 bytes

procedure inicializa(var ve:vecMotivos);
var
  i:subRango;
begin
  for i:=1 to 7 do 
    ve[i]:=0;
end;

procedure cargaTransferencias(var lt:lista);                                       //se dispone
 
procedure generaEstructura(lisTransfer:lista;var lis:lista);

  procedure insertaOrdenado(var ln:lista; tra:transferencia);
  var
    ant,act,nue:lista;
  begin
    ant:=ln;
    act:=ln;
    new(nue);
    nue^.dato:=tra;
    nue^.sig:=nil;
    while(act <> nil)and(act^.dato.numOrigen < tra.numOrigen)do begin
       ant:=act;
       act:=act^.sig;
    end;
    if(act <> nil)then begin
      if(act = ant)then
        ln:=nue
      else
        ant^.sig:=nue;
      nue^.sig:=act;
    end;
  end;
  
begin
  while(lisTransfer <> nil)do begin
     if(lisTransfer^.dato.dniOrigen <> lisTransfer^.dato.dniDestino)then 
         insertaOrdenado(lis,lisTransfer^.dato);
     lisTransfer:= lisTransfer^.sig;
  end;
end;

procedure procesaEstructura(l:lista;var ve:vecMotivos;var codiMas:subRango;var cantJunio:integer);

  procedure calculaMasCodigo(vt:veMotivos;var cod:subRango);
  var
    i:subRango;
    max:integer;
  begin
    max:=-1;
    for i:=1 to 7 do begin
      if(vt[i] > max)then begin
         cod:=i;
         max:=vt[i];
      end;
  end;
  
  function descomponeNumero (num:integer):boolean;
  var
    par:integer;
    impar:integer;
    dig:integer;
    cumple:boolean;
  begin
    cumple:= true;
    par:=0;
    impar:=0;
    while(num <> 0)do begin
      dig:= num mod 10;
      if(dig mod 2 = 0)then 
         par:= par+1
      else 
        impar:= impar+1;
      num:= num div 10;
    end;
    if(par < impar)then
      cumple:=true;
    descomponeNumero:= cumple; 
  end;
  
var
  mismo:integer;
  montoTotal:real;
begin
  while(l <> nil)do begin
    mismo:=l^.dato.numOrigen;
    montoTotal:=0;
    while(l <> nil)and(l^.dato.numOrigen = mismo)do begin
       montoTotal:= montoTotal + l^.dato.monto;
       ve[l^.dato.motivo]:= ve[l^.dato.motivo]+1;
       if(l^.dato.fecha.mes = 'JUNIO')then begin
         if(descomponeNumero(l^.dato.numDestino))then
            cantJunio:= cantJunio+1;
       end;
       l:=l^.sig;
    end;
    writeln('El monto total facturado de la cuenta de Origen: ',l^.dato.numOrige,' es de ',montoTotal);       //inciso B
  end;
  calculaMasCodigo(ve,codiMas);
end;

var                                                         //programa principal
  listaTransfer:lista;             //4 bytes
  list:lista;                      //4 bytes
  vect:vecMotivos;                 //42 bytes
  codigoMas:subRango;              //6 bytes
  cantidadJunio:integer;           //6 bytes
begin                              //MEMORIA ESTATICA = 62 bytes
  cantidadJunio:=0;
  codigoMas:=0;
  list:=lista;
  listaTransfer:=nil;
  inicializa(vect);
  cargaTransferencias(listaTransfer);                                               //se dispone
  generaEstructura(listaTransfer,list);                                             //inciso A
  procesaEstructura(list,vect,codigoMas,cantidadJunio);
  writeln('Codigo de motivo que mas transferencias a terceros tuvo: ',codigoMas);   //inciso C
  writeln('INCISO D ',cantidadJunio);                                               //Inciso D
end.
